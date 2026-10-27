# Run analysis, write model results

# Before: companies.csv, i7_high.csv, i7_low.csv, i7_medium.csv, r7_high.csv,
#         r7_low.csv (data)
# After:  companies_fit.csv, companies_lag.csv, fm.rds, i7_high.csv, i7_low.csv,
#         i7_medium.csv, r7_high.csv, r7_low.csv (model)

library(TAF)

mkdir("model")

# Read tables
companies <- read.taf("data/companies.csv", colClasses=c(Date="Date"))
i7.high <- read.taf("data/i7_high.csv")
i7.medium <- read.taf("data/i7_medium.csv")
i7.low <- read.taf("data/i7_low.csv")
r7.high <- read.taf("data/r7_high.csv")
r7.low <- read.taf("data/r7_low.csv")

# Calculate relative speed improvement
improve <- function(x) c(NA, x$Speed[-1] / x$Speed[-nrow(x)]) - 1
i7.high$Improve <- improve(i7.high)
i7.medium$Improve <- improve(i7.medium)
i7.low$Improve <- improve(i7.low)
r7.high$Improve <- improve(r7.high)
r7.low$Improve <- improve(r7.low)

# Fit ancova model
start <- as.Date("2018-07-01")
fm <- lm(log(Speed)~-1+Company+Date, companies, subset=Date>start)
x0 <- -coef(fm)[1:3] / coef(fm)[4]
names(x0) <- sub("Company", "", names(x0))
companies.lag <- data.frame(Company=names(x0), Intercept=as.Date(x0),
                                  Lag=(x0-min(x0))/365.25)
companies.fit <- expand.grid(Company=c("AMD", "Apple", "Intel"),
                             Date=c(start, max(companies$Date)))
companies.fit$Speed <- exp(predict(fm, companies.fit))

# Save fitted model
saveRDS(fm, "model/fm.rds")

# Save tables
write.taf(companies.fit, dir="model")
write.taf(companies.lag, dir="model")
write.taf(i7.high, dir="model")
write.taf(i7.medium, dir="model")
write.taf(i7.low, dir="model")
write.taf(r7.high, dir="model")
write.taf(r7.low, dir="model")
