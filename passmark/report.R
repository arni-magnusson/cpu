# Produce plots and tables for report

# Before: passmark.csv (output)
# After:  cores.png, memory_benchmark.png, memory_detail.png, multi.png,
#         single.png (report)

library(TAF)

mkdir("report")

# Read data
info <- read.taf("data/info.csv")
memory.details <- read.taf("data/passmark.csv")
passmark <- read.taf("output/passmark.csv")

# Effective cores
effective <- passmark[order(passmark$effcores),]
taf.png("cores")
barplot(effective$physcores, names=effective$machine, col=0,
        ylab="Number of cores")
barplot(effective$effcores, col="lightgray", add=TRUE)
legend("topleft", legend=c("Physical", "Effective"),
       fill=c("white","lightgray"), bty="n", inset=0.02, y.intersp=1.25)
title(main="Effective cores = multithread score / single-thread score")
dev.off()

# Memory
memory <- merge(memory.details, info[c("machine", "module")])
memory <- memory[order(memory$memory),]
memory <- memory[c("machine", "memory", "database", "readcache", "read",
                   "write", "available", "latency", "threaded", "module")]
labels <- paste0(memory$machine, "\n(", memory$module, ")")
taf.png("memory_benchmark")
barplot(memory$memory, names=labels, main="Memory benchmark", xlab="",
        ylab="Score", yaxt="n", mgp=c(3,1.5,0))
axis(2)
dev.off()
taf.png("memory_details", 1600, 2400)
par(mfrow=c(3,1))
barplot(memory$read, names=labels, main="Memory (read)", xlab="", col=7,
        ylab="Score", yaxt="n", mgp=c(3,1.5,0))
axis(2)
barplot(memory$write, names=labels, main="Memory (write)", xlab="", col=2,
        ylab="Score", yaxt="n", mgp=c(3,1.5,0))
axis(2)
barplot(memory$latency, names=labels, main="Memory (latency)", xlab="", col=3,
        ylab="Score", yaxt="n", mgp=c(3,1.5,0))
axis(2)
dev.off()

# Multithread
multi <- passmark[order(passmark$multi),]
taf.png("multi")
barplot(multi$multi, names=multi$machine,
        main="Multithread benchmark", xlab="",
        ylab="Score (PassMark multithread)")
dev.off()

# Single thread
single <- passmark[order(passmark$single),]
taf.png("single")
barplot(single$single, names=single$machine,
        main="Single-thread benchmark", xlab="",
        ylab="Score (PassMark single thread)")
dev.off()
