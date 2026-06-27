import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
from matplotlib.patches import FancyBboxPatch
import numpy as np

cm2 = "#032e35"
cm1 = "#a3804c"
cm3 = "#00a1ae"
gry = "#6B7280"
grn = "#15803D"
bg = "#f9f8f5"

# ════════════════════════════════════════════════════════════════════════════
# IMAGE 1: chaid_tree.png — árbol CHAID completo con splits multi-vía
# ════════════════════════════════════════════════════════════════════════════
fig, ax = plt.subplots(figsize=(12, 5), facecolor=bg)
ax.set_xlim(0, 12)
ax.set_ylim(2, 7)
ax.axis("off")
ax.set_facecolor(bg)


def node(ax, x, y, w, h, title, body, face, tc="white"):
    r = FancyBboxPatch(
        (x - w / 2, y - h / 2),
        w,
        h,
        boxstyle="round,pad=0.08",
        linewidth=1.5,
        edgecolor=face,
        facecolor=face,
    )
    ax.add_patch(r)
    ax.text(
        x,
        y + 0.10,
        title,
        ha="center",
        va="center",
        fontsize=9,
        fontweight="bold",
        color=tc,
    )
    ax.text(x, y - 0.22, body, ha="center", va="center", fontsize=7.5, color=tc)


def split_node(ax, x, y, w, h, title, body):
    r = FancyBboxPatch(
        (x - w / 2, y - h / 2),
        w,
        h,
        boxstyle="round,pad=0.08",
        linewidth=1.5,
        edgecolor=cm1,
        facecolor="#fdf6ee",
    )
    ax.add_patch(r)
    ax.text(
        x,
        y + 0.10,
        title,
        ha="center",
        va="center",
        fontsize=9,
        fontweight="bold",
        color=cm1,
    )
    ax.text(x, y - 0.22, body, ha="center", va="center", fontsize=7.5, color=gry)


def leaf_node(ax, x, y, label, pct, color):
    r = FancyBboxPatch(
        (x - 0.5, y - 0.4),
        1.0,
        0.8,
        boxstyle="round,pad=0.06",
        linewidth=1.5,
        edgecolor=color,
        facecolor=color + "22",
    )
    ax.add_patch(r)
    ax.text(
        x,
        y + 0.12,
        label,
        ha="center",
        va="center",
        fontsize=8.5,
        fontweight="bold",
        color=color,
    )
    ax.text(x, y - 0.16, pct, ha="center", va="center", fontsize=7.5, color=gry)


def arrow(ax, x1, y1, x2, y2):
    ax.annotate(
        "",
        xy=(x2, y2 + 0.42),
        xytext=(x1, y1 - 0.37),
        arrowprops=dict(arrowstyle="->", color=cm2, lw=1.4),
    )


# Root
node(ax, 6, 6.3, 3.4, 0.75, "Región geográfica", "χ² = 42.3,  p < 0.001", cm2)


for tx, lbl in [(3.3, "Norte"), (5.7, "Centro"), (8.7, "Sur")]:
    ax.text(tx, 5.55, lbl, ha="center", fontsize=7.5, color=cm1, style="italic")
arrow(ax, 6, 6.7, 2.0, 4.5)
arrow(ax, 6, 6.7, 6.0, 4.5)
arrow(ax, 6, 6.7, 10.0, 4.5)

# Leaves Norte
for lx, ll, pp in [
    (0.75, "32%", "<30 a."),
    (2.0, "61%", "30-50 a."),
    (3.25, "47%", ">50 a."),
]:
    leaf_node(ax, lx, 2.65, f"Compra: {ll}", pp, cm2)
    arrow(ax, 2.0, 4.45, lx, 2.65)

# Leaves Sur
for lx, ll, pp in [(8.9, "29%", "Bajo"), (10.0, "53%", "Medio"), (11.1, "78%", "Alto")]:
    leaf_node(ax, lx, 2.65, f"Compra: {ll}", pp, grn)
    arrow(ax, 10.0, 4.45, lx, 2.65)

# Level 1
split_node(ax, 2.0, 4.5, 2.4, 0.7, "Edad", "χ² = 18.5,  p = 0.004")
leaf_node(ax, 6.0, 4.5, "Compra: 58%", "sin división sig.", cm3)
split_node(ax, 10.0, 4.5, 2.4, 0.7, "Ingreso", "χ² = 21.7,  p < 0.001")

ax.text(
    6.0,
    6.82,
    "Árbol CHAID — splits multi-vía guiados por χ²",
    ha="center",
    fontsize=11,
    fontweight="bold",
    color=cm2,
)

plt.tight_layout()
plt.savefig("images/chaid_tree.png", dpi=150, bbox_inches="tight", facecolor=bg)
plt.close()
print("images/chaid_tree.png saved")

# ════════════════════════════════════════════════════════════════════════════
# IMAGE 2: chaid_merge.png — fusión de categorías paso a paso
# ════════════════════════════════════════════════════════════════════════════
fig, axes = plt.subplots(1, 3, figsize=(13, 5), facecolor=bg)
fig.patch.set_facecolor(bg)

steps = [
    (
        ["Cat A", "Cat B", "Cat C", "Cat D", "Cat E"],
        [0.92, 0.69, 0.71, 0.41, 0.38],
        "Paso 1: 5 categorías originales",
        [1, 2],
    ),
    (
        ["Cat A", "Cat B+C", "Cat D", "Cat E"],
        [0.92, 0.70, 0.41, 0.38],
        "Paso 2: B y C fusionadas (p=0.83)",
        [2, 3],
    ),
    (
        ["Cat A", "Cat B+C", "Cat D+E"],
        [0.92, 0.70, 0.395],
        "Paso 3: D y E fusionadas (p=0.79)",
        [],
    ),
]

for ax, (cats, yes, title, hi) in zip(axes, steps):
    ax.set_facecolor(bg)
    no = [1 - y for y in yes]
    x = np.arange(len(cats))
    ax.bar(x, yes, color=cm3, alpha=0.85, width=0.55, label="Sí")
    ax.bar(x, no, bottom=yes, color=cm1, alpha=0.7, width=0.55, label="No")
    ax.set_xticks(x)
    ax.set_xticklabels(cats, fontsize=9, color=cm2)
    ax.set_ylim(0, 1.22)
    ax.set_yticks([0, 0.5, 1.0])
    ax.set_yticklabels(["0%", "50%", "100%"], fontsize=8, color=gry)
    ax.set_title(title, fontsize=9.5, fontweight="bold", color=cm2, pad=8)
    ax.spines[["top", "right", "left"]].set_visible(False)
    ax.spines["bottom"].set_color(gry)
    ax.tick_params(colors=gry, length=3)
    for i, y in enumerate(yes):
        ax.text(i, y + 0.03, f"{y:.0%}", ha="center", fontsize=8, color=cm2)
    for idx in hi:
        ax.get_xticklabels()[idx].set_color(cm1)
        ax.get_xticklabels()[idx].set_fontweight("bold")

for xpos in [0.365, 0.635]:
    fig.text(
        xpos,
        0.48,
        "→",
        ha="center",
        va="center",
        fontsize=26,
        color=cm1,
        fontweight="bold",
    )

legend_patches = [
    mpatches.Patch(color=cm3, label="Compra = Sí"),
    mpatches.Patch(color=cm1, label="Compra = No"),
]
fig.legend(
    handles=legend_patches, loc="upper right", fontsize=9, frameon=False, labelcolor=cm2
)
fig.suptitle(
    "Fusión de categorías — CHAID agrupa categorías con respuestas similares antes de dividir",
    fontsize=10.5,
    fontweight="bold",
    color=cm2,
    y=1.03,
)

plt.tight_layout()
plt.savefig("images/chaid_merge.png", dpi=150, bbox_inches="tight", facecolor=bg)
plt.close()
print("images/chaid_merge.png saved")

# ════════════════════════════════════════════════════════════════════════════
# IMAGE 3: chaid_vs_cart.png — comparación CART (binario) vs CHAID (multi-vía)
# ════════════════════════════════════════════════════════════════════════════
fig, axes = plt.subplots(1, 2, figsize=(11, 5.5), facecolor=bg)
fig.patch.set_facecolor(bg)


def draw_tree(ax, title, root_color, branches):
    ax.set_xlim(0, 10)
    ax.set_ylim(0.5, 6.5)
    ax.axis("off")
    ax.set_facecolor(bg)
    ax.set_title(title, fontsize=11.5, fontweight="bold", color=root_color, pad=10)

    r = FancyBboxPatch(
        (2.8, 4.7),
        4.4,
        0.9,
        boxstyle="round,pad=0.1",
        linewidth=2,
        edgecolor=root_color,
        facecolor=root_color,
    )
    ax.add_patch(r)
    ax.text(
        5,
        5.15,
        "Estado civil",
        ha="center",
        va="center",
        fontsize=11,
        fontweight="bold",
        color="white",
    )

    n = len(branches)
    xs = np.linspace(10 / (n + 1), 10 - 10 / (n + 1), n)
    for i, (lbl, pct, bc) in enumerate(branches):
        x = xs[i]
        ax.annotate(
            "",
            xy=(x, 3.15),
            xytext=(5, 4.7),
            arrowprops=dict(arrowstyle="->", color=cm2, lw=1.3),
        )
        mx = (x + 5) / 2
        offset = 0.25 if n > 2 and i == 1 else 0
        ax.text(
            mx, 4.0 + offset, lbl, ha="center", fontsize=8.5, color=cm1, style="italic"
        )
        lp = FancyBboxPatch(
            (x - 1.05, 2.3),
            2.1,
            0.85,
            boxstyle="round,pad=0.08",
            linewidth=1.5,
            edgecolor=bc,
            facecolor=bc + "22",
        )
        ax.add_patch(lp)
        ax.text(x, 2.82, lbl, ha="center", fontsize=9, fontweight="bold", color=bc)
        ax.text(x, 2.52, pct, ha="center", fontsize=8.5, color=gry)


draw_tree(
    axes[0],
    "CART — split binario (2 ramas)",
    cm2,
    [("Casado/a", "Compra: 64%", cm3), ("No casado/a", "Compra: 41%", cm1)],
)

draw_tree(
    axes[1],
    "CHAID — split multi-vía (3 ramas)",
    cm1,
    [
        ("Soltero/a", "Compra: 38%", grn),
        ("Casado/a", "Compra: 66%", cm3),
        ("Divorc./Viudo", "Compra: 45%", cm1),
    ],
)

axes[0].text(
    5,
    1.4,
    "Solteros, divorciados y viudos\nquedan en el mismo nodo",
    ha="center",
    fontsize=8.5,
    color=gry,
    bbox=dict(boxstyle="round,pad=0.4", facecolor="#f0f4f4", edgecolor=gry, alpha=0.7),
)

axes[1].text(
    5,
    1.4,
    "Cada grupo con respuesta distinta\nobtiene su propia rama",
    ha="center",
    fontsize=8.5,
    color=gry,
    bbox=dict(boxstyle="round,pad=0.4", facecolor="#f0fdf4", edgecolor=cm3, alpha=0.7),
)

plt.tight_layout()
plt.savefig("images/chaid_vs_cart.png", dpi=150, bbox_inches="tight", facecolor=bg)
plt.close()
print("images/chaid_vs_cart.png saved")
