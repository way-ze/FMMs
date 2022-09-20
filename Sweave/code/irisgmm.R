# Import packages and general graph setup
suppressPackageStartupMessages(library(factoextra))
suppressPackageStartupMessages(library(mixtools))
data(iris)
par(mfrow=c(1,2))
set.seed(1234)

# Extract only petal length and width
iris.nolabel = iris[,3:4]
k1 <- kmeans(x=iris.nolabel, centers=3)
fviz_cluster(k1, data=iris.nolabel)

# Plot naive model without prior initialisation
irisEM <- mvnormalmixEM(iris.nolabel, k=3)
suppressWarnings(summary(irisEM))
par(mfrow=c(1,2))
plot(irisEM, density=TRUE)

# Set up Kmeans, calculate new means and covariance matrices
mem <- k1$cluster

pi1iris <- k1$size[1]/length(mem)
pi2iris <- k1$size[2]/length(mem)
pi3iris <- k1$size[3]/length(mem)

mu1iris <- k1$centers[1,]
mu2iris <- k1$centers[2,]
mu3iris <- k1$centers[3,]

sigma1iris <- diag(c(sd(iris.nolabel[mem==1,1]), sd(iris.nolabel[mem==1,2])))
sigma2iris <- diag(c(sd(iris.nolabel[mem==2,1]), sd(iris.nolabel[mem==2,2])))
sigma3iris <- diag(c(sd(iris.nolabel[mem==3,1]), sd(iris.nolabel[mem==3,2])))


# Run mvnormalmixEM with new init values
irisEM2 <- mvnormalmixEM(iris.nolabel, lambda=c(pi1iris, pi2iris, pi3iris),
                         mu=list(mu1iris, mu2iris, mu3iris),
                         sigma=list(sigma1iris, sigma2iris, sigma3iris), k=3)
par(mfrow=c(1,2))
plot(irisEM2, density=TRUE)

# Print Coefficients
irisEM2$lambda
irisEM2$mu
irisEM2$sigma

