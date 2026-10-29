# Produce plots and tables for report

# Before: passmark.csv (output)
# After:  single.png (report)

library(TAF)

mkdir("report")

# Read data
passmark <- read.taf("output/passmark.csv")

# Reorder machine

# Single thread
single <- passmark[order(passmark$single), c("machine", "single")]
taf.png("single.png")
barplot(single$single, names=single$machine,
        main="Synthetic benchmark results (single thread)",
        xlab="", ylab="Score (PassMark single thread)")
dev.off()
