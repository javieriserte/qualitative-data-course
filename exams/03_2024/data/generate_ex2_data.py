#%%
import numpy as np
import pandas as pd

temp = np.array(["20C", "25C", "30C"])
genes = np.array(["AT1G01239", "AT2G01130","AT1G01060","AT3G02860","AT5G12041"])
gcat = np.array([
  "No_expresado",
  "Poco_expresado",
  "Medianamente_expresado",
  "Bastante_expreado",
  "Muy_Expresado"
])
rng = np.random.default_rng(seed=0)
gcoef = rng.normal(0, 1, 5)

#%%
mults = np.linspace([1, 1, 1, 1, 1], [1.4, -2, 2.4, -1.5, 0.9], 5)

#%%
coeffs = gcoef * mults
coeffs = coeffs.T.ravel()

#%%
temp_coeff = np.array([1, 1.6, 1.2])
coeffs = 10 * np.concatenate([coeffs, temp_coeff])

#%%
rng = np.random.default_rng(seed=0)

g_vals = rng.integers(0, 5, 5*200).reshape(200, 5)
g_labels = gcat[g_vals]

t_vals = rng.integers(0, 3, 1*200).reshape(200, 1)
t_labels = temp[t_vals]

data = np.column_stack([g_labels, t_labels])

data_df = pd.DataFrame(
  data,
  columns = np.concatenate([genes, ["Temp"]], axis=0)
)
#%%

data_dummies = pd.get_dummies(data_df).to_numpy()

Y = pd.DataFrame(data_dummies @ coeffs, columns = ["Altura"])

#%%
final_df = (
  pd.concat([data_df, Y], axis = 1)
)
final_df.to_csv(
  "exercise_two_data.csv",
  sep="\t",
  header=True,
  index=None
)