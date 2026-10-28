# Produce plots and tables for report

# Before: specs.csv (ougtput)
# After:

library(TAF)

mkdir("report")

# Read data
specs <- read.taf("output/specs.csv", colClasses=c(Date="Date"))

# Relationships
plot(Speed~sqrt(nm), specs, log="y", pch=21, bg=bg)
plot(Speed/W~Date, specs, log="y", pch=21, bg=bg)
