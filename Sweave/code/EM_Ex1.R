## ---- myrcode1

set.seed(123)
X1 = rnorm(3000, 20, 5)
X2 = rnorm(7000, 40, 5)
x = c(X1, X2)
hist(x, nclass=50, main="Histogram of sum of X1 and X2", xlab="X1 + X2")


# Using mixtools
library(mixtools)
par(mfrow=c(1,2))
EMmixtool <- normalmixEM(x)
plot(EMmixtool, density=TRUE)
EMmixtool[c("lambda", "mu", "sigma")]

# Calculating by hand
mem <- kmeans(x,2)$cluster
mu1 <- mean(x[mem==1])
mu2 <- mean(x[mem==2])
sigma1 <- sd(x[mem==1])
sigma2 <- sd(x[mem==2])
pi1 <- sum(mem==1)/length(mem)
pi2 <- sum(mem==2)/length(mem)

# modified sum only considers finite values
sum.finite <- function(x) {
  sum(x[is.finite(x)])
}

Q <- 0
# starting value of expected value of the log likelihood
Q[2] <- sum.finite(log(pi1)+log(dnorm(x, mu1, sigma1)))
  + sum.finite(log(pi2)+log(dnorm(x, mu2, sigma2)))

k <- 2

while (abs(Q[k]-Q[k-1])>=1e-6) {
  # E step
  comp1 <- pi1 * dnorm(x, mu1, sigma1)
  comp2 <- pi2 * dnorm(x, mu2, sigma2)
  comp.sum <- comp1 + comp2
  
  p1 <- comp1/comp.sum
  p2 <- comp2/comp.sum
  
  # M step
  pi1 <- sum.finite(p1) / length(x)
  pi2 <- sum.finite(p2) / length(x)
  
  mu1 <- sum.finite(p1 * x) / sum.finite(p1)
  mu2 <- sum.finite(p2 * x) / sum.finite(p2)
  
  sigma1 <- sqrt(sum.finite(p1 * (x-mu1)^2) / sum.finite(p1))
  sigma2 <- sqrt(sum.finite(p2 * (x-mu2)^2) / sum.finite(p2))
  
  p1 <- pi1 
  p2 <- pi2
  
  k <- k + 1
  Q[k] <- sum(log(comp.sum))
}
