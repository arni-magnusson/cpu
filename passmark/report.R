# Produce plots and tables for report

# Before: passmark.csv (output)
# After:  passmark.png (report)

library(TAF)

mkdir("report")

# Read data
passmark <- read.taf("output/passmark.csv")

# Reorder machine
passmark$machine <- reorder(passmark$machine, passmark$single, median)

# Plot benchmark results
taf.png("benchmark.png")
barplot(single~machine, passmark, main="Synthetic benchmark results", xlab="",
        ylab="Score (PassMark single thread)")
dev.off()
