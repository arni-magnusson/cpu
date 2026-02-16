# Plots relative improvement for each release

# Before: i7_high.csv, i7_low.csv, i7_medium.csv, r7_high.csv,
#         r7_low.csv (output)
# After:  improve_amd_high.png, improve_amd_low.png, improve_intel_high.png,
#         improve_intel_low.png, improve_intel_medium.png (report)

library(TAF)

mkdir("report")

# Read tables
i7_high <- read.taf("output/i7_high.csv", colClasses=c(Date="Date"))
i7_medium <- read.taf("output/i7_medium.csv", colClasses=c(Date="Date"))
i7_low <- read.taf("output/i7_low.csv", colClasses=c(Date="Date"))
r7_high <- read.taf("output/r7_high.csv", colClasses=c(Date="Date"))
r7_low <- read.taf("output/r7_low.csv", colClasses=c(Date="Date"))

# Plot function
implot <- function(x)
{
  par(plt=c(0.2, 0.9, 0.2, 0.9))
  labels <- paste0(x$Model[-1], " (", format(x$Date[-1], "%Y"), ")")
  barplot(100*x$Improve[-1], names=labels, horiz=TRUE, las=1,
          xlim=c(0,52), xlab="Relative speed improvement (%)")
}

# Plot improvement
taf.png("improve_amd_high")
implot(r7_high)
dev.off()

taf.png("improve_amd_low")
implot(r7_low)
dev.off()

taf.png("improve_intel_high")
implot(i7_high)
dev.off()

taf.png("improve_intel_low")
implot(i7_low)
dev.off()

taf.png("improve_intel_medium")
implot(i7_medium)
dev.off()
