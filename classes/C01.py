import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from sympy import Symbol, integrate

plt.rcParams['text.usetex'] = True

data = {
  "Var. Explicativa" : [
    -5.0, -4.60, -4.20, -3.80, -3.40,
    -3.0, -2.60, -2.20, -1.80, -1.40,
    -1.0, -0.60, -0.20,  0.20,  0.60,
    1.0,   1.40,  1.80,  2.20,  2.60,
    3.0,   3.40,  3.80,  4.20,  4.60
  ],
  "Var. Dependiente" : [
    -0.916, -0.592, -0.735, -1.131, -0.735,
    -0.880, -0.991, -0.867, -0.328, -1.305,
    -0.724, -0.405, -0.255,  0.199,  0.833,
    0.602,   0.903,  0.919,  1.091,  1.001,
    0.865,   0.924,  0.921,  1.319,  1.088
  ]
}

def variables_plot():
  df = pd.DataFrame(data)
  ax = df.plot(0, 1, kind = 'scatter')

def pmf_example():
  PMF =  np.array(
    [0.05, 0.1, 0.4, 0.3, 0.1, 0.05]
  )
  bplot = plt.bar(
    x = np.arange(len(PMF)),
    height = PMF
  )
  plt.ylabel("Probability")
  plt.xlabel("Domain")
  bplot.patches[2].set_color("red")
  plt.annotate(
    xy = (2, 0.35),
    xytext = (2.8, 0.40),
    text = r"$PMF_{X}(x=2) = 0.4$",
    arrowprops = dict(
      fc = "green",
      ec = "none",
      width = 4,
    ),
    horizontalalignment='left',
    fontsize = 18,
    verticalalignment='top'
  )

def pdf_example():
  x = Symbol('x')
  fig, ax = plt.subplots()
  func = (-1.25*x**3 + 0.52*x**2 + 0.7*x) / 0.210833333333333
  xs = np.arange(1, step=0.05)
  ys = [float(func.evalf(subs={x:a})) for a in xs]
  ax.plot(xs, ys)
  ax.set_ylabel("Density")
  ax.set_xlabel("Domain")
  xs = xs[8: 13]
  ys = [float(func.evalf(subs={x:a})) for a in xs]
  ax.fill_between(xs, ys, color="lightblue")
  ax.annotate(
    xy = (0.5, 1.2),
    xytext = (0.02, 1.4),
    text = r'$\int_a^b{PDF_X(x)dx}$',
    arrowprops = dict(
      fc = "green",
      ec = "none",
      width = 4
    ),
    fontsize = 18
  )

def cmf_example():
  PMF =  np.array(
    [0.05, 0.1, 0.4, 0.3, 0.1, 0.05]
  )
  CMF = PMF.cumsum()
  xs = np.arange(len(PMF))
  fig, axes = plt.subplots()
  bars = axes.bar(x = xs, height = PMF, label = "PMF")
  axes.plot(xs, CMF, color = "red", label = "CMF")
  axes.legend()
  axes.set_xlabel("Domain")
  axes.set_ylabel("Probability")
  axes.scatter(
    x = 2,
    y = CMF[2],
    color = 'green',
    zorder = 2
  )
  axes.annotate(
    xy = (2, CMF[2]),
    xytext = (-0.5, 0.75),
    text = r'$CMF_X(2) = 0.55$',
    arrowprops = dict(
      facecolor = 'black',
      ec = 'none',
      shrink = 0.05,
      width = 4
    ),
    fontsize = 18,
    bbox = dict(
      boxstyle = 'round',
      fc = 'lightgray'
    )
  )
  for patch in bars.patches[0:3]:
    patch.set_color('lightblue')

def cdf_example():
  x = Symbol('x')
  func = (-1.25*x**3 + 0.52*x**2 + 0.7*x) / 0.210833333333333
  func_int = integrate(func, x)
  xs = np.arange(1, step=0.05)
  PDF = [
    float(func.evalf(subs={x:i}))
    for i in xs
  ]
  CDF = [
    float(func_int.evalf(subs={x:i}))
    for i in xs
  ]
  fig, axes = plt.subplots()
  axes.plot(
    xs,
    PDF,
    label = "PDF"
  )
  axes.plot(xs, CDF, color = "red", label = "CDF")
  axes.fill_between(
    x = xs[0:13],
    y1 = PDF[0:13],
    color = "lightblue"
  )
  axes.annotate(
    xy = (xs[12], CDF[12]),
    xytext= (0.25, 1.5),
    text = (
      rf"$CDF_X({xs[12]:0.1f}) = $"
      rf" ${CDF[12]:0.3f}...$"
    ),
    arrowprops = dict(
      facecolor = 'black',
      ec = 'none',
      shrink = 0.05,
      width = 4
    ),
    fontsize = 16,
    horizontalalignment = 'center',
    verticalalignment = 'center',
    bbox = dict(
      boxstyle = 'round',
      fc = 'lightgray'
    )
  )
  axes.scatter(
    x = xs[12],
    y = CDF[12],
    color = 'green',
    zorder = 2
  )
  axes.legend()
