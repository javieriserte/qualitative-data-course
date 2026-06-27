import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch
import numpy as np
from sklearn.datasets import make_classification
from sklearn.ensemble import GradientBoostingClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import log_loss
from sklearn.tree import DecisionTreeRegressor

cm2 = "#032e35"
cm1 = "#a3804c"
cm3 = "#00a1ae"
gry = "#6B7280"
grn = "#15803D"
bg = "#f9f8f5"

# ════════════════════════════════════════════════════════════════════════════
# IMAGE 1: gb_sequential.png — Bagging (parallel) vs Boosting (sequential)
# ════════════════════════════════════════════════════════════════════════════
fig, axes = plt.subplots(1, 2, figsize=(13, 5.5), facecolor=bg)
fig.patch.set_facecolor(bg)


def tree_icon(ax, x, y, color, label, sublabel=None):
    r = FancyBboxPatch(
        (x - 0.55, y - 0.32),
        1.1,
        0.64,
        boxstyle="round,pad=0.07",
        linewidth=1.5,
        edgecolor=color,
        facecolor=color + "33",
    )
    ax.add_patch(r)
    ax.text(
        x,
        y + 0.07,
        label,
        ha="center",
        va="center",
        fontsize=9,
        fontweight="bold",
        color=color,
    )
    if sublabel:
        ax.text(
            x, y - 0.13, sublabel, ha="center", va="center", fontsize=7.5, color=gry
        )


def data_box(ax, x, y, label, color=cm2, w=1.4, h=0.5):
    r = FancyBboxPatch(
        (x - w / 2, y - h / 2),
        w,
        h,
        boxstyle="round,pad=0.07",
        linewidth=1.5,
        edgecolor=color,
        facecolor=color,
    )
    ax.add_patch(r)
    ax.text(
        x,
        y,
        label,
        ha="center",
        va="center",
        fontsize=9,
        fontweight="bold",
        color="white",
    )


def arr(ax, x1, y1, x2, y2, color=cm2):
    ax.annotate(
        "",
        xy=(x2, y2),
        xytext=(x1, y1),
        arrowprops=dict(arrowstyle="->", color=color, lw=1.4),
    )


# ── Left: Bagging ─────────────────────────────────────────────────────────
ax = axes[0]
ax.set_xlim(0, 7)
ax.set_ylim(-1, 6)
ax.axis("off")
ax.set_facecolor(bg)
ax.set_title(
    "Bagging — árboles en paralelo (Random Forest)",
    fontsize=10.5,
    fontweight="bold",
    color=cm2,
    pad=10,
)

data_box(ax, 3.5, 5.3, "Dataset original", w=2.2)

for i, x in enumerate([1.2, 3.5, 5.8]):
    r = FancyBboxPatch(
        (x - 0.65, 3.4),
        1.3,
        0.55,
        boxstyle="round,pad=0.06",
        linewidth=1,
        edgecolor=cm3,
        facecolor="#e8f8f9",
    )
    ax.add_patch(r)
    ax.text(
        x,
        3.67,
        f"Muestra {i + 1}",
        ha="center",
        fontsize=8,
        color=cm3,
        fontweight="bold",
    )
    arr(ax, 3.5, 5.05, x, 3.95, color=cm3)
    tree_icon(ax, x, 2.55, cm3, f"Árbol {i + 1}")
    arr(ax, x, 3.4, x, 2.88, color=cm3)

for x in [1.2, 3.5, 5.8]:
    arr(ax, x, 2.23, 3.5, 1.35, color=cm2)

r = FancyBboxPatch(
    (2.1, 0.65),
    2.8,
    0.7,
    boxstyle="round,pad=0.08",
    linewidth=2,
    edgecolor=cm2,
    facecolor=cm2,
)
ax.add_patch(r)
ax.text(
    3.5,
    1.0,
    "Votación / Promedio",
    ha="center",
    va="center",
    fontsize=9,
    fontweight="bold",
    color="white",
)

ax.text(
    3.5,
    0.2,
    "Todos los árboles se entrenan de forma independiente",
    ha="center",
    fontsize=8,
    color=gry,
    style="italic",
)

# ── Right: Boosting — pure vertical flow, no diagonal arrows ─────────────
ax = axes[1]
ax.set_xlim(0, 7)
ax.set_ylim(-1, 6.2)
ax.axis("off")
ax.set_facecolor(bg)
ax.set_title(
    "Boosting — árboles en secuencia (Gradient Boosting)",
    fontsize=10.5,
    fontweight="bold",
    color=cm1,
    pad=10,
)

cx = 3.5  # single center column
TW, TH = 2.8, 0.58
RW, RH = 3.2, 0.52


def add_box(ax, cx, cy, w, h, edge, face, zorder=3):
    ax.add_patch(
        FancyBboxPatch(
            (cx - w / 2, cy - h / 2),
            w,
            h,
            boxstyle="round,pad=0.07",
            linewidth=1.5,
            edgecolor=edge,
            facecolor=face,
            zorder=zorder,
        )
    )


def vadd_arrow(ax, cx, y_top, y_bot, color):
    """Vertical arrow from y_top down to y_bot, centered on cx."""
    ax.annotate(
        "",
        xy=(cx, y_bot),
        xytext=(cx, y_top),
        arrowprops=dict(arrowstyle="-|>", color=color, lw=1.5, mutation_scale=11),
        zorder=4,
    )


# y-centers, top to bottom
y_ds = 5.6
y_t1 = 4.65
y_r1 = 3.6
y_t2 = 2.55
y_r2 = 1.5
y_t3 = 0.45
y_sum = -0.35

# ── Dataset ───────────────────────────────────────────────────────────────
add_box(ax, cx, y_ds, 2.6, 0.58, cm2, cm2)
ax.text(
    cx,
    y_ds,
    "Dataset original",
    ha="center",
    va="center",
    fontsize=9,
    fontweight="bold",
    color="white",
    zorder=5,
)

# ── Árbol 1 ───────────────────────────────────────────────────────────────
vadd_arrow(ax, cx, y_ds - TH / 2, y_t1 + TH / 2, cm2)
add_box(ax, cx, y_t1, TW, TH, cm1, "#fdf6ee")
ax.text(
    cx,
    y_t1 + 0.10,
    "Árbol 1",
    ha="center",
    va="center",
    fontsize=9.5,
    fontweight="bold",
    color=cm1,
    zorder=5,
)
ax.text(
    cx,
    y_t1 - 0.17,
    "ajusta y  →  produce ŷ₁",
    ha="center",
    va="center",
    fontsize=8,
    color=gry,
    zorder=5,
)

# ── Residuos ε₁ ───────────────────────────────────────────────────────────
vadd_arrow(ax, cx, y_t1 - TH / 2, y_r1 + RH / 2, grn)
add_box(ax, cx, y_r1, RW, RH, grn, "#f0fdf4")
ax.text(
    cx,
    y_r1 + 0.09,
    "Residuos  ε₁ = y − ŷ₁",
    ha="center",
    va="center",
    fontsize=9,
    fontweight="bold",
    color=grn,
    zorder=5,
)
ax.text(
    cx,
    y_r1 - 0.15,
    "error que queda sin explicar",
    ha="center",
    va="center",
    fontsize=7.5,
    color=gry,
    zorder=5,
)

# ── Árbol 2 ───────────────────────────────────────────────────────────────
vadd_arrow(ax, cx, y_r1 - RH / 2, y_t2 + TH / 2, cm1)
add_box(ax, cx, y_t2, TW, TH, cm1, "#fdf6ee")
ax.text(
    cx,
    y_t2 + 0.10,
    "Árbol 2",
    ha="center",
    va="center",
    fontsize=9.5,
    fontweight="bold",
    color=cm1,
    zorder=5,
)
ax.text(
    cx,
    y_t2 - 0.17,
    "ajusta ε₁  →  produce ŷ₂",
    ha="center",
    va="center",
    fontsize=8,
    color=gry,
    zorder=5,
)

# ── Residuos ε₂ ───────────────────────────────────────────────────────────
vadd_arrow(ax, cx, y_t2 - TH / 2, y_r2 + RH / 2, grn)
add_box(ax, cx, y_r2, RW, RH, grn, "#f0fdf4")
ax.text(
    cx,
    y_r2 + 0.09,
    "Residuos  ε₂ = ε₁ − ŷ₂",
    ha="center",
    va="center",
    fontsize=9,
    fontweight="bold",
    color=grn,
    zorder=5,
)
ax.text(
    cx,
    y_r2 - 0.15,
    "error que queda sin explicar",
    ha="center",
    va="center",
    fontsize=7.5,
    color=gry,
    zorder=5,
)

# ── Árbol 3 ───────────────────────────────────────────────────────────────
vadd_arrow(ax, cx, y_r2 - RH / 2, y_t3 + TH / 2, cm1)
add_box(ax, cx, y_t3, TW, TH, cm1, "#fdf6ee")
ax.text(
    cx,
    y_t3 + 0.10,
    "Árbol 3",
    ha="center",
    va="center",
    fontsize=9.5,
    fontweight="bold",
    color=cm1,
    zorder=5,
)
ax.text(
    cx,
    y_t3 - 0.17,
    "ajusta ε₂  →  produce ŷ₃",
    ha="center",
    va="center",
    fontsize=8,
    color=gry,
    zorder=5,
)

# ── Suma final ────────────────────────────────────────────────────────────
vadd_arrow(ax, cx, y_t3 - TH / 2, y_sum + 0.30, cm2)
add_box(ax, cx, y_sum, 4.2, 0.58, cm1, cm1)
ax.text(
    cx,
    y_sum,
    "F = ŷ₁ + η·ŷ₂ + η·ŷ₃  (suma ponderada)",
    ha="center",
    va="center",
    fontsize=9,
    fontweight="bold",
    color="white",
    zorder=5,
)

ax.text(
    cx,
    -1,
    "Cada árbol corrige los errores del anterior",
    ha="center",
    fontsize=8,
    color=gry,
    style="italic",
    zorder=5,
)

plt.tight_layout()
plt.savefig("images/gb_sequential.png", dpi=150, bbox_inches="tight", facecolor=bg)
plt.close()
print("images/gb_sequential.png saved")

# ════════════════════════════════════════════════════════════════════════════
# IMAGE 2: gb_residuals.png — cada árbol ajusta los residuos (toy regression)
# ════════════════════════════════════════════════════════════════════════════
np.random.seed(42)
x = np.linspace(0, 6, 60)
y_true = np.sin(x) + 0.3 * x
y = y_true + np.random.normal(0, 0.15, len(x))

lr = 0.7
f0 = y.mean()
residuals = [y - f0]
preds = [np.full_like(y, f0)]
trees = []

for _ in range(3):
    t = DecisionTreeRegressor(max_depth=2)
    t.fit(x.reshape(-1, 1), residuals[-1])
    h = t.predict(x.reshape(-1, 1))
    trees.append(h)
    preds.append(preds[-1] + lr * h)
    residuals.append(y - preds[-1])

fig, axes = plt.subplots(2, 4, figsize=(14, 6), facecolor=bg)
fig.patch.set_facecolor(bg)

colors_tree = [cm3, cm1, grn]
iter_labels = ["Árbol 1", "Árbol 2", "Árbol 3"]

# Top row: cumulative prediction after each tree
for col, (pred, clr, lbl) in enumerate(zip(preds[1:], colors_tree, iter_labels)):
    ax = axes[0][col]
    ax.set_facecolor(bg)
    ax.scatter(x, y, s=12, color=gry, alpha=0.5, zorder=2)
    ax.plot(x, preds[0], color=gry, lw=1, linestyle=":", zorder=3)
    ax.plot(x, pred, color=clr, lw=2, zorder=4)
    ax.set_title(f"Predicción tras {lbl}", fontsize=9, fontweight="bold", color=clr)
    ax.spines[["top", "right"]].set_visible(False)
    ax.spines[["bottom", "left"]].set_color(gry)
    ax.tick_params(colors=gry, labelsize=7)
    ax.set_xlabel("x", fontsize=8, color=gry)

# Bottom row: residuals entering each tree
for col, (res, clr, lbl) in enumerate(zip(residuals[:3], colors_tree, iter_labels)):
    ax = axes[1][col]
    ax.set_facecolor(bg)
    ax.axhline(0, color=gry, lw=1, linestyle="--")
    ax.scatter(x, res, s=12, color=clr, alpha=0.7, zorder=2)
    ax.plot(x, trees[col], color=cm2, lw=2, zorder=3)
    ax.set_title(f"Residuos → {lbl}", fontsize=9, fontweight="bold", color=cm2)
    ax.spines[["top", "right"]].set_visible(False)
    ax.spines[["bottom", "left"]].set_color(gry)
    ax.tick_params(colors=gry, labelsize=7)
    ax.set_xlabel("x", fontsize=8, color=gry)

# Last column
ax = axes[0][3]
ax.set_facecolor(bg)
ax.scatter(x, y, s=12, color=gry, alpha=0.5, zorder=2)
ax.plot(x, preds[0], color=gry, lw=1, linestyle=":", label="F₀", zorder=3)
ax.plot(x, preds[-1], color=cm2, lw=2.5, label="F final", zorder=4)
ax.set_title("Predicción final", fontsize=9, fontweight="bold", color=cm2)
ax.spines[["top", "right"]].set_visible(False)
ax.spines[["bottom", "left"]].set_color(gry)
ax.tick_params(colors=gry, labelsize=7)
ax.set_xlabel("x", fontsize=8, color=gry)
ax.legend(fontsize=7, frameon=False, labelcolor=cm2)

ax = axes[1][3]
ax.set_facecolor(bg)
ax.axhline(0, color=gry, lw=1, linestyle="--")
ax.scatter(x, residuals[-1], s=12, color=cm2, alpha=0.7)
ax.set_title("Residuos finales", fontsize=9, fontweight="bold", color=cm2)
ax.spines[["top", "right"]].set_visible(False)
ax.spines[["bottom", "left"]].set_color(gry)
ax.tick_params(colors=gry, labelsize=7)
ax.set_xlabel("x", fontsize=8, color=gry)

axes[0][0].set_ylabel("y", fontsize=8, color=gry)
axes[1][0].set_ylabel("residuo", fontsize=8, color=gry)

fig.suptitle(
    "Gradient Boosting — cada árbol ajusta los residuos del ensemble anterior  (η = 0.7, max_depth = 2)",
    fontsize=10,
    fontweight="bold",
    color=cm2,
    y=1.02,
)
plt.tight_layout()
plt.savefig("images/gb_residuals.png", dpi=150, bbox_inches="tight", facecolor=bg)
plt.close()
print("images/gb_residuals.png saved")

# ════════════════════════════════════════════════════════════════════════════
# IMAGE 3: gb_learning_rate.png — learning rate effect + overfitting curve
# ════════════════════════════════════════════════════════════════════════════
X, y_cls = make_classification(
    n_samples=600, n_features=10, n_informative=5, random_state=0
)
X_tr, X_te, y_tr, y_te = train_test_split(X, y_cls, test_size=0.3, random_state=0)

fig, axes = plt.subplots(1, 2, figsize=(13, 5), facecolor=bg)
fig.patch.set_facecolor(bg)

# ── Left: learning rate effect ────────────────────────────────────────────
ax = axes[0]
ax.set_facecolor(bg)
for lr_val, clr in zip([0.01, 0.1, 0.5, 1.0], [cm3, grn, cm1, "#e63946"]):
    gb = GradientBoostingClassifier(
        n_estimators=200, learning_rate=lr_val, max_depth=3, random_state=0
    )
    gb.fit(X_tr, y_tr)
    scores = [log_loss(y_te, p) for p in gb.staged_predict_proba(X_te)]
    ax.plot(range(1, 201), scores, color=clr, lw=1.8, label=f"η = {lr_val}")

ax.set_xlabel("Número de árboles", fontsize=9, color=gry)
ax.set_ylabel("Log-loss (test)", fontsize=9, color=gry)
ax.set_title("Efecto del learning rate (η)", fontsize=10, fontweight="bold", color=cm2)
ax.legend(fontsize=9, frameon=False, labelcolor=cm2)
ax.spines[["top", "right"]].set_visible(False)
ax.spines[["bottom", "left"]].set_color(gry)
ax.tick_params(colors=gry)

# ── Right: train vs test overfitting ──────────────────────────────────────
ax = axes[1]
ax.set_facecolor(bg)
gb = GradientBoostingClassifier(
    n_estimators=300, learning_rate=0.2, max_depth=3, random_state=0
)
gb.fit(X_tr, y_tr)
train_sc = [log_loss(y_tr, p) for p in gb.staged_predict_proba(X_tr)]
test_sc = [log_loss(y_te, p) for p in gb.staged_predict_proba(X_te)]
best_n = int(np.argmin(test_sc)) + 1

ax.plot(range(1, 301), train_sc, color=cm3, lw=1.8, label="Entrenamiento")
ax.plot(range(1, 301), test_sc, color=cm1, lw=1.8, label="Test")
ax.axvline(best_n, color=grn, lw=1.5, linestyle="--", label=f"Óptimo: {best_n} árboles")
ax.fill_betweenx(
    [min(test_sc) * 0.95, max(test_sc) * 1.05], best_n, 300, alpha=0.07, color=cm1
)
ax.text(best_n + 8, max(test_sc) * 0.96, "Zona de\nsobreajuste", fontsize=8, color=cm1)
ax.set_xlabel("Número de árboles", fontsize=9, color=gry)
ax.set_ylabel("Log-loss", fontsize=9, color=gry)
ax.set_title(
    "Sobreajuste con demasiados árboles", fontsize=10, fontweight="bold", color=cm2
)
ax.legend(fontsize=9, frameon=False, labelcolor=cm2)
ax.spines[["top", "right"]].set_visible(False)
ax.spines[["bottom", "left"]].set_color(gry)
ax.tick_params(colors=gry)

fig.suptitle(
    "Gradient Boosting — learning rate y número de árboles",
    fontsize=10.5,
    fontweight="bold",
    color=cm2,
    y=1.02,
)
plt.tight_layout()
plt.savefig("images/gb_learning_rate.png", dpi=150, bbox_inches="tight", facecolor=bg)
plt.close()
print("images/gb_learning_rate.png saved")
