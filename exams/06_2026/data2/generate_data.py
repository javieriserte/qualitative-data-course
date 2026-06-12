"""
Generador de datos para ejercicio de examen:
Ensayo de inoculantes en cultivo de maíz con diseño incompleto.

Modelo lineal subyacente:
  rinde = base_variedad
        + efecto_ubicacion
        + efecto_temporada
        + efecto_riego
        + efecto_inoculante        # solo BioRaiz tiene efecto real
        + efecto_fungicida         # efecto real solo en ubicaciones húmedas
        + ruido

Variables sin efecto real:
  - lote_numero: identificador de lote dentro de cada ubicación

Diseño: no se prueban todas las combinaciones (diseño incompleto por costos).
"""

import numpy as np
import pandas as pd

RNG = np.random.default_rng(seed=42)

# ── Niveles ───────────────────────────────────────────────────────────────────

# Nombres de fantasía para variedades (estilo denominaciones comerciales de semillas)
VARIEDADES = ["Pampeador", "Sudestada", "Zonda", "Pampero", "Ñandubay"]

# Ubicaciones reales en la región maicera argentina
UBICACIONES = [
    "Pergamino",
    "Venado Tuerto",
    "Río Cuarto",
    "Junín",
    "Marcos Juárez",
    "Tandil",
]

# Inoculantes: nombres de fantasía tipo marca comercial
# Solo BioRaiz tiene efecto real; los demás son equivalentes al control
INOCULANTES = ["Control", "NitroMax", "BioRaiz", "TerraFix"]

RIEGOS = ["sin_riego", "con_riego"]

TEMPORADAS = ["2022/23", "2023/24", "2024/25"]

# Lotes por ubicación (anidados; sin efecto sobre el rinde)
LOTES_POR_UBICACION = {
    "Pergamino":     ["L1", "L2", "L3"],
    "Venado Tuerto": ["L1", "L2"],
    "Río Cuarto":    ["L1", "L2", "L3"],
    "Junín":         ["L1", "L2"],
    "Marcos Juárez": ["L1", "L2", "L3"],
    "Tandil":        ["L1", "L2"],
}

# Ubicaciones con alta presión de hongos (donde el fungicida tiene efecto real)
UBICACIONES_HUMEDAS = {"Pergamino", "Marcos Juárez", "Tandil"}

# ── Efectos del modelo lineal ─────────────────────────────────────────────────

base_variedad = {
    "Pampeador": 7000,
    "Sudestada": 8500,
    "Zonda":     6200,
    "Pampero":   9100,
    "Ñandubay":  7800,
}

efecto_ubicacion = {
    "Pergamino":     400,
    "Venado Tuerto": -300,
    "Río Cuarto":     800,
    "Junín":          -50,
    "Marcos Juárez":  600,
    "Tandil":        -500,
}

# Variabilidad interanual clara
efecto_temporada = {
    "2022/23":  200,   # año normal
    "2023/24": -450,   # año seco (La Niña)
    "2024/25":  350,   # año favorable
}

efecto_riego = {
    "sin_riego":  0,
    "con_riego":  950,
}

# BioRaiz es el único inoculante con efecto real
efecto_inoculante = {
    "Control":  0,
    "NitroMax": 0,
    "BioRaiz":  480,
    "TerraFix": 0,
}

# Fungicida: efecto real solo en ubicaciones húmedas
EFECTO_FUNGICIDA_HUMEDO = 520
EFECTO_FUNGICIDA_SECO   = 0

SIGMA_RUIDO = 280


# ── Diseño incompleto ─────────────────────────────────────────────────────────

def build_incomplete_design(fraccion_eliminada: float = 0.35) -> pd.DataFrame:
    """Construye el diseño factorial completo y elimina combinaciones al azar."""
    rows = []
    for v in VARIEDADES:
        for u in UBICACIONES:
            for i in INOCULANTES:
                for r in RIEGOS:
                    for t in TEMPORADAS:
                        for f in [True, False]:
                            lote = RNG.choice(LOTES_POR_UBICACION[u])
                            rows.append({
                                "variedad":             v,
                                "ubicacion":            u,
                                "inoculante":           i,
                                "riego":                r,
                                "temporada":            t,
                                "aplicacion_fungicida": f,
                                "lote_numero":          lote,
                            })

    df_full = pd.DataFrame(rows)
    n_drop  = int(len(df_full) * fraccion_eliminada)
    drop_idx = RNG.choice(df_full.index, size=n_drop, replace=False)

    # Proteger niveles que quedarían sin representación
    cols_proteger = ["variedad", "ubicacion", "inoculante",
                     "riego", "temporada", "aplicacion_fungicida"]
    safe_to_drop = []
    for idx in drop_idx:
        row = df_full.loc[idx]
        can_drop = True
        for col in cols_proteger:
            remaining = df_full.drop(index=safe_to_drop).drop(index=idx)
            if (remaining[col] == row[col]).sum() == 0:
                can_drop = False
                break
        if can_drop:
            safe_to_drop.append(idx)

    return df_full.drop(index=safe_to_drop).reset_index(drop=True)


# ── Calcular rinde ────────────────────────────────────────────────────────────

def calcular_rinde(row: pd.Series) -> float:
    ef_fungicida = (
        EFECTO_FUNGICIDA_HUMEDO
        if (row["aplicacion_fungicida"] and row["ubicacion"] in UBICACIONES_HUMEDAS)
        else EFECTO_FUNGICIDA_SECO
    )
    mu = (
        base_variedad[row["variedad"]]
        + efecto_ubicacion[row["ubicacion"]]
        + efecto_temporada[row["temporada"]]
        + efecto_riego[row["riego"]]
        + efecto_inoculante[row["inoculante"]]
        + ef_fungicida
    )
    return round(max(mu + RNG.normal(0, SIGMA_RUIDO), 0), 1)


# ── Main ──────────────────────────────────────────────────────────────────────

def main():
    df = build_incomplete_design()
    df["rinde_kg_ha"] = df.apply(calcular_rinde, axis=1)

    col_order = [
        "variedad", "ubicacion", "temporada",
        "riego", "inoculante", "aplicacion_fungicida",
        "lote_numero", "rinde_kg_ha",
    ]
    df = df[col_order]

    output_path = "inoculantes_maiz.csv"
    df.to_csv(output_path, index=False)

    n_full = (
        len(VARIEDADES) * len(UBICACIONES) * len(INOCULANTES)
        * len(RIEGOS) * len(TEMPORADAS) * 2
    )
    print(f"Filas generadas  : {len(df)}")
    print(f"Diseño completo  : {n_full} combinaciones")
    print(f"Fracción retenida: {len(df) / n_full:.1%}")
    print()
    print("Rinde medio por inoculante:")
    print(df.groupby("inoculante")["rinde_kg_ha"].mean().round(1).to_string())
    print()
    print("Rinde medio por temporada:")
    print(df.groupby("temporada")["rinde_kg_ha"].mean().round(1).to_string())
    print()
    print("Rinde medio por fungicida × ubicación húmeda:")
    df["ubic_humeda"] = df["ubicacion"].isin(UBICACIONES_HUMEDAS)
    print(
        df.groupby(["ubic_humeda", "aplicacion_fungicida"])["rinde_kg_ha"]
        .mean().round(1).to_string()
    )
    print()
    print(f"Archivo guardado : {output_path}")


if __name__ == "__main__":
    main()
