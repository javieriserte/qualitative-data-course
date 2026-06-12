import numpy as np
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import statsmodels.api as sm

rng = np.random.default_rng(42)
n = 30
X = rng.uniform(1, 8, n)
y = 2 + 1.5 * X + rng.normal(0, 1.2, n)

# Add one high-leverage + influential point
X = np.append(X, 12.0)
y = np.append(y, 2 + 1.5 * 12.0 + 6.0)   # influential: high leverage, large residual
X = np.append(X, 11.5)
y = np.append(y, 2 + 1.5 * 11.5 - 0.2)   # high leverage, small residual

Xc = sm.add_constant(X)
model = sm.OLS(y, Xc).fit()
influence = model.get_influence()
leverage = influence.hat_matrix_diag
cooks_d = influence.cooks_distance[0]

BG      = "#f9f8f5"
CM2     = "#032e35"
CM1     = "#a3804c"
CM3     = "#00a1ae"
GRY     = "#6B7280"
RED     = "#e74c3c"

def style_ax(ax):
    ax.set_facecolor(BG)
    ax.tick_params(colors=CM2, labelsize=9)
    for spine in ax.spines.values():
        spine.set_edgecolor("#cccccc")
        spine.set_linewidth(0.8)
    ax.grid(True, color="#e0e0e0", linewidth=0.5, linestyle="--")

# ── Figure 1: Leverage ──────────────────────────────────────────────────────
fig, ax = plt.subplots(figsize=(5, 3.2), facecolor=BG)
style_ax(ax)

threshold_h = 2 * 2 / len(X)   # 2*(p+1)/n, p=1
colors_h = [RED if h > threshold_h else CM2 for h in leverage]
ax.bar(range(len(X)), leverage, color=colors_h, width=0.7, zorder=3)
ax.axhline(threshold_h, color=CM1, linewidth=1.5, linestyle="--", zorder=4)
ax.text(len(X) - 1, threshold_h + 0.004,
        f"umbral = {threshold_h:.3f}", color=CM1, fontsize=8, ha="right")
ax.set_xlabel("Observación", color=CM2, fontsize=10)
ax.set_ylabel(r"$h_i$", color=CM2, fontsize=11)
ax.set_title("Leverage por observación", color=CM2, fontsize=11, pad=8)

normal_patch = mpatches.Patch(color=CM2, label="Leverage normal")
high_patch   = mpatches.Patch(color=RED, label="Alto leverage")
ax.legend(handles=[normal_patch, high_patch], fontsize=8,
          facecolor=BG, edgecolor="#cccccc", labelcolor=CM2)

fig.tight_layout()
fig.savefig("images/leverage.png", dpi=150, bbox_inches="tight", facecolor=BG)
plt.close(fig)
print("leverage.png saved")

# ── Figure 2: Cook's distance ───────────────────────────────────────────────
fig, ax = plt.subplots(figsize=(5, 3.2), facecolor=BG)
style_ax(ax)

threshold_d = 4 / len(X)
colors_d = [RED if d > threshold_d else CM2 for d in cooks_d]
ax.bar(range(len(X)), cooks_d, color=colors_d, width=0.7, zorder=3)
ax.axhline(threshold_d, color=CM1, linewidth=1.5, linestyle="--", zorder=4)
ax.text(len(X) - 1, threshold_d + 0.003,
        f"umbral = {threshold_d:.3f}", color=CM1, fontsize=8, ha="right")
ax.set_xlabel("Observación", color=CM2, fontsize=10)
ax.set_ylabel(r"$D_i$", color=CM2, fontsize=11)
ax.set_title("Distancia de Cook por observación", color=CM2, fontsize=11, pad=8)

normal_patch = mpatches.Patch(color=CM2, label="No influyente")
high_patch   = mpatches.Patch(color=RED, label="Influyente")
ax.legend(handles=[normal_patch, high_patch], fontsize=8,
          facecolor=BG, edgecolor="#cccccc", labelcolor=CM2)

fig.tight_layout()
fig.savefig("images/cook.png", dpi=150, bbox_inches="tight", facecolor=BG)
plt.close(fig)
print("cook.png saved")
