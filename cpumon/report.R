# Produce plots and tables for report

# Before: info.csv (data)
#         cores.rds, m4700.rds, p1gen8.rds, p15gen1.rds, p3560.rds (model)
#         summary.csv (output)
# After:  comparison.pdf, each.pdf (report)

library(TAF)
source("utilities.R")

mkdir("report")

# Read data
info <- read.taf("data/info.csv")
cores <- readRDS("model/cores.rds")
m4700 <- readRDS("model/m4700.rds")
p1gen8 <- readRDS("model/p1gen8.rds")
p15gen1 <- readRDS("model/p15gen1.rds")
p3560 <- readRDS("model/p3560.rds")
summary <- read.taf("output/summary.csv")

# Prepare plot elements
machines <- list(m4700=m4700, p15gen1=p15gen1, p3560=p3560, p1gen8=p1gen8)

# Plot each machine
pdf("report/each.pdf", width=12, height=8)
par(mfrow=c(3,4))
plot_machine(m4700, "Freq")
plot_machine(p15gen1, "Freq")
plot_machine(p3560, "Freq")
plot_machine(p1gen8, "Freq")
plot_machine(m4700, "Temp")
plot_machine(p15gen1, "Temp")
plot_machine(p3560, "Temp")
plot_machine(p1gen8, "Temp")
plot_machine(m4700, "Fan")
plot_machine(p15gen1, "Fan")
plot_machine(p3560, "Fan")
plot_machine(p1gen8, "Fan")
dev.off()

# Plot machine comparison
pdf("report/comparison.pdf", width=12, height=8)
par(mfrow=c(3,4))
plot_comparison(machines, "idle", "Freq")
plot_comparison(machines, "single", "Freq")
plot_comparison(machines, "main", "Freq")
plot_comparison(machines, "full", "Freq")
plot_comparison(machines, "idle", "Temp")
plot_comparison(machines, "single", "Temp")
plot_comparison(machines, "main", "Temp")
plot_comparison(machines, "full", "Temp")
plot_comparison(machines, "idle", "Fan")
plot_comparison(machines, "single", "Fan")
plot_comparison(machines, "main", "Fan")
plot_comparison(machines, "full", "Fan")
dev.off()

pdf("report/cores.pdf", width=8, height=8)
par(mfrow=c(2,2))
plot_cores(cores$m4700)
plot_cores(cores$p1gen8)
plot_cores(cores$p15gen1)
plot_cores(cores$p3560)
dev.off()

# Round and divide values
summary <- rnd(summary, grep("idle|single|main|full", names(summary)), -2)
summary <- div(summary, grep("idle|single|main|full", names(summary)))

# Compact description
desc <- data.frame(machine=summary$machine,
                   rest=paste0(format(summary$idle1), "-",
                               format(summary$idle2)),
                   work=paste0(format(summary$main2), "-",
                               format(summary$single2)),
                   spec=paste0(format(info$freq), "-",
                               format(info$turbo)))

# Write tables
write.taf(desc, dir="report")
write.taf(summary, dir="report")
