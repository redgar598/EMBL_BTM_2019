from sklearn.manifold import TSNE
import pandas as pd
import seaborn as sns

# load input
X = pd.read_csv(snakemake.input[0])
names = X["file"].copy()
X = X.drop(["Unnamed: 0", 'file'], axis = 1)

# run tsne
tsne = TSNE(n_components=2, random_state=0)
X_2d = tsne.fit_transform(X)

# structure output
Xm = pd.DataFrame(X_2d, columns = ["x", "y"])
Xm['file'] = names

# plot output
sns_plot = sns.pairplot(x_vars=["x"], y_vars=["y"], data=Xm, hue="file", height=5) 
sns_plot.savefig(snakemake.output[0])