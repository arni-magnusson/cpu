# Produce plots and tables for report

# Before: passmark.csv (output)
# After:  cores.png, multi.png, single.png (report)

library(TAF)

mkdir("report")

# Read data
passmark <- read.taf("output/passmark.csv")

# Effective cores
effective <- passmark[order(passmark$effcores),]
taf.png("cores")
barplot(effective$physcores, names=effective$machine, col=0, ylab="Cores")
barplot(effective$effcores, col="lightgray", add=TRUE)
legend("topleft", legend=c("Physical", "Effective"),
       fill=c("white","lightgray"), bty="n", inset=0.02, y.intersp=1.25)
title(main="Effective cores = multithread score / single-thread score")
dev.off()

# Multithread
multi <- passmark[order(passmark$multi),]
taf.png("multi")
barplot(multi$multi, names=multi$machine,
        main="Synthetic benchmark results (multithread)",
        xlab="", ylab="Score (PassMark multithread)")
dev.off()

# Single thread
single <- passmark[order(passmark$single),]
taf.png("single")
barplot(single$single, names=single$machine,
        main="Synthetic benchmark results (single thread)",
        xlab="", ylab="Score (PassMark single thread)")
dev.off()
