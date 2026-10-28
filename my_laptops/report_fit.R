# Produce plots and tables for report

# Before: specs.csv (ougtput)
# After:

library(TAF)

mkdir("report")

# Read data
specs <- read.taf("output/specs.csv", colClasses=c(Date="Date"))
speed.fit <- read.taf("output/speed_fit.csv", colClasses=c(Date="Date"))

# Plot data
plot(Speed~Date, specs, log="y", pch=21, bg=bg)

# Plot fit
lines(Speed~Date, speed.fit)
