# Produce plots and tables for report

# Before: single.csv (output)
# After:  single.png (report)

library(TAF)

mkdir("report")

# Read data
single <- read.taf("output/single.csv")

# Reorder machine
single$machine <- reorder(single$machine, single$score, median)

# Plot benchmark results
taf.png("single.png")
barplot(score~machine, single, main="Synthetic benchmark results", xlab="",
        ylab="Score (PassMark single thread)")
dev.off()
