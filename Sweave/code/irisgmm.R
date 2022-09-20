## ---- myrcode3
#  https://www.stats.ox.ac.uk/~sejdinov/teaching/atsml19/Mixtures.html
# 
data(iris)
par(mfrow=c(1,2))
set.seed(1234)
library(factoextra)
library(mixtools)
iris.nolabel = iris[,1:2]
# pairs(iris)
k1 <- kmeans(x=iris.nolabel, centers=3)
fviz_cluster(k1, data=iris.nolabel)

# explain what fviz_cluster does.

irisEM <- mvnormalmixEM(iris.nolabel)
# irisEM
summary(irisEM)
plot(irisEM, density=TRUE)

