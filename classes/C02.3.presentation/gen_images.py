import numpy as np
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
from matplotlib.patches import FancyArrowPatch

BG  = "#f9f8f5"
CM2 = "#032e35"
CM1 = "#a3804c"
CM3 = "#00a1ae"
GRY = "#6B7280"
RED = "#e74c3c"
GRN = "#15803D"

def style_ax(ax):
    ax.set_facecolor(BG)
    ax.tick_params(colors=CM2, labelsize=9)
    for spine in ax.spines.values():
        spine.set_edgecolor("#cccccc")
        spine.set_linewidth(0.8)
    ax.grid(True, color="#e0e0e0", linewidth=0.5, linestyle="--")

# ── 1. Función logística vs lineal ──────────────────────────────────────────
fig, ax = plt.subplots(figsize=(5.5, 3.5), facecolor=BG)
style_ax(ax)

x = np.linspace(-6, 6, 300)
logistic = 1 / (1 + np.exp(-x))
linear   = 0.5 + 0.15 * x

ax.plot(x, logistic, color=CM3, linewidth=2.5, label="Función logística")
ax.plot(x, linear,   color=RED, linewidth=1.8, linestyle="--", label="Regresión lineal")
ax.axhline(0, color="#cccccc", linewidth=0.8)
ax.axhline(1, color="#cccccc", linewidth=0.8)
ax.axhline(0.5, color=CM1, linewidth=1, linestyle=":", alpha=0.7)
ax.fill_between(x, 0, logistic, alpha=0.08, color=CM3)
ax.set_xlabel("η = α + βX", color=CM2, fontsize=10)
ax.set_ylabel("P(Y=1 | X)", color=CM2, fontsize=10)
ax.set_title("Función logística vs regresión lineal", color=CM2, fontsize=11, pad=8)
ax.set_ylim(-0.15, 1.15)
ax.legend(fontsize=9, facecolor=BG, edgecolor="#cccccc", labelcolor=CM2)
fig.tight_layout()
fig.savefig("images/logistic_vs_linear.png", dpi=150, bbox_inches="tight", facecolor=BG)
plt.close(fig)
print("logistic_vs_linear.png saved")

# ── 2. Interpretación odds ratio ────────────────────────────────────────────
fig, ax = plt.subplots(figsize=(5.5, 3.2), facecolor=BG)
style_ax(ax)

betas = np.array([-1.5, -0.8, 0.0, 0.5, 1.0, 1.5, 2.0])
odds  = np.exp(betas)
colors = [RED if b < 0 else (GRY if b == 0 else CM3) for b in betas]
labels = [f"β={b:.1f}" for b in betas]

bars = ax.bar(labels, odds, color=colors, width=0.6, zorder=3)
ax.axhline(1.0, color=CM1, linewidth=1.5, linestyle="--", zorder=4)
ax.text(len(betas) - 0.5, 1.08, "OR = 1 (sin efecto)", color=CM1, fontsize=8, ha="right")
ax.set_ylabel("Odds Ratio = e^β", color=CM2, fontsize=10)
ax.set_title("Odds Ratio según el valor de β", color=CM2, fontsize=11, pad=8)
ax.set_xlabel("Coeficiente β", color=CM2, fontsize=10)

dec_patch = mpatches.Patch(color=RED,  label="OR < 1 → reduce probabilidad")
neu_patch = mpatches.Patch(color=GRY,  label="OR = 1 → sin efecto")
inc_patch = mpatches.Patch(color=CM3,  label="OR > 1 → aumenta probabilidad")
ax.legend(handles=[dec_patch, neu_patch, inc_patch], fontsize=8,
          facecolor=BG, edgecolor="#cccccc", labelcolor=CM2)
fig.tight_layout()
fig.savefig("images/odds_ratio.png", dpi=150, bbox_inches="tight", facecolor=BG)
plt.close(fig)
print("odds_ratio.png saved")

# ── 3. Matriz de confusión ───────────────────────────────────────────────────
fig, ax = plt.subplots(figsize=(4.5, 3.5), facecolor=BG)
ax.set_facecolor(BG)
ax.axis("off")

matrix = [[17, 7], [2, 20]]
labels_m = [["TN", "FP"], ["FN", "TP"]]
colors_m = [[GRY, RED], [RED, GRN]]
alpha_m  = [[0.25, 0.35], [0.35, 0.35]]

for r in range(2):
    for c in range(2):
        rect = plt.Rectangle([c*0.45 + 0.05, (1-r)*0.4 + 0.05], 0.4, 0.35,
                              facecolor=colors_m[r][c], alpha=alpha_m[r][c],
                              transform=ax.transAxes, clip_on=False)
        ax.add_patch(rect)
        ax.text(c*0.45 + 0.25, (1-r)*0.4 + 0.275,
                f"{labels_m[r][c]}\n{matrix[r][c]}",
                ha="center", va="center", fontsize=13, fontweight="bold",
                color=CM2, transform=ax.transAxes)

ax.text(0.25, 0.97, "Pred: Male (0)",  ha="center", va="bottom", fontsize=9, color=GRY, transform=ax.transAxes)
ax.text(0.70, 0.97, "Pred: Female (1)",ha="center", va="bottom", fontsize=9, color=GRY, transform=ax.transAxes)
ax.text(-0.02, 0.72, "Real:\nMale(0)", ha="right", va="center", fontsize=9, color=GRY, transform=ax.transAxes, rotation=0)
ax.text(-0.02, 0.28, "Real:\nFemale(1)", ha="right", va="center", fontsize=9, color=GRY, transform=ax.transAxes, rotation=0)
ax.set_title("Matriz de confusión (ejemplo)", color=CM2, fontsize=11, pad=8)
fig.tight_layout()
fig.savefig("images/confusion_matrix.png", dpi=150, bbox_inches="tight", facecolor=BG)
plt.close(fig)
print("confusion_matrix.png saved")

# ── 4. ROC ideal vs random ───────────────────────────────────────────────────
fig, ax = plt.subplots(figsize=(4.5, 4.0), facecolor=BG)
style_ax(ax)

# Perfect classifier
ax.plot([0, 0, 1], [0, 1, 1], color=GRN, linewidth=2, label="Clasificador perfecto (AUC=1)")
# Random
ax.plot([0, 1], [0, 1], color=GRY, linewidth=1.5, linestyle="--", label="Azar (AUC=0.5)")
# Example model
fpr_ex = [0, 0.05, 0.1, 0.2, 0.3, 0.5, 0.7, 1.0]
tpr_ex = [0, 0.40, 0.65, 0.78, 0.87, 0.93, 0.97, 1.0]
ax.plot(fpr_ex, tpr_ex, color=CM3, linewidth=2.5, label="Modelo ejemplo (AUC≈0.90)")
ax.fill_between(fpr_ex, tpr_ex, alpha=0.10, color=CM3)

ax.set_xlabel("Tasa de falsos positivos (FPR)", color=CM2, fontsize=10)
ax.set_ylabel("Tasa de verdaderos positivos (TPR)", color=CM2, fontsize=10)
ax.set_title("Curva ROC", color=CM2, fontsize=11, pad=8)
ax.legend(fontsize=8, facecolor=BG, edgecolor="#cccccc", labelcolor=CM2)
ax.set_xlim(0, 1); ax.set_ylim(0, 1)
fig.tight_layout()
fig.savefig("images/roc_comparison.png", dpi=150, bbox_inches="tight", facecolor=BG)
plt.close(fig)
print("roc_comparison.png saved")

# ── 5. Umbral de decisión ────────────────────────────────────────────────────
fig, axes = plt.subplots(1, 3, figsize=(7, 2.8), facecolor=BG)
thresholds = [0.3, 0.5, 0.7]
titles     = ["Umbral bajo (0.3)", "Umbral estándar (0.5)", "Umbral alto (0.7)"]
for ax, thresh, title in zip(axes, thresholds, titles):
    style_ax(ax)
    x = np.linspace(0, 1, 300)
    # fake score distributions
    pos = np.random.default_rng(1).normal(0.65, 0.15, 400)
    neg = np.random.default_rng(2).normal(0.35, 0.15, 400)
    ax.hist(neg[neg>=0], bins=30, color=CM2, alpha=0.5, density=True, label="Neg")
    ax.hist(pos[pos<=1], bins=30, color=CM3, alpha=0.5, density=True, label="Pos")
    ax.axvline(thresh, color=CM1, linewidth=2, linestyle="--")
    ax.set_title(title, color=CM2, fontsize=9)
    ax.set_xlabel("Score", color=CM2, fontsize=8)
    ax.tick_params(labelsize=7)
axes[0].legend(fontsize=7, facecolor=BG, edgecolor="#cccccc", labelcolor=CM2)
fig.suptitle("Efecto del umbral de decisión", color=CM2, fontsize=11, y=1.02)
fig.tight_layout()
fig.savefig("images/threshold_effect.png", dpi=150, bbox_inches="tight", facecolor=BG)
plt.close(fig)
print("threshold_effect.png saved")

print("Done.")
