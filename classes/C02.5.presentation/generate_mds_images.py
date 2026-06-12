import numpy as np
import matplotlib.pyplot as plt
from sklearn import datasets
from sklearn.preprocessing import StandardScaler
from sklearn.manifold import MDS
from sklearn.utils import Bunch
import warnings
warnings.filterwarnings("ignore")

OUT = "images"
cm1 = "#a3804c"
cm2 = "#032e35"
cm3 = "#00a1ae"
gry = "#6B7280"
bg  = "#f9f8f5"

plt.rcParams.update({
    "figure.facecolor": bg,
    "axes.facecolor": bg,
    "savefig.facecolor": bg,
})

colors_iris = [cm3, cm1, cm2]

iris = datasets.load_iris()
assert isinstance(iris, Bunch)
X = iris.data
y = iris.target
X_scaled = StandardScaler().fit_transform(X)

# ─── 1. MDS clásico (métrico) sobre Iris ─────────────────────────────────────
mds_metric = MDS(n_components=2, metric=True, random_state=42, normalized_stress="auto")
X_mds_metric = mds_metric.fit_transform(X_scaled)

fig, ax = plt.subplots(figsize=(7, 5))
for i, name in enumerate(iris.target_names):
    ax.scatter(X_mds_metric[y==i, 0], X_mds_metric[y==i, 1],
               label=name, color=colors_iris[i], alpha=0.7, s=20)
ax.set_title("MDS Métrico — Iris dataset", color=cm2)
ax.set_xlabel("Dimensión 1", color=cm2)
ax.set_ylabel("Dimensión 2", color=cm2)
ax.legend()
ax.tick_params(colors=cm2)
for sp in ax.spines.values(): sp.set_edgecolor(gry)
fig.tight_layout()
fig.savefig(f"{OUT}/mds_metric_iris.png", dpi=150, bbox_inches="tight")
plt.close()
print("mds_metric_iris.png")

# ─── 2. MDS no métrico sobre Iris ────────────────────────────────────────────
mds_nonmetric = MDS(n_components=2, metric=False, random_state=42, normalized_stress="auto")
X_mds_nm = mds_nonmetric.fit_transform(X_scaled)

fig, ax = plt.subplots(figsize=(7, 5))
for i, name in enumerate(iris.target_names):
    ax.scatter(X_mds_nm[y==i, 0], X_mds_nm[y==i, 1],
               label=name, color=colors_iris[i], alpha=0.7, s=20)
ax.set_title("MDS No Métrico — Iris dataset", color=cm2)
ax.set_xlabel("Dimensión 1", color=cm2)
ax.set_ylabel("Dimensión 2", color=cm2)
ax.legend()
ax.tick_params(colors=cm2)
for sp in ax.spines.values(): sp.set_edgecolor(gry)
fig.tight_layout()
fig.savefig(f"{OUT}/mds_nonmetric_iris.png", dpi=150, bbox_inches="tight")
plt.close()
print("mds_nonmetric_iris.png")

# ─── 3. Analogía geográfica — distancias entre ciudades ──────────────────────
cities = ["Buenos Aires", "Córdoba", "Rosario", "Mendoza", "Salta", "Mar del Plata"]
# Distancias aproximadas en km (matriz simétrica)
dist = np.array([
    [   0, 695, 300, 1050, 1580,  400],
    [ 695,   0, 395,  680,  895, 1090],
    [ 300, 395,   0,  890, 1400,  510],
    [1050, 680, 890,    0, 1230, 1430],
    [1580, 895,1400, 1230,    0, 1980],
    [ 400,1090, 510, 1430, 1980,    0],
])

mds_geo = MDS(n_components=2, dissimilarity="precomputed", random_state=42, normalized_stress="auto")
coords = mds_geo.fit_transform(dist)

fig, ax = plt.subplots(figsize=(8, 5))
ax.scatter(coords[:, 0], coords[:, 1], color=cm2, s=80, zorder=5)
for i, city in enumerate(cities):
    ax.annotate(city, (coords[i, 0], coords[i, 1]),
                textcoords="offset points", xytext=(8, 4),
                fontsize=11, color=cm2)
ax.set_title("MDS sobre distancias entre ciudades argentinas", color=cm2)
ax.set_xlabel("Dimensión 1", color=cm2)
ax.set_ylabel("Dimensión 2", color=cm2)
ax.tick_params(colors=cm2)
for sp in ax.spines.values(): sp.set_edgecolor(gry)
fig.tight_layout()
fig.savefig(f"{OUT}/mds_cities.png", dpi=150, bbox_inches="tight")
plt.close()
print("mds_cities.png")

# ─── 4. Shepard diagram (stress plot) ────────────────────────────────────────
from sklearn.metrics import pairwise_distances

orig_dist = pairwise_distances(X_scaled).ravel()
emb_dist  = pairwise_distances(X_mds_metric).ravel()

# Stress normalizado (Kruskal): sqrt(sum((d-d_hat)^2) / sum(d^2)), rango [0, 1]
stress_norm = np.sqrt(
    np.sum((orig_dist - emb_dist) ** 2) / np.sum(orig_dist ** 2)
)

fig, ax = plt.subplots(figsize=(6, 5))
ax.scatter(orig_dist, emb_dist, s=2, alpha=0.15, color=cm2)
lim = max(orig_dist.max(), emb_dist.max())
ax.plot([0, lim], [0, lim], color=cm3, linewidth=1.5, linestyle="--", label="ideal")
ax.set_xlabel("Distancia original", color=cm2)
ax.set_ylabel("Distancia en embedding", color=cm2)
ax.set_title(f"Diagrama de Shepard — stress = {stress_norm:.4f}", color=cm2)
ax.legend()
ax.tick_params(colors=cm2)
for sp in ax.spines.values(): sp.set_edgecolor(gry)
fig.tight_layout()
fig.savefig(f"{OUT}/mds_shepard.png", dpi=150, bbox_inches="tight")
plt.close()
print(f"mds_shepard.png  (stress normalizado = {stress_norm:.4f})")

print("Done.")
