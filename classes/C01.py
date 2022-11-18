from sklearn import datasets
import pandas as pd
import numpy as np

import math
import numpy as np
import matplotlib.pyplot as plt
import scipy
import pandas as pd
from sympy import Symbol, integrate
from matplotlib.patches import FancyArrowPatch, Circle


# plt.rcParams['text.usetex'] = True

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

def normal_distribution_mu_plot():
  x = np.linspace(
    -6.5,
    6.5,
    100
  )
  fig, axes = plt.subplots()
  axes.plot(
    x,
    scipy.stats.norm.pdf(x, loc=0, scale=1),
    label=r'$(\sigma=1, \mu=0)$',
  )
  axes.plot(
    x,
    scipy.stats.norm.pdf(x, loc=3, scale=1),
    label=r'$(\sigma=1, \mu=3)$'
  )
  axes.plot(
    x,
    scipy.stats.norm.pdf(x, loc=-3, scale=1),
    label=r'$(\sigma=1, \mu=-3)$'
  )
  axes.set_ylim(0, 0.65)
  axes.legend(fontsize = 12)
  axes.set_title("Normal Distribution PDF")
  axes.plot(
    [0, 0],
    [0, scipy.stats.norm.pdf(0)],
    color = "blue"
  )
  axes.annotate(
    xy = (0, 0.4),
    xytext = (0, 0.47),
    text = r"$\mu=0$",
    arrowprops = {
      "arrowstyle": "->"
    },
    fontsize = 14
  )
  axes.plot(
    [-3, -3],
    [0, scipy.stats.norm.pdf(0)],
    color = "green"
  )
  axes.annotate(
    xy = (-3, 0.4),
    xytext = (-3, 0.47),
    text = r"$\mu=-3$",
    arrowprops = {
      "arrowstyle": "->"
    },
    fontsize = 14
  )
  axes.plot(
    [3, 3],
    [0, scipy.stats.norm.pdf(0)],
    color = "orange"
  )
  axes.annotate(
    xy = (3, 0.4),
    xytext = (3, 0.47),
    text = r"$\mu=3$",
    arrowprops = {
      "arrowstyle": "->"
    },
    fontsize = 14
  )

  fig.tight_layout()

def normal_dist_description():
  x = np.linspace(
    scipy.stats.norm.ppf(0.001),
    scipy.stats.norm.ppf(0.999),
    100
  )
  _, axes = plt.subplots()
  axes.plot(
    x,
    scipy.stats.norm.pdf(x, loc=0, scale=1),
    label=r'$Normal PDF(\sigma=1, \mu=0)$'
  )
  axes.plot(
    x,
    scipy.stats.norm.cdf(x, loc=0, scale=1),
    label=r'$Normal CDF(\sigma=1, \mu=0)$',
    color = 'red'
  )
  axes.annotate(
    xy = (1,0),
    xytext = (0.7, 0.4),
    text = r"$quantile(0.841) = 1$",
    arrowprops = dict(
      facecolor = 'black',
      width = 4,
      ec = 'none',
      shrink = 0.05
    ),
    fontsize = 16
  )
  x_fill = np.linspace(
    scipy.stats.norm.ppf(0.001),
    scipy.stats.norm.ppf(0.841),
    100
  )
  axes.fill_between(
    x_fill,
    scipy.stats.norm.pdf(x_fill, loc=0, scale=1),
    color = 'lightblue'
  )
  axes.legend()
  axes.scatter(
    x = [1, 1],
    y = [0, scipy.stats.norm.cdf(1)],
    color = 'green',
    zorder = 2
  )
  axes.annotate(
    xy = (1, scipy.stats.norm.cdf(1)),
    xytext = (-2.5, 0.6),
    text = r"$CDF(1) = 0.841$",
    arrowprops = dict(
      facecolor = 'black',
      width = 4,
      ec = 'none',
      shrink = 0.05
    ),
    fontsize = 16
  )

def normal_distribution_sigma_plot():
  x = np.linspace(-6.5, 6.5, 100)
  fig, axes = plt.subplots(ncols=1, nrows=2)
  axes = axes.flatten()
  for ax in axes:
    ax.set_ylim(0, 0.55)
  axes[0].plot(
    x,
    scipy.stats.norm.pdf(x, loc=0, scale=1),
    label=r'$(\sigma=1, \mu=0)$',
  )
  axes[0].set_xlabel('Domain')
  axes[0].set_ylabel('Density')
  bracket = FancyArrowPatch(
    (-1, 0.45),
    (1, 0.45),
    arrowstyle = "<->",
    mutation_scale = 6,
  )
  axes[0].add_patch(bracket)
  axes[0].text(
    x = 0,
    y = 0.50,
    s = r"$\sigma = 1$",
    horizontalalignment = "center",
    verticalalignment = "center",
    fontsize = 14
  )
  axes[1].plot(
    x,
    scipy.stats.norm.pdf(x, loc=0, scale=2),
    label=r'$(\sigma=2, \mu=0)$',
  )
  axes[1].set_xlabel('Domain')
  axes[1].set_ylabel('Density')
  bracket = FancyArrowPatch(
    (-2, 0.25),
    (2, 0.25),
    arrowstyle = "<->",
    mutation_scale = 6,
  )
  axes[1].add_patch(bracket)
  axes[1].text(
    x = 0,
    y = 0.30,
    s = r"$\sigma = 2$",
    horizontalalignment = "center",
    verticalalignment = "center",
    fontsize = 14
  )
  fig.tight_layout()

def central_limit_plot():
  fig, axes = plt.subplots(
    ncols = 2,
    nrows = 3,
    figsize = (6, 7)
  )
  axes = axes.flatten()
  sample_sizes = [10, 50, 250]
  xs = np.linspace(0, 6, 100)
  xs2 = np.linspace(0, 2, 100)
  for i, ssize in enumerate(sample_sizes):
    samples = [
      scipy.stats.expon.rvs(size = ssize)
      for _ in range(1000)
    ]
    sample_means = [
      s.mean()
      for s in samples
    ]
    axes[2*i].hist(
      samples[0],
      bins = 100,
      density = True
    )
    axes[2*i].set_title(f"Exp. Dist. Sample({ssize})")
    axes[2*i].plot(
      xs,
      scipy.stats.expon.pdf(xs),
      color = "red"
    )
    axes[2*i+1].hist(
      sample_means,
      bins = 50,
      density = True
    )
    axes[2*i+1].set_xlim(0, 2)
    axes[2*i+1].plot(
      xs2,
      scipy.stats.norm.pdf(
        xs2,
        loc=1,
        scale = scipy.stats.expon.std() / math.sqrt(ssize)
      ),
      color = "red"
    )
    fig.tight_layout()

def distribution_t_plot():
  fig, axes = plt.subplots()
  x = np.linspace(-3, 3, 100)
  freedom_degrees = [1, 5, 10, 20]
  for fd in freedom_degrees:
    y = scipy.stats.t.pdf(x, fd)
    axes.plot(
      x,
      y,
      label = f"freedom degrees = {fd}"
    )
  axes.plot(
    x,
    scipy.stats.norm.pdf(x),
    label = "Normal distribution"
  )
  axes.legend()
  fig.tight_layout()

def binomial_plot():
  fig, axes = plt.subplots()
  trials = 10
  ps = [0.25, 0.5]
  for p in ps:
    x = np.linspace(start = 0, stop = trials, num = trials+1)
    axes.scatter(
      x = x,
      y = scipy.stats.binom.pmf(
        k = x,
        n = trials,
        p = p
      ),
      label = rf"$(n={trials}, p={p})$"
    )
    axes.plot(
      x,
      scipy.stats.binom.pmf(
        k = x,
        n = trials,
        p = p
      )
    )
    if p == 0.5:
      axes.fill_between(
        x[x<=5],
        scipy.stats.binom.pmf(
          k = x[x<=5],
          n = trials,
          p = p
        ),
        color = "tab:orange",
        alpha = 0.4
      )
  axes.legend()
  axes.set_title("Binomial Distribution")
  axes.set_ylabel("Probaility")
  axes.set_xlabel("Successful trials")
  axes.annotate(
    xy = (5, scipy.stats.binom.pmf(5, 10, 0.5)),
    xytext = (7, 0.2),
    text = f"$PMF_X(5) = {scipy.stats.binom.pmf(5, 10, 0.5):0.3f}...$",
    arrowprops = dict(
      arrowstyle = "->",
      facecolor = "black"
    ),
    fontsize = 12,
    bbox = dict(
      boxstyle = "round",
      facecolor = "lightgray"
    )
  )


def binomial_cmf_plot():
  fig, axes = plt.subplots()
  trials = 10
  ps = [0.25, 0.5]
  for p in ps:
    x = np.linspace(start = 0, stop = trials, num = trials+1)
    axes.scatter(
      x = x,
      y = scipy.stats.binom.cdf(
        k = x,
        n = trials,
        p = p
      ),
      label = rf"$(n={trials}, p={p})$"
    )
    axes.plot(
      x,
      scipy.stats.binom.cdf(
        k = x,
        n = trials,
        p = p
      )
    )
  axes.legend()
  axes.set_title("Cummulative Binomial Distribution")
  axes.set_ylabel("Probaility")
  axes.set_xlabel("Successful trials")
  axes.annotate(
    xy = (5, scipy.stats.binom.cdf(5, 10, 0.5)),
    xytext = (6.5, 0.35),
    text = f"$CDF_X(5) = {scipy.stats.binom.cdf(5, 10, 0.5):0.3f}...$",
    arrowprops = dict(
      arrowstyle = "->",
      facecolor = "black"
    ),
    fontsize = 12,
    bbox = dict(
      boxstyle = "round",
      facecolor = "lightgray"
    )
  )

def mean_mode_median():
  d1 = scipy.stats.norm.rvs(
    loc = 12,
    scale = 3,
    size = 150,
    random_state = 1
  )
  d2 = scipy.stats.norm.rvs(
    loc = 19,
    scale = 5,
    size = 100,
    random_state = 1
  )
  d3 = scipy.stats.norm.rvs(
    loc = 40,
    scale = 2,
    size = 25,
    random_state = 1
  )
  d1 = pd.Series(np.concatenate((d1, d2))).astype(int)
  d2 = pd.Series(np.concatenate((d1, d3))).astype(int)
  fig, axes = plt.subplots(
    nrows=2,
    figsize=(9, 9)
  )
  axes[0].hist(
    d1,
    bins = np.arange(5, 45)
  )
  m_x = d1.mean()
  md_x = d1.median()
  mode_x = d1.mode()
  axes[0].plot(
    [m_x, m_x],
    [0, 25],
    label = "Media"
  )
  axes[0].plot(
    [md_x, md_x],
    [0, 25],
    label = "Mediana"
  )
  axes[0].plot(
    [mode_x, mode_x],
    [0, 25],
    label = "Moda"
  )
  axes[0].legend(
    fontsize=14
  )
  axes[1].hist(
    d2,
    bins = np.arange(5, 45)
  )
  m_x = d2.mean()
  md_x = d2.median()
  mode_x = d2.mode()
  axes[1].plot(
    [m_x, m_x],
    [0, 25],
    label = "Media"
  )
  axes[1].plot(
    [md_x, md_x],
    [0, 25],
    label = "Mediana"
  )
  axes[1].plot(
    [mode_x, mode_x],
    [0, 25],
    label = "Moda"
  )
  axes[1].legend(
    fontsize=14
  )

def dispersion_measures():
  d1 = scipy.stats.norm.rvs(
    loc = 12,
    scale = 3,
    size = 350,
    random_state = 1
  )
  d2 = scipy.stats.norm.rvs(
    loc = 19,
    scale = 5,
    size = 250,
    random_state = 1
  )
  d1 = pd.Series(np.concatenate((d1, d2))).astype(int)
  fig, axes = plt.subplots(
    figsize=(9, 6)
  )
  axes.hist(
    d1,
    bins = np.arange(0, 35),
    width = 0.9,
  )
  axes.set_ylim(0, 100)
  sd = d1.std()
  mean = d1.mean()
  q31 = d1.quantile(0.75) - d1.quantile(0.25)
  median = d1.median()
  mad = (d1-d1.median()).abs().median()
  sd_arrows_center = (((mean - sd/2, 70), (mean + sd/2, 70)))
  sd_arrows = FancyArrowPatch(
    *sd_arrows_center,
    arrowstyle="|-|",
    mutation_scale = 5
  )
  axes.add_patch(sd_arrows)
  axes.text(
    mean,
    71,
    horizontalalignment = "center",
    verticalalignment = "bottom",
    s = "Std. Dev."
  )
  q31_arrows_center = ((d1.quantile(0.25), 76), (d1.quantile(0.75), 76))
  q31_arrows = FancyArrowPatch(
    *q31_arrows_center,
    arrowstyle = "|-|",
    mutation_scale = 5
  )
  axes.add_patch(q31_arrows)
  axes.text(
    median,
    77,
    horizontalalignment = "center",
    verticalalignment = "bottom",
    s = "$Q_3 - Q_1$"
  )
  mad_arrows_center = ((median-mad/2, 82), (median+mad/2, 82))
  print(mad_arrows_center)
  mad_arrows = FancyArrowPatch(
    *mad_arrows_center,
    arrowstyle = "|-|",
    mutation_scale = 5
  )
  axes.add_patch(mad_arrows)
  axes.text(
    median,
    83,
    horizontalalignment = "center",
    verticalalignment = "bottom",
    s = "M.A.D."
  )


def triang_rvs(size:int):
  cdf = lambda x : math.sqrt(x)
  x = np.random.random(size)
  y = [cdf(v) for v in x]
  return y

def skewness_plot():
  data_tri = pd.Series(triang_rvs(5000))
  data_norm = pd.Series(scipy.stats.norm.rvs(size=5000))
  data_alpha = pd.Series(scipy.stats.alpha.rvs(size=5000, a=3.5))
  data_alpha = data_alpha[data_alpha < 1]
  fig, axes = plt.subplots(
    figsize = (6, 9),
    nrows = 3
  )
  axes = axes.flatten()
  axes[0].hist(
    data_tri,
    bins=25,
    label=f"Skew={data_tri.skew():0.3f}"
  )
  axes[0].set_title("Triangular Distribution")
  axes[1].hist(
    data_norm,
    bins=25,
    label=f"Skew={data_norm.skew():0.3f}"
  )
  axes[1].set_title("Normal Distribution")
  axes[2].hist(
    data_alpha,
    bins=np.linspace(0, 0.75, 25),
    label=f"Skew={data_alpha.skew():0.3f}"
  )
  axes[2].set_title("Alpha Distribution")
  axes[0].legend()
  axes[1].legend()
  axes[2].legend()
  fig.tight_layout()

def kurtosis_plot():
  data_norm = pd.Series(scipy.stats.norm.rvs(size=5000))
  data_tri = pd.Series(scipy.stats.triang.rvs(size=5000, c=0.5))
  data_uniform = pd.Series(scipy.stats.uniform.rvs(size=5000))
  fig, axes = plt.subplots(
    figsize = (6, 9),
    nrows = 3
  )
  axes = axes.flatten()
  axes[0].hist(
    data_norm,
    label = f"Kurtosis:{data_norm.kurtosis()+3:0.3f}"
  )
  axes[0].set_title("Normal Distribution")
  axes[0].legend()
  axes[1].hist(
    data_tri,
    label = f"Kurtosis:{data_tri.kurtosis()+3:0.3f}"
  )
  axes[1].set_title("Triangular Distribution")
  axes[1].legend()
  axes[2].hist(
    data_uniform,
    label = f"Kurtosis:{data_uniform.kurtosis()+3:0.3f}"
  )
  axes[2].set_ylim(0, 700)
  axes[2].set_title("Uniform Distribution")
  axes[2].legend()
  plt.tight_layout()

def kde_plot():
  data_norm = pd.Series(scipy.stats.norm.rvs(size=5000))
  kde_01 = scipy.stats.gaussian_kde(data_norm, bw_method=0.1)
  kde_1 = scipy.stats.gaussian_kde(data_norm, bw_method=1)
  kde_2 = scipy.stats.gaussian_kde(data_norm, bw_method=2)
  xs = np.linspace(data_norm.max(), data_norm.min(), 100)
  fig, axes = plt.subplots(
    figsize=(6, 9),
    nrows = 3
  )
  axes = axes.flatten()
  axes[0].hist(data_norm, density=True)
  axes[0].plot(
    xs,
    kde_01(xs),
    label = "$h=0.1$"
  )
  fig.tight_layout()
  axes[1].hist(data_norm, density=True)
  axes[1].plot(
    xs,
    kde_1(xs),
    label = "$h=1$"
  )
  fig.tight_layout()
  axes[2].hist(data_norm, density=True)
  axes[2].plot(
    xs,
    kde_2(xs),
    label = "$h=2$"
  )
  for ax in axes:
    ax.legend()
    ax.set_xlabel("Domain")
    ax.set_ylabel("Density")
  fig.tight_layout()

def boxplot_example():
  iris = datasets.load_iris(as_frame=True)
  df: pd.DataFrame = iris.frame

  fig, axes = plt.subplots(
    figsize = (8, 6),
    ncols = 2,
    width_ratios = [1, 3]
  )

  axes[0].boxplot(df.iloc[:, 1])

  axes[1].boxplot(df.iloc[:, 1])
  q3 = df.iloc[:, 1].quantile(0.75)
  q2 = df.iloc[:, 1].quantile(0.50)
  q1 = df.iloc[:, 1].quantile(0.25)
  iqr = q3 - q1
  whisker = 1.5 * iqr
  ubound = q3 + whisker
  lbound = q1 - whisker

  axes[1].annotate(
    xy = (1.08, q1),
    xytext = (1.13, q1),
    text = "$Q_1$",
    arrowprops={
      "arrowstyle" : "->"
    }
  )
  axes[1].annotate(
    xy = (1.08, q2),
    xytext = (1.13, q2),
    text = "$Q_2$",
    arrowprops={
      "arrowstyle" : "->"
    }
  )
  axes[1].annotate(
    xy = (1.08, q3),
    xytext = (1.13, q3),
    text = "$Q_3$",
    arrowprops={
      "arrowstyle" : "->"
    }
  )
  axes[1].annotate(
    xy = (1.05, lbound),
    xytext = (1.1, lbound),
    text = "$Q_1 - 1.5 \\times IQR$",
    arrowprops={
      "arrowstyle" : "->"
    }
  )
  axes[1].annotate(
    xy = (1.05, ubound),
    xytext = (1.1, ubound),
    text = "$Q_3 + 1.5 \\times IQR$",
    arrowprops={
      "arrowstyle" : "->"
    }
  )
  axes[1].scatter(
    [1],
    [df.iloc[:, 1].max()],
    marker = "o",
    ec = "red",
    s = 200,
    c = "white"
  )
  axes[1].annotate(
    xy = (1.05, df.iloc[:, 1].max()),
    xytext = (1.10, df.iloc[:, 1].max()),
    text = "outlier",
    arrowprops = {
      "arrowstyle": "->"
    }
  )
  axes[1].plot(
    [0.95, 1.05],
    [ubound, ubound],
    color = "red"
  )
  axes[1].plot(
    [0.95, 1.05],
    [lbound, lbound],
    color = "red"
  )
  points = df.iloc[:, 1].value_counts()
  points = (points.map(np.arange)).explode()
  points = 0.90 - (points / points.max()) * 0.4
  axes[1].scatter(
    points,
    points.index
  )
