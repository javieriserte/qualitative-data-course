"""Generate images for C02.4 presentation."""
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib
import statsmodels.api as sm
import scipy.stats as st
from rdatasets import data
from sklearn.metrics import classification_report

matplotlib.rcParams.update({
    "font.family": "DejaVu Sans",
    "axes.spines.top": False,
    "axes.spines.right": False,
    "figure.dpi": 150,
})

CM2 = "#032e35"
CM1 = "#a3804c"
CM3 = "#00a1ae"
GRY = "#6B7280"
BG  = "#f9f8f5"

# ─── Dataset survey ──────────────────────────────────────────────────────────
np.random.seed(42)

survey = data("MASS", "survey")
survey.dropna(inplace=True)

survey_mod = survey[["Height", "Sex", "Smoke", "Exer"]]
survey_mod = pd.get_dummies(survey_mod).astype(float)
selected_columns = ['Height', 'Sex_Female', 'Smoke_Never', 'Smoke_Occas', 'Smoke_Regul', 'Exer_Freq']
survey_mod = survey_mod[selected_columns]

train_frac = 0.7
train_elems = int(round(train_frac * len(survey_mod)))
shuffled = survey_mod.index.to_numpy().copy()
np.random.shuffle(shuffled)
train_idx = shuffled[:train_elems]
test_idx  = shuffled[train_elems:]

survey_train = survey_mod.loc[train_idx]
survey_test  = survey_mod.loc[test_idx]

exog_train = sm.add_constant(survey_train.drop(columns=["Height"]))
regmod = sm.OLS(endog=survey_train["Height"].to_numpy(), exog=exog_train)
fitted = regmod.fit()

exog_test = sm.add_constant(survey_test.drop(columns=["Height"]))
test_predicted = fitted.predict(exog_test)

# ── IMAGE 1: real vs predicted (OLS con dummies) ──────────────────────────────
fig, ax = plt.subplots(figsize=(6, 5), facecolor=BG)
ax.set_facecolor(BG)
ax.scatter(survey_test["Height"], test_predicted, color=CM3, alpha=0.7, edgecolors=CM2, linewidths=0.4, s=50)
pearson_corr = st.pearsonr(survey_test["Height"], test_predicted.astype(float))
fitted2 = sm.OLS(survey_test["Height"], sm.add_constant(test_predicted)).fit()
x_line = np.linspace(survey_test["Height"].min(), survey_test["Height"].max(), 100)
ax.plot(x_line, fitted2.params @ sm.add_constant(x_line).T, color=CM1, linewidth=2)
ax.set_xlabel("Altura real (cm)", color=CM2)
ax.set_ylabel("Altura predicha (cm)", color=CM2)
ax.tick_params(colors=CM2)
ax.text(0.05, 0.93, f"ρ = {pearson_corr[0]:.3f}", transform=ax.transAxes,
        color=CM2, fontsize=12)
ax.set_title("OLS con variables dummy — test set", color=CM2, fontsize=13)
plt.tight_layout()
plt.savefig("images/ols_dummy_scatter.png", dpi=150, bbox_inches="tight", facecolor=BG)
plt.close()
print("Saved ols_dummy_scatter.png")

# ─── Dataset ciudades ────────────────────────────────────────────────────────
c_data = {
    "ingreso": {"623":2328,"68":3418,"456":2650,"519":2653,"534":2084,"401":2181,"285":3004,
    "472":2371,"675":3210,"214":2921,"218":2645,"717":2549,"435":2616,"866":2907,
    "449":2445,"34":2211,"736":2213,"378":2683,"382":2459,"622":2797,"30":2825,
    "439":2745,"815":2868,"870":2392,"980":2643,"522":2534,"667":1924,"875":2886,
    "967":2475,"785":1947,"654":2762,"373":2545,"656":3120,"591":2782,"660":2234,
    "882":1992,"488":2448,"497":2624,"468":2333,"289":2740,"520":2044,"154":2721,
    "416":2134,"768":2309,"989":2530,"180":2085,"506":2377,"188":2715,"510":2154,
    "174":2346,"703":2536,"175":2586,"292":2525,"592":2581,"981":2539,"561":2909,
    "258":2619,"371":2747,"341":2483,"23":2536,"150":2420,"982":2482,"407":2707,
    "299":2237,"627":2031,"492":2473,"807":2469,"294":2564,"489":2471,"642":2237,
    "742":2299,"18":2631,"910":2395,"593":2948,"173":2317,"113":2207,"152":2464,
    "222":2747,"894":2586,"515":2847,"287":2164,"475":2287,"555":2094,"211":2862,
    "302":2673,"839":2293,"862":2372,"942":2593,"861":2380,"804":2485,"231":2347,
    "93":1972,"950":1806,"61":2225,"140":3259,"385":2291,"860":2463,"905":2645,
    "987":2582,"358":2165},
    "hijos": {"623":1,"68":5,"456":5,"519":5,"534":4,"401":5,"285":0,"472":4,"675":2,"214":3,
    "218":1,"717":3,"435":2,"866":4,"449":4,"34":3,"736":3,"378":2,"382":5,"622":2,
    "30":0,"439":2,"815":2,"870":3,"980":3,"522":4,"667":0,"875":2,"967":0,"785":0,
    "654":1,"373":4,"656":1,"591":4,"660":0,"882":4,"488":4,"497":0,"468":2,"289":3,
    "520":4,"154":2,"416":5,"768":3,"989":2,"180":2,"506":5,"188":0,"510":1,"174":5,
    "703":4,"175":2,"292":4,"592":3,"981":0,"561":1,"258":5,"371":2,"341":3,"23":2,
    "150":3,"982":4,"407":1,"299":0,"627":5,"492":3,"807":1,"294":1,"489":0,"642":4,
    "742":3,"18":0,"910":1,"593":0,"173":4,"113":1,"152":0,"222":4,"894":0,"515":3,
    "287":4,"475":2,"555":4,"211":5,"302":2,"839":1,"862":1,"942":2,"861":0,"804":3,
    "231":2,"93":3,"950":4,"61":4,"140":4,"385":2,"860":2,"905":2,"987":0,"358":1},
    "edad": {"623":38,"68":58,"456":47,"519":34,"534":44,"401":59,"285":67,"472":39,"675":43,
    "214":51,"218":47,"717":53,"435":49,"866":44,"449":52,"34":58,"736":48,"378":41,
    "382":57,"622":62,"30":66,"439":44,"815":39,"870":50,"980":51,"522":69,"667":50,
    "875":50,"967":59,"785":57,"654":50,"373":43,"656":49,"591":67,"660":62,"882":46,
    "488":56,"497":41,"468":55,"289":36,"520":52,"154":48,"416":42,"768":59,"989":47,
    "180":38,"506":56,"188":54,"510":65,"174":51,"703":53,"175":51,"292":56,"592":64,
    "981":48,"561":38,"258":43,"371":57,"341":55,"23":61,"150":59,"982":37,"407":39,
    "299":54,"627":68,"492":44,"807":48,"294":56,"489":46,"642":39,"742":61,"18":49,
    "910":47,"593":40,"173":62,"113":58,"152":54,"222":57,"894":48,"515":52,"287":47,
    "475":67,"555":41,"211":59,"302":40,"839":66,"862":53,"942":68,"861":58,"804":51,
    "231":49,"93":51,"950":60,"61":61,"140":47,"385":56,"860":50,"905":56,"987":40,
    "358":30},
    "horas_viaje": {"623":1.3077073133,"68":1.7057864113,"456":1.7361710411,"519":2.1592643379,
    "534":2.4231186384,"401":1.5415090428,"285":1.2007395476,"472":2.1042530608,
    "675":2.0282959365,"214":2.4972195066,"218":2.7112960592,"717":1.8239538714,
    "435":1.843082212,"866":2.1986395763,"449":2.2397828663,"34":1.1100948295,
    "736":1.299147434,"378":1.7776278184,"382":2.6780874672,"622":2.073778304,
    "30":2.0932151464,"439":2.2462378205,"815":1.456296133,"870":1.3880009599,
    "980":3.1395515936,"522":1.9111122808,"667":1.6907408609,"875":2.9073974231,
    "967":2.370960947,"785":0.9868502349,"654":2.1159957674,"373":1.5522843595,
    "656":2.1458480662,"591":1.2019193007,"660":1.814313605,"882":1.0206625751,
    "488":2.4212479693,"497":2.588476069,"468":1.3462991359,"289":1.5794437025,
    "520":1.473821603,"154":2.1939802745,"416":1.767307562,"768":1.1063891301,
    "989":1.4952199262,"180":1.9114397681,"506":2.1758224153,"188":1.8179933553,
    "510":2.1111104294,"174":1.845344654,"703":2.6364768067,"175":1.5133104673,
    "292":1.8370883252,"592":1.8975312625,"981":1.6820953428,"561":1.5365485729,
    "258":3.5611411945,"371":2.5092035582,"341":2.5849920666,"23":2.5235842879,
    "150":2.9403742649,"982":1.9134283584,"407":1.6487827105,"299":1.5788059964,
    "627":1.5026386033,"492":2.5152437957,"807":2.2370414691,"294":0.8261472401,
    "489":1.4548265614,"642":1.3803250516,"742":1.4127980333,"18":0.6359467871,
    "910":1.1310254729,"593":2.0237713173,"173":0.5746990368,"113":1.2332306696,
    "152":2.4136000374,"222":2.1310144808,"894":2.5390128857,"515":1.7622112712,
    "287":1.7499975211,"475":2.4137816498,"555":2.0229599479,"211":3.4705978509,
    "302":3.1902972182,"839":2.4637653567,"862":1.0528701327,"942":1.8112311216,
    "861":1.9290635632,"804":2.5901964205,"231":1.9076518576,"93":1.6033935115,
    "950":3.0840522907,"61":3.0414783704,"140":1.9050864622,"385":1.9492495705,
    "860":2.7768182934,"905":2.9796189029,"987":3.2822092477,"358":1.9504032354},
    "lugar": {"623":"Newark","68":"NewYork","456":"WestWood","519":"NewYork","534":"NewYork",
    "401":"NewYork","285":"Newark","472":"NewYork","675":"Newark","214":"NewYork",
    "218":"WestWood","717":"NewYork","435":"WestWood","866":"NewYork","449":"NewYork",
    "34":"WestWood","736":"WestWood","378":"Newark","382":"NewYork","622":"WestWood",
    "30":"Newark","439":"NewYork","815":"Newark","870":"NewYork","980":"NewYork",
    "522":"WestWood","667":"Newark","875":"NewYork","967":"WestWood","785":"Newark",
    "654":"Newark","373":"NewYork","656":"Newark","591":"WestWood","660":"Newark",
    "882":"NewYork","488":"NewYork","497":"Newark","468":"WestWood","289":"WestWood",
    "520":"NewYork","154":"WestWood","416":"NewYork","768":"WestWood","989":"WestWood",
    "180":"Newark","506":"NewYork","188":"Newark","510":"WestWood","174":"NewYork",
    "703":"NewYork","175":"Newark","292":"NewYork","592":"WestWood","981":"Newark",
    "561":"Newark","258":"NewYork","371":"NewYork","341":"WestWood","23":"WestWood",
    "150":"NewYork","982":"WestWood","407":"Newark","299":"Newark","627":"WestWood",
    "492":"WestWood","807":"WestWood","294":"Newark","489":"Newark","642":"WestWood",
    "742":"NewYork","18":"Newark","910":"WestWood","593":"Newark","173":"NewYork",
    "113":"Newark","152":"Newark","222":"WestWood","894":"Newark","515":"WestWood",
    "287":"NewYork","475":"WestWood","555":"NewYork","211":"NewYork","302":"WestWood",
    "839":"WestWood","862":"Newark","942":"WestWood","861":"Newark","804":"NewYork",
    "231":"NewYork","93":"WestWood","950":"NewYork","61":"NewYork","140":"NewYork",
    "385":"WestWood","860":"WestWood","905":"Newark","987":"Newark","358":"Newark"},
}
c_data = pd.DataFrame(c_data)
outputs = c_data["lugar"].unique()

train_frac = 0.5
train_elems = int(round(train_frac * len(c_data)))
shuffled2 = c_data.index.to_numpy().copy()
np.random.shuffle(shuffled2)
tr_idx = shuffled2[:train_elems]
te_idx = shuffled2[train_elems:]

c_train = c_data.loc[tr_idx]
c_test  = c_data.loc[te_idx]

exog_c = c_train[["ingreso", "hijos", "edad", "horas_viaje"]]
fitted_models = []
import statsmodels.api as sm2
for o in outputs:
    c_endog = (c_train["lugar"] == o).astype(int)
    m = sm2.Logit(endog=c_endog, exog=exog_c)
    fitted_models.append(m.fit(disp=False))

exog_te = c_test[["ingreso", "hijos", "edad", "horas_viaje"]]
predicted = np.column_stack([m.predict(exog_te) for m in fitted_models])
joint_predicted = np.argmax(predicted, axis=1)

test_values = c_test["lugar"].replace({outputs[0]: 0, outputs[1]: 1, outputs[2]: 2}).infer_objects(copy=False)

# ── IMAGE 2: OvR confusion heatmap ───────────────────────────────────────────
cont_table = st.contingency.crosstab(c_test["lugar"], outputs[joint_predicted])

fig, ax = plt.subplots(figsize=(5, 4), facecolor=BG)
ax.set_facecolor(BG)
im = ax.imshow(cont_table[1], cmap="Blues")
ax.set_xlabel("Predicciones", color=CM2)
ax.set_ylabel("Reales", color=CM2)
ax.set_xticks([0, 1, 2])
ax.set_yticks([0, 1, 2])
ax.set_xticklabels(cont_table[0][0], rotation=30, ha="right", color=CM2)
ax.set_yticklabels(cont_table[0][0], color=CM2)
ax.tick_params(colors=CM2)
for i, row in enumerate(cont_table[1]):
    for j, val in enumerate(row):
        ax.text(j, i, str(val), ha="center", va="center",
                color="white" if val > cont_table[1].max() / 2 else CM2, fontsize=14)
ax.set_title("OvR — Matriz de confusión (test)", color=CM2, fontsize=12)
plt.tight_layout()
plt.savefig("images/ovr_confusion.png", dpi=150, bbox_inches="tight", facecolor=BG)
plt.close()
print("Saved ovr_confusion.png")

# ── IMAGE 3: MNLogit confusion heatmap ───────────────────────────────────────
mnmodel = sm2.MNLogit(endog=c_train["lugar"], exog=c_train.iloc[:, :4])
mn_fitted = mnmodel.fit(disp=False)
mn_pred_probs = mn_fitted.predict(c_test.iloc[:, :4])
mn_classes = mn_fitted.model.endog_names if hasattr(mn_fitted.model, 'endog_names') else None
# get class order from model
mn_class_order = mn_fitted.model.wendog.columns.tolist() if hasattr(mn_fitted.model.wendog, 'columns') else None

# predict: argmax over columns
mn_pred_idx = np.argmax(mn_pred_probs.values, axis=1)
# get the class labels the model used
try:
    class_labels = mn_fitted.model.endog_names
except:
    class_labels = sorted(c_data["lugar"].unique())

mn_pred_labels = [class_labels[i] for i in mn_pred_idx]
cont2 = st.contingency.crosstab(c_test["lugar"], mn_pred_labels)

fig, ax = plt.subplots(figsize=(5, 4), facecolor=BG)
ax.set_facecolor(BG)
ax.imshow(cont2[1], cmap="Blues")
ax.set_xlabel("Predicciones", color=CM2)
ax.set_ylabel("Reales", color=CM2)
ax.set_xticks([0, 1, 2])
ax.set_yticks([0, 1, 2])
ax.set_xticklabels(cont2[0][0], rotation=30, ha="right", color=CM2)
ax.set_yticklabels(cont2[0][0], color=CM2)
ax.tick_params(colors=CM2)
for i, row in enumerate(cont2[1]):
    for j, val in enumerate(row):
        ax.text(j, i, str(val), ha="center", va="center",
                color="white" if val > cont2[1].max() / 2 else CM2, fontsize=14)
ax.set_title("MNLogit — Matriz de confusión (test)", color=CM2, fontsize=12)
plt.tight_layout()
plt.savefig("images/mnlogit_confusion.png", dpi=150, bbox_inches="tight", facecolor=BG)
plt.close()
print("Saved mnlogit_confusion.png")

# ── IMAGE 4: One-Hot encoding illustration ────────────────────────────────────
fig, ax = plt.subplots(figsize=(7, 3), facecolor=BG)
ax.set_facecolor(BG)
ax.axis("off")
categories = ["Rojo", "Verde", "Azul"]
colors_map = [CM1, CM3, "#15803D"]
data_table = [
    ["", "Rojo", "Verde", "Azul"],
    ["Rojo",  "1", "0", "0"],
    ["Verde", "0", "1", "0"],
    ["Azul",  "0", "0", "1"],
    ["Verde", "0", "1", "0"],
]
col_labels = data_table[0]
rows = data_table[1:]
tbl = ax.table(
    cellText=rows,
    colLabels=col_labels,
    cellLoc="center",
    loc="center",
)
tbl.auto_set_font_size(False)
tbl.set_fontsize(13)
for (r, c), cell in tbl.get_celld().items():
    cell.set_edgecolor("#cccccc")
    if r == 0:
        cell.set_facecolor(CM2)
        cell.set_text_props(color="white", weight="bold")
    elif c > 0 and rows[r-1][c] == "1":
        cell.set_facecolor(CM3 + "44" if len(CM3) == 7 else CM3)
        cell.set_text_props(color=CM2, weight="bold")
    else:
        cell.set_facecolor(BG)
        cell.set_text_props(color=GRY)
ax.set_title("One-Hot Encoding — ejemplo", color=CM2, fontsize=13, pad=10)
plt.tight_layout()
plt.savefig("images/onehot_example.png", dpi=150, bbox_inches="tight", facecolor=BG)
plt.close()
print("Saved onehot_example.png")

# ── IMAGE 5: Target encoding illustration ─────────────────────────────────────
fig, axes = plt.subplots(1, 2, figsize=(8, 3), facecolor=BG)
for ax in axes:
    ax.set_facecolor(BG)
    ax.axis("off")

# Left: original table
rows_orig = [["1","1","Rojo"],["2","4","Rojo"],["3","3","Verde"],["3","4","Verde"],
             ["6","7","Verde"],["2","4","Verde"],["1","5","Azul"],["2","7","Azul"]]
tbl1 = axes[0].table(cellText=rows_orig, colLabels=["Y","A","Color"],
                      cellLoc="center", loc="center")
tbl1.auto_set_font_size(False)
tbl1.set_fontsize(11)
color_fill = {"Rojo": "#fde8d8", "Verde": "#d4f0d4", "Azul": "#d0eaf8"}
for (r, c), cell in tbl1.get_celld().items():
    cell.set_edgecolor("#cccccc")
    if r == 0:
        cell.set_facecolor(CM2)
        cell.set_text_props(color="white", weight="bold")
    elif c == 2:
        cell.set_facecolor(color_fill.get(rows_orig[r-1][2], BG))
        cell.set_text_props(color=CM2)
    else:
        cell.set_facecolor(BG)
        cell.set_text_props(color=GRY)
axes[0].set_title("Original", color=CM2, fontsize=12)

# Right: encoded table
rows_enc = [["1","1","1.5"],["2","4","1.5"],["3","3","3.5"],["3","4","3.5"],
            ["6","7","3.5"],["2","4","3.5"],["1","5","1.5"],["2","7","1.5"]]
tbl2 = axes[1].table(cellText=rows_enc, colLabels=["Y","A","Color (enc)"],
                      cellLoc="center", loc="center")
tbl2.auto_set_font_size(False)
tbl2.set_fontsize(11)
enc_fill = {"1.5": "#fde8d8", "3.5": "#d4f0d4"}
for (r, c), cell in tbl2.get_celld().items():
    cell.set_edgecolor("#cccccc")
    if r == 0:
        cell.set_facecolor(CM2)
        cell.set_text_props(color="white", weight="bold")
    elif c == 2:
        cell.set_facecolor(enc_fill.get(rows_enc[r-1][2], BG))
        cell.set_text_props(color=CM2, weight="bold")
    else:
        cell.set_facecolor(BG)
        cell.set_text_props(color=GRY)
axes[1].set_title("Target Encoding", color=CM2, fontsize=12)

plt.suptitle("Target Encoding — transformación", color=CM2, fontsize=13)
plt.tight_layout()
plt.savefig("images/target_encoding.png", dpi=150, bbox_inches="tight", facecolor=BG)
plt.close()
print("Saved target_encoding.png")

print("All images generated.")
