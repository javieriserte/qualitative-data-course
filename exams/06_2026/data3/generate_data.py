"""
Generador de datos para Ejercicio 3:
Estudio epidemiológico — fuente de agua y diarrea aguda.

Archivos generados:
  - encuesta_transversal.csv
  - seguimiento_apareado.csv
  - tabla_estratificada.csv

Modelo subyacente:
  - Fuente de agua (pozo/red) tiene asociación REAL con diarrea.
  - Nivel socioeconómico es variable de confusión:
      · Hogares de nivel bajo usan más el pozo Y tienen más diarrea por otras causas.
      · Esto produce paradoja de Simpson: el OR crudo subestima la asociación real.
  - La intervención (mejora de red) reduce la diarrea significativamente
    → McNemar detecta el cambio.
"""

import numpy as np
import pandas as pd
from itertools import product

RNG = np.random.default_rng(seed=7)

# ── Parámetros del modelo ─────────────────────────────────────────────────────

MUNICIPIOS = ["San Isidro del Valle", "Colonia Güemes", "Villa Aparicio"]
NSE        = ["bajo", "medio", "alto"]

# P(usa pozo | municipio, nse)
# Hogares de nse bajo usan más el pozo; varía por municipio
P_POZO = {
    ("San Isidro del Valle", "bajo"):  0.80,
    ("San Isidro del Valle", "medio"): 0.45,
    ("San Isidro del Valle", "alto"):  0.15,
    ("Colonia Güemes",       "bajo"):  0.75,
    ("Colonia Güemes",       "medio"): 0.40,
    ("Colonia Güemes",       "alto"):  0.10,
    ("Villa Aparicio",       "bajo"):  0.85,
    ("Villa Aparicio",       "medio"): 0.50,
    ("Villa Aparicio",       "alto"):  0.20,
}

# P(diarrea | fuente, nse)
# Efecto REAL del agua: pozo aumenta riesgo.
# Efecto REAL del nse: nse bajo aumenta riesgo (saneamiento, hacinamiento).
P_DIARREA = {
    ("red",  "bajo"):  0.18,
    ("red",  "medio"): 0.09,
    ("red",  "alto"):  0.04,
    ("pozo", "bajo"):  0.42,
    ("pozo", "medio"): 0.28,
    ("pozo", "alto"):  0.16,
}

# Distribución de nse por municipio
NSE_DIST = {
    "San Isidro del Valle": {"bajo": 0.55, "medio": 0.35, "alto": 0.10},
    "Colonia Güemes":       {"bajo": 0.40, "medio": 0.45, "alto": 0.15},
    "Villa Aparicio":       {"bajo": 0.65, "medio": 0.25, "alto": 0.10},
}

# Tamaño de muestra por municipio
N_POR_MUNICIPIO = {
    "San Isidro del Valle": 140,
    "Colonia Güemes":       110,
    "Villa Aparicio":        90,
}

# Efecto de la intervención: reduce P(diarrea) en quienes tenían pozo y
# recibieron conexión a red. Solo el 60% de los hogares con pozo recibió
# la intervención completa.
REDUCCION_INTERVENCION = 0.55   # reducción proporcional del riesgo
N_SEGUIMIENTO = 120             # hogares en el seguimiento apareado


# ── 1. encuesta_transversal.csv ───────────────────────────────────────────────

def generar_encuesta() -> pd.DataFrame:
    rows = []
    hogar_id = 1
    for mun, n in N_POR_MUNICIPIO.items():
        nse_vals  = list(NSE_DIST[mun].keys())
        nse_probs = list(NSE_DIST[mun].values())
        nses      = RNG.choice(nse_vals, size=n, p=nse_probs)
        for nse_val in nses:
            fuente = "pozo" if RNG.random() < P_POZO[(mun, nse_val)] else "red"
            p_d    = P_DIARREA[(fuente, nse_val)]
            diarrea = bool(RNG.random() < p_d)
            rows.append({
                "hogar_id":             hogar_id,
                "municipio":            mun,
                "nivel_socioeconomico": nse_val,
                "fuente_agua":          fuente,
                "diarrea_ultimo_mes":   diarrea,
            })
            hogar_id += 1
    return pd.DataFrame(rows)


# ── 2. seguimiento_apareado.csv ───────────────────────────────────────────────

def generar_seguimiento(df_encuesta: pd.DataFrame) -> pd.DataFrame:
    """
    Toma una muestra de hogares con pozo y genera estado antes/después.
    Antes: probabilidad de diarrea según fuente y nse original.
    Después: hogares que reciben intervención (conexión a red) mejoran;
             el resto mantiene su riesgo original.
    """
    # Muestrear hogares del seguimiento (más hogares con pozo para mayor potencia)
    pozo_idx = df_encuesta[df_encuesta["fuente_agua"] == "pozo"].index
    red_idx  = df_encuesta[df_encuesta["fuente_agua"] == "red"].index

    n_pozo = min(int(N_SEGUIMIENTO * 0.65), len(pozo_idx))
    n_red  = min(N_SEGUIMIENTO - n_pozo, len(red_idx))

    sel_idx = np.concatenate([
        RNG.choice(pozo_idx, size=n_pozo, replace=False),
        RNG.choice(red_idx,  size=n_red,  replace=False),
    ])
    df_seg = df_encuesta.loc[sel_idx].copy().reset_index(drop=True)

    # Estado ANTES de la intervención
    diarrea_antes = []
    for _, row in df_seg.iterrows():
        p = P_DIARREA[(row["fuente_agua"], row["nivel_socioeconomico"])]
        diarrea_antes.append(bool(RNG.random() < p))

    # Estado DESPUÉS: hogares con pozo que reciben la intervención mejoran
    diarrea_despues = []
    recibio_intervencion = []
    for i, row in df_seg.iterrows():
        if row["fuente_agua"] == "pozo":
            interv = bool(RNG.random() < 0.60)   # 60% recibe conexión efectiva
        else:
            interv = False
        recibio_intervencion.append(interv)

        if interv:
            # Ahora usa red → riesgo equivalente a fuente=red
            p = P_DIARREA[("red", row["nivel_socioeconomico"])]
        else:
            p = P_DIARREA[(row["fuente_agua"], row["nivel_socioeconomico"])]
        diarrea_despues.append(bool(RNG.random() < p))

    df_seg["diarrea_antes"]         = diarrea_antes
    df_seg["diarrea_despues"]       = diarrea_despues
    df_seg["recibio_intervencion"]  = recibio_intervencion

    return df_seg[[
        "hogar_id", "municipio", "nivel_socioeconomico",
        "fuente_agua", "recibio_intervencion",
        "diarrea_antes", "diarrea_despues",
    ]]


# ── 3. tabla_estratificada.csv ────────────────────────────────────────────────

def generar_tabla_estratificada(df_encuesta: pd.DataFrame) -> pd.DataFrame:
    """
    Tabla de contingencia 2×2 (fuente × diarrea) por municipio.
    Una fila por combinación municipio × fuente × diarrea con el conteo.
    """
    rows = []
    for mun in MUNICIPIOS:
        df_m = df_encuesta[df_encuesta["municipio"] == mun]
        for fuente, diarrea in product(["red", "pozo"], [True, False]):
            n = ((df_m["fuente_agua"] == fuente) &
                 (df_m["diarrea_ultimo_mes"] == diarrea)).sum()
            rows.append({
                "municipio":           mun,
                "fuente_agua":         fuente,
                "diarrea_ultimo_mes":  diarrea,
                "n_hogares":           int(n),
            })
    return pd.DataFrame(rows)


# ── Main ──────────────────────────────────────────────────────────────────────

def main():
    df_enc  = generar_encuesta()
    df_seg  = generar_seguimiento(df_enc)
    df_estr = generar_tabla_estratificada(df_enc)

    df_enc.to_csv("encuesta_transversal.csv",  index=False)
    df_seg.to_csv("seguimiento_apareado.csv",  index=False)
    df_estr.to_csv("tabla_estratificada.csv",  index=False)

    # ── Resumen para verificar el diseño ─────────────────────────────────────
    print("=== encuesta_transversal.csv ===")
    print(f"  Hogares totales : {len(df_enc)}")
    ct = pd.crosstab(df_enc["fuente_agua"], df_enc["diarrea_ultimo_mes"])
    print("  Tabla global fuente × diarrea:")
    print(ct.to_string())

    # OR crudo global
    a = ct.loc["pozo", True];  b = ct.loc["pozo", False]
    c = ct.loc["red",  True];  d = ct.loc["red",  False]
    or_crudo = (a * d) / (b * c)
    print(f"\n  OR crudo (global, sin estratificar) = {or_crudo:.2f}")

    print("\n  Prevalencia de diarrea por fuente y nse:")
    piv = df_enc.groupby(["fuente_agua", "nivel_socioeconomico"])[
        "diarrea_ultimo_mes"].mean().round(2)
    print(piv.to_string())

    print("\n=== seguimiento_apareado.csv ===")
    print(f"  Hogares en seguimiento : {len(df_seg)}")
    mc = pd.crosstab(df_seg["diarrea_antes"], df_seg["diarrea_despues"],
                     rownames=["antes"], colnames=["despues"])
    print("  Tabla McNemar (antes × despues):")
    print(mc.to_string())
    b_mc = mc.loc[True,  False] if (True  in mc.index and False in mc.columns) else 0
    c_mc = mc.loc[False, True]  if (False in mc.index and True  in mc.columns) else 0
    print(f"  Discordantes b={b_mc}, c={c_mc}  → McNemar señal {'clara' if abs(b_mc-c_mc)>5 else 'débil'}")

    print("\n=== tabla_estratificada.csv ===")
    for mun in MUNICIPIOS:
        df_m = df_estr[df_estr["municipio"] == mun]
        def cell(f, d): return df_m.loc[(df_m["fuente_agua"]==f) & (df_m["diarrea_ultimo_mes"]==d), "n_hogares"].values[0]
        a=cell("pozo",True); b=cell("pozo",False); c=cell("red",True); d=cell("red",False)
        or_m = (a*d)/(b*c) if b*c > 0 else float("nan")
        print(f"  {mun}: pozo(+{a}/-{b}) red(+{c}/-{d})  OR={or_m:.2f}")

    print("\nArchivos guardados.")


if __name__ == "__main__":
    main()
