import numpy as np
import matplotlib.pyplot as plt
import scipy.stats as st
import pandas as pd
import math
from matplotlib.patches import Ellipse, FancyArrowPatch
from sklearn import decomposition, preprocessing, datasets
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA
from sklearn.manifold import TSNE, trustworthiness
from sklearn.utils import Bunch
import warnings
warnings.filterwarnings("ignore")

OUT = "images"

# ─── Colores de la paleta ────────────────────────────────────────────────────
cm1 = "#a3804c"
cm2 = "#032e35"
cm3 = "#00a1ae"
gry = "#6B7280"
bg  = "#f9f8f5"

plt.rcParams.update({
    "figure.facecolor": bg,
    "axes.facecolor": bg,
    "savefig.facecolor": bg,
    "font.family": "DejaVu Sans",
})

# ─── 1. Scatter altura / peso / tamRopa ──────────────────────────────────────
alt = [85.5, 87.2, 77.4, 78.3, 101.1, 112.8, 90.8, 105.8, 78.9, 91.9,
       55.3, 76.6, 99.8, 106.5, 90.5, 87.9, 66.0, 99.8, 84.9, 77.2]
peso = [171, 183, 147, 155, 189, 186, 160, 185, 165, 168,
        159, 159, 181, 185, 157, 177, 155, 166, 160, 174]
tamRopa = [56, 62, 58, 48, 64, 60, 56, 66, 58, 56,
           48, 52, 50, 58, 46, 56, 48, 52, 50, 54]

fig, axes = plt.subplots(1, 3, figsize=(13, 4))
for ax in axes:
    ax.set_facecolor(bg)
axes[0].scatter(alt, peso, color=cm2, alpha=0.8)
axes[0].set_ylabel("peso", color=cm2); axes[0].set_xlabel("altura", color=cm2)
axes[1].scatter(alt, tamRopa, color=cm3, alpha=0.8)
axes[1].set_ylabel("tamaño ropa", color=cm2); axes[1].set_xlabel("altura", color=cm2)
axes[2].scatter(peso, tamRopa, color=cm1, alpha=0.8)
axes[2].set_ylabel("tamaño ropa", color=cm2); axes[2].set_xlabel("peso", color=cm2)
for ax in axes:
    ax.tick_params(colors=cm2)
    for spine in ax.spines.values():
        spine.set_edgecolor(gry)
fig.tight_layout()
fig.savefig(f"{OUT}/pca_scatter_corr.png", dpi=150, bbox_inches="tight")
plt.close()
print("pca_scatter_corr.png")

# ─── 2. Datos 2D con dos grupos (dimensiones individuales) ───────────────────
np.random.seed(42)
xa = st.norm.rvs(4, 2.5, size=100)
ya = st.norm.rvs(size=100) * 4.5 + 0.9 * xa - 10
xb = st.norm.rvs(-4, 2.5, size=100)
yb = st.norm.rvs(size=100) * 4.5 + 0.9 * xb + 10
data = pd.DataFrame({
    "X": np.concatenate((xa, xb)),
    "Y": np.concatenate((ya, yb))
})

fig, axes = plt.subplots(1, 1, figsize=(11, 3))
axes.scatter(x=data.X, y=[1]*len(data.X), s=5, color=cm2, alpha=0.6)
axes.scatter(x=data.Y, y=[2]*len(data.Y), s=5, color=cm2, alpha=0.6)
axes.set_ylim(0, 3)
axes.set_yticks([1, 2], labels=["Dimensión X", "Dimensión Y"])
axes.set_title("Observación en dimensiones individuales", color=cm2)
axes.add_patch(Ellipse((0, 2), width=30, height=0.7, fill=False, linewidth=1.5, color="orange"))
axes.add_patch(Ellipse((0, 1), width=20, height=0.7, fill=False, linewidth=1.5, color=cm3))
axes.annotate("Un grupo", (3, 2.2), (5, 2.7), arrowprops={"arrowstyle": "->"}, color=cm2)
axes.annotate("Un grupo", (3, 0.8), (5, 0.3), arrowprops={"arrowstyle": "->"}, color=cm2)
axes.tick_params(colors=cm2)
for sp in axes.spines.values(): sp.set_edgecolor(gry)
fig.tight_layout()
fig.savefig(f"{OUT}/pca_1d_projection.png", dpi=150, bbox_inches="tight")
plt.close()
print("pca_1d_projection.png")

# ─── 3. Scatter 2D completo con direcciones principales ──────────────────────
fig, axes = plt.subplots(1, 1, figsize=(7, 7))
axes.scatter(x=data.X, y=data.Y, s=5, color=cm2, alpha=0.6)
axes.set_ylabel("Dimensión Y", color=cm2)
axes.set_xlabel("Dimensión X", color=cm2)
axes.set_title("Datos en 2D — grupos y nuevas dimensiones", color=cm2)
axes.add_patch(Ellipse((-5, 5), width=30, angle=math.atan(3)*180/math.pi, height=11, fill=False, linewidth=1.5, color="orange"))
axes.add_patch(Ellipse((4, -5), width=30, angle=math.atan(3)*180/math.pi, height=11, fill=False, linewidth=1.5, color=cm3))
axes.annotate("Dos grupos", (1, 10), (10, 10), arrowprops={"arrowstyle": "->"}, color=cm2)
axes.annotate("", (8, 8), (10, 10), arrowprops={"arrowstyle": "->"}, color=cm2)
axes.set_ylim(-20, 20); axes.set_xlim(-20, 20)
axes.axline((0, 0), slope=3, linestyle="dashed", linewidth=2, color=cm1)
axes.axline((0, 0), slope=-1/3, linestyle="dashed", linewidth=2, color=cm3)
axes.axhline(0, linewidth=1, color=gry)
for start, end in [((18, -6), (18, 0)), ((-18, 6), (-18, 0))]:
    arrow = FancyArrowPatch(start, end, connectionstyle="arc3,rad=0.3",
                            arrowstyle="-|>", mutation_scale=20, color=cm3, linewidth=2)
    axes.add_patch(arrow)
axes.text(-15, 5.5, "Nueva dim. 1", rotation=math.atan(-1/3)*180/math.pi, ha="center", va="center", color=cm3)
axes.text(4.5, 15, "Nueva dim. 2", rotation=math.atan(3)*180/math.pi, ha="center", va="center", color=cm1)
axes.tick_params(colors=cm2)
for sp in axes.spines.values(): sp.set_edgecolor(gry)
fig.tight_layout()
fig.savefig(f"{OUT}/pca_2d_directions.png", dpi=150, bbox_inches="tight")
plt.close()
print("pca_2d_directions.png")

# ─── 4. Datos rotados + proyección 1D ────────────────────────────────────────
angle = math.pi/2 - math.atan(3)
rmat = np.array([[math.cos(angle), -math.sin(angle)],
                 [math.sin(angle),  math.cos(angle)]])
rotated = (rmat @ data.to_numpy().T).T

fig, axes = plt.subplots(figsize=(7, 7))
axes.scatter(rotated[:, 0], rotated[:, 1], s=5, color=cm2, alpha=0.6)
axes.set_ylim(-20, 20); axes.set_xlim(-20, 20)
axes.scatter(rotated[:, 0], [-17.5]*len(rotated), color=cm3, s=5, alpha=0.6)
axes.axhline(-17.5, linewidth=1, color=gry)
axes.text(-19, -17.2, "Nueva dimensión 1", color=cm2, fontsize=9)
axes.add_patch(Ellipse((-6, -17.5), width=10, height=2, fill=False, linewidth=1.5, color="orange"))
axes.add_patch(Ellipse((5, -17.5), width=10, height=2, fill=False, linewidth=1.5, color=cm3))
axes.annotate("Dos grupos", (-6, -17), (-4, -15), arrowprops={"arrowstyle": "->"}, color=cm2)
axes.annotate("", (5, -17), (-2, -15.3), arrowprops={"arrowstyle": "->"}, color=cm2)
axes.tick_params(colors=cm2)
for sp in axes.spines.values(): sp.set_edgecolor(gry)
fig.tight_layout()
fig.savefig(f"{OUT}/pca_rotated.png", dpi=150, bbox_inches="tight")
plt.close()
print("pca_rotated.png")

# ─── 5. PCA sobre datos 2D sintéticos ────────────────────────────────────────
pca = decomposition.PCA(n_components=2)
scale = preprocessing.StandardScaler().fit(data)
data_scaled = scale.transform(data)
fitted = pca.fit(data_scaled)
transformed = fitted.transform(data_scaled)

fig, ax = plt.subplots(figsize=(7, 5))
ax.scatter(transformed[:, 0], transformed[:, 1], s=5, color=cm2, alpha=0.6)
ax.scatter(transformed[:, 0], [-2]*len(transformed), color=cm3, s=5, alpha=0.6)
ax.axhline(-2, linewidth=1, color=gry)
ax.set_xlabel(f"Componente 1: [{fitted.explained_variance_ratio_[0]:.3f}]", color=cm2)
ax.set_ylabel(f"Componente 2: [{fitted.explained_variance_ratio_[1]:.3f}]", color=cm2)
ax.set_title("PCA — datos sintéticos 2D", color=cm2)
ax.tick_params(colors=cm2)
for sp in ax.spines.values(): sp.set_edgecolor(gry)
fig.tight_layout()
fig.savefig(f"{OUT}/pca_2d_result.png", dpi=150, bbox_inches="tight")
plt.close()
print("pca_2d_result.png")

# ─── 6. PCA sobre Iris ───────────────────────────────────────────────────────
iris = datasets.load_iris(as_frame=True)
assert isinstance(iris, Bunch)
df_iris = iris.frame
pca2 = PCA(n_components=2)
iris_scaled = StandardScaler().fit_transform(df_iris.iloc[:, :4])
fitted2 = pca2.fit(iris_scaled)
transformed2 = fitted2.transform(iris_scaled)

colors_iris = [cm3, cm1, cm2]
fig, ax = plt.subplots(figsize=(7, 5))
for i, name in enumerate(iris.target_names):
    mask = df_iris["target"] == i
    ax.scatter(transformed2[mask, 0], transformed2[mask, 1],
               label=name, color=colors_iris[i], alpha=0.7, s=20)
ax.set_xlabel(f"Componente 1: {fitted2.explained_variance_ratio_[0]:.3f}", color=cm2)
ax.set_ylabel(f"Componente 2: {fitted2.explained_variance_ratio_[1]:.3f}", color=cm2)
ax.set_title("PCA — Iris dataset", color=cm2)
ax.legend()
ax.tick_params(colors=cm2)
for sp in ax.spines.values(): sp.set_edgecolor(gry)
fig.tight_layout()
fig.savefig(f"{OUT}/pca_iris.png", dpi=150, bbox_inches="tight")
plt.close()
print("pca_iris.png")

# ─── 7. PCA loadings (components) ────────────────────────────────────────────
comp = fitted2.components_
feature_names = list(df_iris.columns[:4])
fig, ax = plt.subplots(figsize=(7, 4))
x = np.arange(len(feature_names))
width = 0.35
ax.bar(x - width/2, comp[0], width, label="PC1", color=cm2, alpha=0.85)
ax.bar(x + width/2, comp[1], width, label="PC2", color=cm3, alpha=0.85)
ax.set_xticks(x, feature_names, rotation=15, ha="right", color=cm2)
ax.set_ylabel("Loading", color=cm2)
ax.set_title("Cargas de los componentes principales — Iris", color=cm2)
ax.legend()
ax.tick_params(colors=cm2)
ax.axhline(0, linewidth=0.8, color=gry)
for sp in ax.spines.values(): sp.set_edgecolor(gry)
fig.tight_layout()
fig.savefig(f"{OUT}/pca_iris_loadings.png", dpi=150, bbox_inches="tight")
plt.close()
print("pca_iris_loadings.png")

# ─── 8. t-SNE sobre Iris ─────────────────────────────────────────────────────
iris2 = datasets.load_iris()
assert isinstance(iris2, Bunch)
X = iris2.data; y = iris2.target
X_scaled = StandardScaler().fit_transform(X)
tsne = TSNE(n_components=2, perplexity=30, learning_rate=200,
            n_iter_without_progress=1000, random_state=42)
X_tsne = tsne.fit_transform(X_scaled)

fig, ax = plt.subplots(figsize=(7, 5))
for i, name in enumerate(iris2.target_names):
    ax.scatter(X_tsne[y==i, 0], X_tsne[y==i, 1],
               label=name, color=colors_iris[i], alpha=0.7, s=20)
ax.set_title("t-SNE — Iris dataset", color=cm2)
ax.set_xlabel("t-SNE 1", color=cm2); ax.set_ylabel("t-SNE 2", color=cm2)
ax.legend()
ax.tick_params(colors=cm2)
for sp in ax.spines.values(): sp.set_edgecolor(gry)
fig.tight_layout()
fig.savefig(f"{OUT}/tsne_iris.png", dpi=150, bbox_inches="tight")
plt.close()
print("tsne_iris.png")

# ─── 9. UMAP sobre Iris ──────────────────────────────────────────────────────
try:
    import umap
    umap_model = umap.UMAP(n_neighbors=15, min_dist=0.1, n_components=2,
                           metric="euclidean", random_state=42, n_jobs=1)
    X_umap = umap_model.fit_transform(X_scaled)
    assert isinstance(X_umap, np.ndarray)

    fig, ax = plt.subplots(figsize=(7, 5))
    for i, name in enumerate(iris2.target_names):
        ax.scatter(X_umap[y==i, 0], X_umap[y==i, 1],
                   label=name, color=colors_iris[i], alpha=0.7, s=20)
    ax.set_title("UMAP — Iris dataset", color=cm2)
    ax.set_xlabel("UMAP-1", color=cm2); ax.set_ylabel("UMAP-2", color=cm2)
    ax.legend()
    ax.tick_params(colors=cm2)
    for sp in ax.spines.values(): sp.set_edgecolor(gry)
    fig.tight_layout()
    fig.savefig(f"{OUT}/umap_iris.png", dpi=150, bbox_inches="tight")
    plt.close()
    print("umap_iris.png")

    trust = trustworthiness(X_scaled, X_umap, n_neighbors=15)
    print(f"Trustworthiness: {trust:.4f}")
    with open(f"{OUT}/umap_trust.txt", "w") as f:
        f.write(f"{trust:.4f}")
except ImportError:
    print("umap-learn not installed, skipping UMAP")

# ─── 10. MCA — datos sintéticos ──────────────────────────────────────────────
data_vars = [
    ("organism", ["homo sapiens", "sus scrofa", "calomys laucha", "xenopus laevis"]),
    ("disorder", ["fully disordered", "highly disordered", "low disorder", "structured"]),
    ("localization", ["cytoplasm", "nucleus", "p-granule", "mitochondria", "reticulus"]),
    ("llps", ["driver", "client", "regulator", "not involved"]),
    ("haslcregion", ["yes", "no"]),
    ("hasrnabindingdomain", ["yes", "no"]),
]
g1 = [[0.25]*4, [0.03,0.09,0.40,0.48], [0.15,0.15,0.01,0.20,0.49],
      [0.01,0.09,0.10,0.80], [0.30,0.70], [0.25,0.75]]
g2 = [[0.25]*4, [0.60,0.20,0.20,0.00], [0.05,0.15,0.55,0.15,0.10],
      [0.60,0.15,0.18,0.07], [0.90,0.10], [0.75,0.25]]
g3 = [[0.25]*4, [0.01,0.10,0.88,0.01], [0.85,0.04,0.04,0.04,0.03],
      [0.25,0.25,0.25,0.25], [0.50,0.50], [0.50,0.50]]
groups_params = [g1, g2, g3]
gs = [0.35, 0.35, 0.30]
n = 1000
np.random.seed(42)
gr = np.argmax(st.multinomial.rvs(1, gs, n), axis=1)

def create_sample(group):
    values = [group]
    for (var, labels), frq in zip(data_vars, groups_params[group]):
        lbl_index = np.argmax(st.multinomial.rvs(1, frq, 1), axis=1)
        values.append(labels[lbl_index[0]])
    return values

sim_data = list(map(create_sample, gr))
df_mca = pd.DataFrame(data=sim_data, columns=["group"] + [x[0] for x in data_vars])

try:
    import prince
    mca = prince.MCA(n_components=6)
    fitted_mca = mca.fit(df_mca.iloc[:, 1:])
    transformed_mca = mca.transform(df_mca.iloc[:, 1:])

    fig, ax = plt.subplots(figsize=(8, 7))
    scatter = ax.scatter(
        transformed_mca.iloc[:, 0], transformed_mca.iloc[:, 1],
        c=df_mca["group"], cmap="viridis", s=10, alpha=0.6)
    handles, _ = scatter.legend_elements()
    ax.legend(handles, ["Grupo 1", "Grupo 2", "Grupo 3"])
    ax.set_xlabel("Dimensión 1", color=cm2); ax.set_ylabel("Dimensión 2", color=cm2)
    ax.set_title("MCA — datos categóricos sintéticos", color=cm2)
    ax.tick_params(colors=cm2)
    for sp in ax.spines.values(): sp.set_edgecolor(gry)
    fig.tight_layout()
    fig.savefig(f"{OUT}/mca_scatter.png", dpi=150, bbox_inches="tight")
    plt.close()
    print("mca_scatter.png")

    # Column coordinates (localization)
    col_coords = fitted_mca.column_coordinates(df_mca.iloc[:, 1:])
    loc_mask = col_coords.index.map(lambda x: x.startswith("localization_"))
    loc_coords = col_coords.iloc[loc_mask, [0, 1]]
    colors_loc = [cm2, cm3, cm1, "#e74c3c", "#27ae60"]

    fig, ax = plt.subplots(figsize=(8, 7))
    ax.scatter(
        transformed_mca.iloc[:, 0], transformed_mca.iloc[:, 1],
        c=df_mca["group"].map({0: cm2+"44", 1: cm3+"44", 2: cm1+"44"}),
        s=5, alpha=0.4)
    for i, (idx, row) in enumerate(loc_coords.iterrows()):
        label = idx.split("__")[-1] if "__" in idx else idx.split("_", 1)[-1]
        ax.scatter(row.iloc[0], row.iloc[1], marker="X",
                   color=colors_loc[i % len(colors_loc)], s=150, zorder=5)
        ax.annotate(label, (row.iloc[0], row.iloc[1]),
                    textcoords="offset points", xytext=(6, 4), fontsize=9, color=cm2)
    ax.set_xlabel("Dimensión 1", color=cm2); ax.set_ylabel("Dimensión 2", color=cm2)
    ax.set_title("MCA — coordenadas de categorías (localización)", color=cm2)
    ax.tick_params(colors=cm2)
    for sp in ax.spines.values(): sp.set_edgecolor(gry)
    fig.tight_layout()
    fig.savefig(f"{OUT}/mca_col_coords.png", dpi=150, bbox_inches="tight")
    plt.close()
    print("mca_col_coords.png")

except ImportError:
    print("prince not installed, skipping MCA")

print("Done.")
