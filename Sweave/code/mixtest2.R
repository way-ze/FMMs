library(mixtools)
x.1 <- rmvnorm(40, c(0, 0))
x.2 <- rmvnorm(60, c(3, 4))
X.1 <- rbind(x.1, x.2)

out.1 <- mvnormalmixEM(X.1, arbvar = FALSE, verb = TRUE,
                       epsilon = 1e-03)
plot(out.1, density = TRUE, alpha = c(0.01, 0.05, 0.10), 
     marginal = TRUE)

