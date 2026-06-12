""" Generar data para el ejercicio 1 """

#%%
from collections import defaultdict
import pandas as pd
import numpy as np
import itertools

variables = {
    "provincia": [
        "Buenos Aires",
        "CABA",
        "Catamarca",
        "Chaco",
        "Chubut",
        "Córdoba",
        "Corrientes",
        "Entre Ríos",
        "Formosa",
        "Jujuy",
        "La Pampa",
        "La Rioja",
        "Mendoza",
        "Misiones",
        "Neuquén",
        "Río Negro",
        "Salta",
        "San Juan",
        "San Luis",
        "Santa Cruz",
        "Santa Fe",
        "Santiago del Estero",
        "Tierra del Fuego",
        "Tucumán"
    ],
    "centro_de_salud_cercano":["True", "False"],
    "estadio_al_momento_de_diagnostica":["I", "II", "III", "IV"],
    "consulta_en_el_ano_previo_al_diagnostico":["True", "False"],
    "cobertura_de_salud": ["Publico", "Proveedor A", "Proveedor B", "Proveedor C"],
    "edad": ["menos_de_40", "entre_40_y_50", "entre_50_y_60", "mas_de_60"],
    "comorbilidad_cardiaca":["True", "False"],
    "comorbilidad_sistema_digestivo":["True", "False"],
    "comorbilidad_sistema_endocrino":["True", "False"],
    "tamano_tumor": ["pequeno", "mediano", "grande"],
    "estado_nodos_linfatico": ["positivo", "negativo"],
    "estado_receptor_hormonas": ["ER", "PR", "ER/PR", "Ninguno"],
    "grado_diferenciacion_tumor": ["bajo", "medio", "alto"]
}
# %%

def build_independent_data(data: pd.DataFrame, n: int) -> pd.DataFrame:
    """
    data: DataFrame con columnas:
        - "var": nombre de la variable
        - "val": categoría
        - "frq": probabilidad (que suma 1 dentro de cada var)
    n: número de muestras a generar por variable

    Devuelve:
        DataFrame de shape (n, n_vars),
        una columna por variable, con tiradas independientes.
    """
    cols: dict[str, np.ndarray] = {}

    for var, df_var in data.groupby("var"):
        assert isinstance(var, str)
        # Aseguramos que frq suma 1 por si acaso
        probs = df_var["frq"].to_numpy(dtype=float)
        probs = probs / probs.sum()

        vals = df_var["val"].to_numpy()
        cols[var] = np.random.choice(vals, p=probs, size=n)

    return pd.DataFrame(cols)


# %%

data = pd.read_csv(
    "freqs.txt",
    header=None,
).set_axis(
    ["var", "val", "frq"],
    axis=1
)
# %%

base_data = build_independent_data(data, 1500)
# %%
from scipy.stats import chisquare

import pandas as pd
import numpy as np

def permutar_elementos(
    s: pd.Series,
    k: int = 10,
    p: float = 0.05,
    modo: str = "otro"
) -> pd.Series:
    """
    Devuelve una copia de la serie `s` donde:
    - k elementos han sido permutados entre sí
    - con probabilidad p se reemplaza el valor de un elemento
    modos:
        "otro": reemplaza por otro valor distinto dentro de la serie
        "aleatorio": reemplaza por un valor aleatorio de la serie (puede ser igual)
    """
    s2 = s.copy()

    # ===============================
    # 1) Permutación de k elementos
    # ===============================
    idx_perm = np.random.choice(s.index, size=k, replace=False)
    s2.loc[idx_perm] = np.random.permutation(s.loc[idx_perm].to_numpy())


    # ===============================
    # 2) Mutación con probabilidad p
    # ===============================
    valores = s.unique()
    valores_set = set(valores)

    # Para cada índice decidimos si cambiar o no el valor
    for i in s2.index:
        if np.random.rand() < p:     # condición de probabilidad
            if modo == "otro":
                # Elegimos un valor distinto del actual
                actuales = valores_set - {s2.loc[i]}
                s2.loc[i] = np.random.choice(list(actuales))
            elif modo == "aleatorio":
                # Elegimos un valor cualquiera
                s2.loc[i] = np.random.choice(valores)
            else:
                raise ValueError("modo debe ser 'otro' o 'aleatorio'.")

    return s2

def calc_corr(v1, v2, var_name1, var_name2, target):
    _, table = st.contingency.crosstab(
        v1,
        v2,
        levels=(var_name1, var_name2)
    )
    assert isinstance(table, np.ndarray)
    return np.corrcoef(target.flatten(), table.flatten())[0, 1]


def asociate(
    var1:pd.Series,
    var2:pd.Series,
    var_name1: list[str],
    var_name2: list[str],
    target:np.ndarray,
    iters = 100,
    n_candidates = 10
):
    v2 = var2.copy()
    for _ in range(iters):
        candidates = [ permutar_elementos(v2) for _ in range(n_candidates) ] + [v2]
        cor_candidates = [
            calc_corr(var1, x, var_name1, var_name2, target) for x in candidates
        ]
        max = np.argmax(cor_candidates)
        v2 = candidates[max]
    print(cor_candidates[max])
    return v2

import scipy.stats as st

# (a) Provincia ↔ cobertura_de_salud
# Muy fuerte. La cobertura varía fuertemente por región:
# Buenos Aires / CABA → más afiliados privados
# Provincias del NOA/NEA → más cobertura pública
# Patagonia → más mezcla público/privado
p_cobertura_by_prov = np.array([
    [0.50, 0.15, 0.20, 0.15],  # Buenos Aires
    [0.40, 0.20, 0.25, 0.15],  # CABA
    [0.70, 0.10, 0.12, 0.08],  # Catamarca
    [0.70, 0.10, 0.12, 0.08],  # Chaco
    [0.55, 0.12, 0.18, 0.15],  # Chubut
    [0.50, 0.15, 0.20, 0.15],  # Córdoba
    [0.70, 0.10, 0.12, 0.08],  # Corrientes
    [0.55, 0.12, 0.18, 0.15],  # Entre Ríos
    [0.70, 0.10, 0.12, 0.08],  # Formosa
    [0.70, 0.10, 0.12, 0.08],  # Jujuy
    [0.55, 0.12, 0.18, 0.15],  # La Pampa
    [0.70, 0.10, 0.12, 0.08],  # La Rioja
    [0.50, 0.15, 0.20, 0.15],  # Mendoza
    [0.70, 0.10, 0.12, 0.08],  # Misiones
    [0.55, 0.12, 0.18, 0.15],  # Neuquén
    [0.55, 0.12, 0.18, 0.15],  # Río Negro
    [0.70, 0.10, 0.12, 0.08],  # Salta
    [0.70, 0.10, 0.12, 0.08],  # San Juan
    [0.55, 0.12, 0.18, 0.15],  # San Luis
    [0.55, 0.12, 0.18, 0.15],  # Santa Cruz
    [0.50, 0.15, 0.20, 0.15],  # Santa Fe
    [0.70, 0.10, 0.12, 0.08],  # Santiago del Estero
    [0.55, 0.12, 0.18, 0.15],  # Tierra del Fuego
    [0.70, 0.10, 0.12, 0.08],  # Tucumán
])

new_cobertura = asociate(
    base_data.provincia,
    base_data.cobertura_de_salud,
    variables["provincia"],
    variables["cobertura_de_salud"],
    p_cobertura_by_prov,
    iters=100,
    n_candidates=10
)
base_data.cobertura_de_salud = new_cobertura

# (b) Provincia ↔ centro_de_salud_cercano
# Regiones densamente pobladas (CABA, AMBA, Córdoba, Santa Fe) → más “True”.
# Regiones rurales (Formosa, Catamarca, Santiago del Estero) → más “False”.

p_centro_cercano_by_prov = np.array([
    [0.95, 0.05],  # Buenos Aires
    [0.99, 0.01],  # CABA
    [0.70, 0.30],  # Catamarca
    [0.70, 0.30],  # Chaco
    [0.55, 0.45],  # Chubut
    [0.90, 0.10],  # Córdoba
    [0.70, 0.40],  # Corrientes
    [0.55, 0.45],  # Entre Ríos
    [0.70, 0.30],  # Formosa
    [0.70, 0.30],  # Jujuy
    [0.55, 0.45],  # La Pampa
    [0.70, 0.30],  # La Rioja
    [0.50, 0.50],  # Mendoza
    [0.70, 0.30],  # Misiones
    [0.55, 0.45],  # Neuquén
    [0.75, 0.25],  # Río Negro
    [0.70, 0.30],  # Salta
    [0.70, 0.30],  # San Juan
    [0.55, 0.45],  # San Luis
    [0.55, 0.45],  # Santa Cruz
    [0.90, 0.10],  # Santa Fe
    [0.70, 0.10],  # Santiago del Estero
    [0.80, 0.20],  # Tierra del Fuego
    [0.70, 0.10],  # Tucumán
])

new_centro_cercano = asociate(
    base_data.provincia,
    base_data.centro_de_salud_cercano,
    variables["provincia"],
    variables["centro_de_salud_cercano"],
    p_centro_cercano_by_prov,
    iters=100,
    n_candidates=10
)
base_data.centro_de_salud_cercano = new_centro_cercano

# (c) Edad ↔ comorbilidades (cardiaca, digestivaa)
# Edad avanzada se asocia fuertemente a mayor prevalencia de comorbilidades.

p_com_card_by_edad = np.array([
    [0.10, 0.90],  # <40
    [0.20, 0.80],  # 40<x<50
    [0.25, 0.75],  # 50<x<60
    [0.45, 0.55],  # 60<
])

new_com_card = asociate(
    base_data.edad,
    base_data.comorbilidad_cardiaca,
    variables["edad"],
    variables["comorbilidad_cardiaca"],
    p_com_card_by_edad,
    iters=100,
    n_candidates=10
)
base_data.comorbilidad_cardiaca = new_com_card

p_com_dig_by_edad = np.array([
    [0.10, 0.90],  # <40
    [0.20, 0.80],  # 40<x<50
    [0.25, 0.75],  # 50<x<60
    [0.45, 0.55],  # 60<
])

new_com_dig = asociate(
    base_data.edad,
    base_data.comorbilidad_sistema_digestivo,
    variables["edad"],
    variables["comorbilidad_sistema_digestivo"],
    p_com_dig_by_edad,
    iters=100,
    n_candidates=10
)
base_data.comorbilidad_sistema_digestivo = new_com_dig


p_com_endo_by_edad = np.array([
    [0.10, 0.90],  # <40
    [0.20, 0.80],  # 40<x<50
    [0.25, 0.75],  # 50<x<60
    [0.45, 0.55],  # 60<
])

new_com_endo = asociate(
    base_data.edad,
    base_data.comorbilidad_sistema_endocrino,
    variables["edad"],
    variables["comorbilidad_sistema_endocrino"],
    p_com_endo_by_edad,
    iters=100,
    n_candidates=10
)
base_data.comorbilidad_sistema_endocrino = new_com_endo

# (d) Edad ↔ estadio_al_momento_de_diagnostico
# Las personas jóvenes tienden a:
# consultar menos por screening
# detectar tumores más tardíamente
p_estadio_by_edad = np.array([
    [0.90, 0.05, 0.04, 0.01],  # <40
    [0.80, 0.10, 0.07, 0.03],  # 40<x<50
    [0.75, 0.12, 0.10, 0.03],  # 50<x<60
    [0.50, 0.40, 0.10, 0.03],  # 60<
])

new_estadio = asociate(
    base_data.edad,
    base_data.estadio_al_momento_de_diagnostica,
    variables["edad"],
    variables["estadio_al_momento_de_diagnostica"],
    p_estadio_by_edad,
    iters=100,
    n_candidates=10
)
base_data.estadio_al_momento_de_diagnostica = new_estadio

# (e) Tamano_tumor ↔ estadio_al_momento_de_diagnostico

# Fuerte.

# Tumor grande casi siempre es estadio avanzado.
# Tumor pequeño suele ser estadio I.

p_size_by_edad = np.array([
    [0.90, 0.05, 0.04],  # I
    [0.70, 0.23, 0.07],  # II
    [0.25, 0.60, 0.15],  # III
    [0.05, 0.40, 0.55],  # IV
])

new_size = asociate(
    base_data.estadio_al_momento_de_diagnostica,
    base_data.tamano_tumor,
    variables["estadio_al_momento_de_diagnostica"],
    variables["tamano_tumor"],
    p_size_by_edad,
    iters=100,
    n_candidates=10
)
base_data.tamano_tumor = new_size

# (f) Tamano_tumor ↔ estado_nodos_linfatico
# Tumores mayores → más probabilidad de metástasis linfática.
# Tumores pequeños → más probabilidad de nodo negativo.

p_estado_by_size= np.array([
    [0.10, 0.90],  # pequeño
    [0.30, 0.70],  # mediano
    [0.75, 0.25],  # Grande
])

new_estado = asociate(
    base_data.tamano_tumor,
    base_data.estado_nodos_linfatico,
    variables["tamano_tumor"],
    variables["estado_nodos_linfatico"],
    p_estado_by_size,
    iters=100,
    n_candidates=10
)
base_data.estado_nodos_linfatico = new_estado

# (g) Tamano_tumor ↔ grado_diferenciacion_tumor

# Los tumores grandes suelen ser:

# más agresivos

# peor diferenciados

# Los pequeños tienden a ser mejor diferenciados.

p_diff_by_estado = np.array([
    [0.03, 0.07, 0.90],  # pequeño
    [0.03, 0.27, 0.70],  # mediano
    [0.75, 0.15, 0.10],  # Grande
])

new_diff = asociate(
    base_data.tamano_tumor,
    base_data.grado_diferenciacion_tumor,
    variables["tamano_tumor"],
    variables["grado_diferenciacion_tumor"],
    p_diff_by_estado,
    iters=100,
    n_candidates=10
)
base_data.grado_diferenciacion_tumor = new_diff

# (h) Estado_receptor_hormonas ↔ grado_diferenciacion_tumor

# Tumores ER+/PR+ tienden a:
# ser mejor diferenciados
# crecer más lentamente
# tener mejores pronósticos
# Tumores hormononegativos (“Ninguno”) suelen:
# ser grado alto
# comportarse agresivamente

p_hr_by_diff = np.array([
    [0.03, 0.07, 0.10, 0.80],  # bajo
    [0.25, 0.20, 0.45, 0.10],  # medio
    [0.03, 0.03, 0.90, 0.02],  # alto
])

new_hr = asociate(
    base_data.grado_diferenciacion_tumor,
    base_data.estado_receptor_hormonas,
    variables["grado_diferenciacion_tumor"],
    variables["estado_receptor_hormonas"],
    p_hr_by_diff,
    iters=100,
    n_candidates=10
)
base_data.estado_receptor_hormonas = new_hr

# %%
coeffs = pd.read_csv("coeff.txt", header=None, sep=",").set_axis(["var", "val", "coeff"], axis= 1)
coeffs
mapping = (
    coeffs
    .set_index(["var","val"])["coeff"]
    .to_dict()
)
# print(mapping)

df_num = base_data.copy()

for col in df_num.columns:
    df_num[col] = df_num[col].map(lambda x: mapping[(col, x)])
# %%
base_data["sobrevida_a_cinco_anos"] = df_num.sum(axis=1) > df_num.sum(axis=1).quantile(0.88)

# pd.get_dummies(base_data)
# %%

base_data.iloc[:1000, :].to_csv(
    'exercise_one_data.csv',
    header=True,
    index=False
)

base_data.iloc[1000:, :].to_csv(
    'exercise_one_data_validations.csv',
    header=True,
    index=False
)
