## ---- myrcode0

set.seed(123)
par(mfrow=c(2,2))
x <- seq(-10, 10, length=100)
y <- .5 * (dnorm(x) + dnorm(x, mean=1))
y0 <- .5 * (dnorm(x) + dnorm(x, mean=2))
y1 <- .5 * (dnorm(x) + dnorm(x, mean=3))
y2 <- .5 * (dnorm(x) + dnorm(x, mean=5))
plot(x, y, type="l", main=".5 * (N(0,1)+N(1,1))")
plot(x, y0, type="l", main=".5 * (N(0,1)+N(2,1))")
plot(x, y1, type="l", main=".5 * (N(0,1)+N(3,1))")
plot(x, y2, type="l", main=".5 * (N(0,1)+N(5,1))")
