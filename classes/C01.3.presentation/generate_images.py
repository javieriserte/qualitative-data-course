import numpy as np
import scipy.stats as st
import pandas as pd
import statsmodels.api as sm
import statsmodels.formula.api as smf
from matplotlib import pyplot as plt
import matplotlib as mpl
from pathlib import Path

out = Path("images")
out.mkdir(exist_ok=True)

# ── Paleta del estilo de presentación ────────────────────────────────────────
cm2 = "#032e35"
cm3 = "#00a1ae"
cm1 = "#a3804c"
gry = "#6B7280"
bg  = "#f9f8f5"

mpl.rcParams.update({
    "font.family": "DejaVu Sans",
    "axes.spines.top":   False,
    "axes.spines.right": False,
    "axes.edgecolor":    cm2,
    "axes.labelcolor":   cm2,
    "xtick.color":       cm2,
    "ytick.color":       cm2,
    "text.color":        cm2,
    "figure.facecolor":  bg,
    "axes.facecolor":    bg,
})

# ── 1. Scatter — Correlación de Pearson ──────────────────────────────────────
x = np.array([
    0.02256488, 0.26681332, 0.29162887, 0.48849624, 0.50184021,
    0.58003829, 0.59856923, 0.64207527, 0.65445321, 0.8683472,
])
y = np.array([
    0.02090346, 0.02950049, 0.03190492, 0.05852373, 0.19714768,
    0.37935066, 0.40032053, 0.52997007, 0.62628891, 0.64026217,
])

fig, ax = plt.subplots(figsize=(5, 4))
ax.scatter(x, y, color=cm3, edgecolors=cm2, linewidths=0.6, s=70, zorder=3)

# Línea de regresión
m, b = np.polyfit(x, y, 1)
xs = np.linspace(x.min(), x.max(), 200)
ax.plot(xs, m * xs + b, color=cm1, linewidth=1.5, linestyle="--")

coeff = st.pearsonr(x, y)
ax.text(0.05, 0.88, f"Pearson r = {coeff.statistic:.4f}",
        transform=ax.transAxes, fontsize=12, color=cm2,
        bbox=dict(boxstyle="round,pad=0.3", facecolor="white",
                  edgecolor=cm3, linewidth=0.8))

ax.set_xlabel("X", fontsize=12)
ax.set_ylabel("Y", fontsize=12)
ax.set_title("Correlación de Pearson", fontsize=13, color=cm2, pad=10)
ax.grid(True, linestyle=":", linewidth=0.5, color=gry, alpha=0.5)
fig.tight_layout()
fig.savefig(out / "pearson_scatter.png", dpi=150, bbox_inches="tight")
plt.close(fig)
print("pearson_scatter.png  ✓")

# ── 2. Bar chart — Eta cuadrado (ANOVA) ──────────────────────────────────────
df = pd.DataFrame({
    "tratamiento": ["control", "A", "B", "control", "A", "B", "A", "control", "B", "A"],
    "expresion":   [4.8, 6.2, 7.1, 4.9, 6.4, 6.9, 6.1, 5.0, 7.3, 6.5],
})

resumen = (
    df.groupby("tratamiento")["expresion"]
    .agg(["mean", "std", "count"])
    .reset_index()
)
resumen["sem"] = resumen["std"] / np.sqrt(resumen["count"])

modelo = smf.ols("expresion ~ C(tratamiento)", data=df).fit()
anova  = sm.stats.anova_lm(modelo, typ=2)
eta2   = anova["sum_sq"]["C(tratamiento)"] / anova["sum_sq"].sum()

colors = ["#b0bec5", cm3, cm2]   # control, A, B
fig, ax = plt.subplots(figsize=(5, 4))

bars = ax.bar(
    resumen["tratamiento"],
    resumen["mean"],
    yerr=resumen["sem"],
    capsize=5,
    color=colors,
    edgecolor=cm2,
    linewidth=0.8,
    error_kw=dict(elinewidth=1, ecolor=cm2),
)

ax.set_title("Nivel medio de expresión por tratamiento", fontsize=12, color=cm2, pad=10)
ax.set_xlabel("Tratamiento", fontsize=11)
ax.set_ylabel("Expresión media (u.a.)", fontsize=11)
ax.set_ylim(0, resumen["mean"].max() + 2)
ax.text(0.97, 0.93, f"η² = {eta2:.3f}",
        transform=ax.transAxes, fontsize=12, color=cm2,
        ha="right",
        bbox=dict(boxstyle="round,pad=0.3", facecolor="white",
                  edgecolor=cm1, linewidth=0.8))
ax.grid(axis="y", linestyle=":", linewidth=0.5, color=gry, alpha=0.5)
fig.tight_layout()
fig.savefig(out / "eta2_barplot.png", dpi=150, bbox_inches="tight")
plt.close(fig)
print("eta2_barplot.png     ✓")
