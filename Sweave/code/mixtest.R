# https://cran.r-project.org/web/packages/mixtools/vignettes/mixtools.pdf

library(mixtools)
data(faithful)
attach(faithful)

head(faithful)

hist(waiting, main="Time between Old Faithful eruptions",
     xlab="Minutes", ylab="", cex.main=1.5, cex.lab=1.5, cex.axis=1.4)

wait1 <- normalmixEM(waiting, lambda=.5, mu=c(55, 80), sigma=5)
# these have customised starting values

# code above will fit 2 component mixture since mu is of length 2.
plot(wait1, density=TRUE, cex.axis=1.4, cex.lab=1.4, cex.main=1.5,
     main2= "Time between Old Faithful eruptions", xlab2="Minutes")

# normalmixEM function returns an object of class "mixEM". plot method produces
# two plots: sequence $t \mapsto L_{\boldx}(\boldtheta^{(t)}). see page 6

wait1[c("lambda", "mu", "sigma")]

summary(wait1)
