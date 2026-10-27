# Plots relative improvement for each release

# Before: i7_high.csv, i7_low.csv, i7_medium.csv, r7_high.csv,
#         r7_low.csv (output)
# After:  improve_amd_high.png, improve_amd_low.png, improve_intel_high.png,
#         improve_intel_low.png, improve_intel_medium.png (report)

library(TAF)
source("utilities.R")  # implot

mkdir("report")

# Read tables
i7.high <- read.taf("output/i7_high.csv", colClasses=c(Date="Date"))
i7.medium <- read.taf("output/i7_medium.csv", colClasses=c(Date="Date"))
i7.low <- read.taf("output/i7_low.csv", colClasses=c(Date="Date"))
r7.high <- read.taf("output/r7_high.csv", colClasses=c(Date="Date"))
r7.low <- read.taf("output/r7_low.csv", colClasses=c(Date="Date"))

# Plot improvement
taf.png("improve_amd_high")
implot(r7.high[-1,])
dev.off()

taf.png("improve_amd_low")
implot(r7.low)
dev.off()

taf.png("improve_intel_high")
implot(i7.high[-1,])
dev.off()

taf.png("improve_intel_low")
implot(i7.low[-1,])
dev.off()

taf.png("improve_intel_medium")
implot(i7.medium)
dev.off()
