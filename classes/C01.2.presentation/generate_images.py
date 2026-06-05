"""Genera todas las imágenes para la presentación C01.2."""
import sys
sys.path.insert(0, "/home/javier/projects/qualilative-data-analysis-course/classes")

import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import pandas as pd
import scipy.stats
from sklearn import datasets
import C01

OUT = "/home/javier/projects/qualilative-data-analysis-course/classes/C01.2.presentation/images"
DPI = 150

def save(name):
    plt.savefig(f"{OUT}/{name}.png", dpi=DPI, bbox_inches="tight")
    plt.close("all")
    print(f"  ✓ {name}.png")

# ── 1. Muestra representativa vs sesgada ────────────────────────────────────
rng = np.random.default_rng(42)
N_per_cluster = [150, 120, 130]
means = np.array([[-2.0, 0.0], [2.2, 0.2], [0.2, 3.2]])
covs = [
    np.array([[0.5, 0.1], [0.1, 0.4]]),
    np.array([[0.4, -0.15], [-0.15, 0.6]]),
    np.array([[0.3, 0.0], [0.0, 0.5]]),
]
clusters, labels = [], []
for k, (n, mu, cov) in enumerate(zip(N_per_cluster, means, covs)):
    pts = rng.multivariate_normal(mu, cov, size=n)
    clusters.append(pts)
    labels.extend([k] * n)
X = np.vstack(clusters)
labels = np.array(labels)
idx = [np.where(labels == k)[0] for k in range(3)]
frac = 0.12
sample_A_idx = np.hstack([rng.choice(i, size=max(1, int(len(i)*frac)), replace=False) for i in idx])
biased_sizes = [int(len(idx[0])*0.20), 4, 3]
sample_B_idx = np.hstack([rng.choice(i, size=min(len(i), s), replace=False) for i, s in zip(idx, biased_sizes)])

fig, ax = plt.subplots(figsize=(10, 5), dpi=DPI)
for k in range(3):
    ax.scatter(X[idx[k], 0], X[idx[k], 1], s=12, alpha=0.25, label=f"Subgrupo {k+1}")
ax.scatter(X[sample_A_idx, 0], X[sample_A_idx, 1], s=60, marker='o',
           facecolors='none', edgecolors='black', linewidths=1.2, label="Muestra representativa")
ax.scatter(X[sample_B_idx, 0], X[sample_B_idx, 1], s=60, marker='s',
           facecolors='none', edgecolors='crimson', linewidths=1.2, label="Muestra sesgada")
ax.annotate("Captura variabilidad\n(en cada subgrupo)", xy=X[sample_A_idx[0], 0:2],
            xytext=(-3.5, 3.4), arrowprops=dict(arrowstyle="->", lw=1.0), ha='left', fontsize=10)
ax.annotate("Sesgo de selección:\nsubrepresenta dos subgrupos", xy=X[sample_B_idx[0], 0:2],
            xytext=(2.9, -1.8), arrowprops=dict(arrowstyle="->", lw=1.0), ha='left', fontsize=10)
ax.set_title("Muestra representativa vs. sesgada")
ax.set_xlabel("Característica 1"); ax.set_ylabel("Característica 2")
ax.legend(loc="upper left", frameon=True); ax.set_aspect('equal', adjustable='datalim'); ax.margins(0.1)
plt.tight_layout(); save("muestra_representativa_vs_sesgada")

# ── 2. Muestreo aleatorio simple ────────────────────────────────────────────
rng2 = np.random.default_rng(42)
N, sample_size = 120, 20
x = rng2.uniform(0, 10, N); y = rng2.uniform(0, 6, N)
sample_idx = rng2.choice(np.arange(N), size=sample_size, replace=False)
fig, ax = plt.subplots(figsize=(9, 5))
ax.scatter(x, y, s=60, color="lightgray", alpha=0.7, label="Población")
ax.scatter(x[sample_idx], y[sample_idx], s=80, color="royalblue", edgecolor="black", label="Muestra aleatoria simple")
ax.set_xlim(-0.5, 10.5); ax.set_ylim(-0.5, 6.5); ax.set_aspect("equal")
ax.set_title("Muestreo Aleatorio Simple", fontsize=13, pad=10)
ax.set_xlabel("Característica 1"); ax.set_ylabel("Característica 2")
ax.legend(frameon=True, loc="upper right")
plt.tight_layout(); save("muestreo_aleatorio_simple")

# ── 3. Muestreo sistemático ─────────────────────────────────────────────────
np.random.seed(42)
N, n = 40, 8; k = N // n
poblacion = np.arange(1, N + 1)
inicio = np.random.randint(0, k)
muestra_idx_s = np.arange(inicio, N, k)
fig, ax = plt.subplots(figsize=(10, 3))
ax.scatter(poblacion, np.random.uniform(-0.3, 0.3, len(poblacion)), s=100, color='lightgray', label="Población ordenada")
ax.scatter(poblacion[muestra_idx_s], np.random.uniform(-0.3, 0.3, len(muestra_idx_s)),
           s=160, color='royalblue', edgecolor='black', label="Muestra sistemática")
for mi in muestra_idx_s:
    ax.vlines(x=poblacion[mi], ymin=-0.1, ymax=0.1, color='royalblue', lw=2, alpha=0.6)
ax.text(N*0.05, 0.25, f"Inicio aleatorio = {inicio}\nIntervalo (k) = {k}", fontsize=10, ha='left', va='bottom')
ax.set_title("Muestreo Sistemático", fontsize=13, pad=12)
ax.set_xlabel("Posición en la población"); ax.set_yticks([]); ax.set_xlim(0, N+1)
ax.legend(loc="upper right", frameon=True)
ax.spines[['left', 'top', 'right']].set_visible(False)
plt.tight_layout(); save("muestreo_sistematico")

# ── 4. Muestreo estratificado ───────────────────────────────────────────────
np.random.seed(42)
estratos = {
    "Estrato A": {"color": "#4C72B0", "n": 60},
    "Estrato B": {"color": "#55A868", "n": 35},
    "Estrato C": {"color": "#C44E52", "n": 15},
}
y_base, data_e = 0, []
for nombre, props in estratos.items():
    n = props["n"]; color = props["color"]
    x_e = np.random.uniform(0, 10, n); y_e = np.random.uniform(y_base, y_base + 1, n)
    data_e.append((nombre, x_e, y_e, color)); y_base += 1.5

fig, ax = plt.subplots(figsize=(8, 5))
for (nombre, x_e, y_e, color) in data_e:
    n_total = len(x_e); n_muestra = max(2, int(n_total * 0.2))
    idx_m = np.random.choice(np.arange(n_total), n_muestra, replace=False)
    ax.scatter(x_e, y_e, s=70, color=color, alpha=0.25)
    ax.scatter(x_e[idx_m], y_e[idx_m], s=90, edgecolor='black', facecolor=color, label=nombre)
for i in range(len(estratos)):
    ax.axhline(i*1.5 - 0.25, color='gray', lw=0.8, alpha=0.4)
ax.set_title("Muestreo Estratificado (asignación proporcional)", fontsize=12, pad=10)
ax.set_xlabel("Variable de interés")
ax.set_yticks([0.5, 2.0, 3.5]); ax.set_yticklabels(list(estratos.keys()))
ax.set_xlim(-0.5, 10.5); ax.set_ylim(-0.5, 5.0)
ax.spines[['top', 'right', 'left']].set_visible(False)
ax.legend(title="Estratos", loc="upper right", frameon=True)
plt.tight_layout(); save("muestreo_estratificado")

# ── 5. Media, mediana, moda ─────────────────────────────────────────────────
C01.mean_mode_median(); save("media_mediana_moda")

# ── 6. Medidas de dispersión ────────────────────────────────────────────────
C01.dispersion_measures(); save("dispersion_measures")

# ── 7. Skewness ─────────────────────────────────────────────────────────────
C01.skewness_plot(); save("skewness")

# ── 8. Kurtosis ─────────────────────────────────────────────────────────────
C01.kurtosis_plot(); save("kurtosis")

# ── 9. Histograma ───────────────────────────────────────────────────────────
np.random.seed(42); data_h = np.random.normal(loc=50, scale=10, size=500)
fig, ax = plt.subplots(figsize=(7, 4))
ax.hist(data_h, bins=20, color="steelblue", edgecolor="white", alpha=0.85)
ax.set_title("Histograma"); ax.set_xlabel("Valor"); ax.set_ylabel("Frecuencia")
plt.tight_layout(); save("histograma")

# ── 10. KDE ─────────────────────────────────────────────────────────────────
C01.kde_plot(); save("kde")

# ── 11. Barplot ─────────────────────────────────────────────────────────────
df_bar = pd.DataFrame({
    "especie": ["setosa", "versicolor", "virginica"],
    "longitud_media": [5.006, 5.936, 6.588],
    "std": [0.352, 0.516, 0.636],
})
fig, ax = plt.subplots(figsize=(6, 4))
ax.bar(df_bar["especie"], df_bar["longitud_media"], color="steelblue",
       yerr=df_bar["std"], capsize=6, error_kw=dict(elinewidth=1.5))
ax.set_title("Longitud media del sépalo por especie")
ax.set_xlabel("Especie"); ax.set_ylabel("Longitud (cm)")
plt.tight_layout(); save("barplot")

# ── 12. Scatter plot ────────────────────────────────────────────────────────
iris = datasets.load_iris(as_frame=True); df_iris = iris.frame
colores = {0: "steelblue", 1: "darkorange", 2: "forestgreen"}
fig, ax = plt.subplots(figsize=(7, 5))
for especie, grupo in df_iris.groupby("target"):
    ax.scatter(grupo["petal length (cm)"], grupo["petal width (cm)"],
               label=iris.target_names[especie], color=colores[especie], alpha=0.7, s=50)
ax.set_xlabel("Largo del pétalo (cm)"); ax.set_ylabel("Ancho del pétalo (cm)")
ax.set_title("Scatter plot — Iris (pétalo)"); ax.legend()
plt.tight_layout(); save("scatter_plot")

# ── 13. Scatter matrix ──────────────────────────────────────────────────────
df_sm = df_iris.drop(columns="target")
axes_sm = pd.plotting.scatter_matrix(df_sm, figsize=(8, 8), diagonal='kde',
                                     alpha=0.5, color="steelblue",
                                     hist_kwds={"bins": 15, "edgecolor": "white"})
plt.suptitle("Scatter matrix — dataset Iris", y=1.01, fontsize=13)
plt.tight_layout(); save("scatter_matrix")

# ── 14. Histograma bivariado ─────────────────────────────────────────────────
np.random.seed(42); n_biv = 2000
x_biv = np.random.normal(0, 1, n_biv); y_biv = 2.5*x_biv + np.random.normal(0, 1.5, n_biv)
fig, ax = plt.subplots(figsize=(6, 5))
h = ax.hist2d(x_biv, y_biv, bins=30, cmap="viridis")
plt.colorbar(h[3], ax=ax, label="Frecuencia")
ax.set_title("Histograma bivariado"); ax.set_xlabel("Variable X"); ax.set_ylabel("Variable Y")
plt.tight_layout(); save("histograma_bivariado")

# ── 15. Heatmap de correlación ───────────────────────────────────────────────
corr = df_iris.drop(columns="target").corr()
fig, ax = plt.subplots(figsize=(6, 5))
im = ax.imshow(corr, cmap="coolwarm", vmin=-1, vmax=1)
labels = [c.replace(" (cm)", "").replace("petal ", "pétalo\n").replace("sepal ", "sépalo\n") for c in corr.columns]
ax.set_xticks(range(len(corr))); ax.set_xticklabels(labels, fontsize=9)
ax.set_yticks(range(len(corr))); ax.set_yticklabels(labels, fontsize=9)
for i in range(len(corr)):
    for j in range(len(corr)):
        ax.text(j, i, f"{corr.iloc[i, j]:.2f}", ha="center", va="center",
                color="white" if abs(corr.iloc[i, j]) > 0.5 else "black", fontsize=10)
plt.colorbar(im, ax=ax, label="Correlación de Pearson")
ax.set_title("Mapa de calor de correlaciones — Iris")
plt.tight_layout(); save("heatmap")

# ── 16. Boxplot ──────────────────────────────────────────────────────────────
C01.boxplot_example(); save("boxplot")

# ── 17. ECDF ─────────────────────────────────────────────────────────────────
np.random.seed(42); data_ecdf = np.random.normal(0, 1, 200)
x_ecdf = np.sort(data_ecdf); y_ecdf = np.arange(1, len(x_ecdf)+1) / len(x_ecdf)
fig, ax = plt.subplots(figsize=(7, 4))
ax.step(x_ecdf, y_ecdf, where='post', color='steelblue', linewidth=2, label="ECDF")
xs_th = np.linspace(-3.5, 3.5, 300)
ax.plot(xs_th, scipy.stats.norm.cdf(xs_th), color='crimson', linewidth=1.5,
        linestyle='--', label="CDF Normal(0,1)")
ax.set_title("ECDF vs. CDF teórica"); ax.set_xlabel("Valor"); ax.set_ylabel("Proporción acumulada")
ax.legend(); ax.grid(alpha=0.3)
plt.tight_layout(); save("ecdf")

print("\nTodas las imágenes generadas.")
