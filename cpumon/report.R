# Produce plots and tables for report

# Before: m4700.rds, p1gen8.rds, p15gen1.rds, p3560.rds (data)
# After:  each.pdf (report)

library(TAF)
source("utilities.R")

mkdir("report")

# Read data
m4700 <- readRDS("model/m4700.rds")
p1gen8 <- readRDS("model/p1gen8.rds")
p15gen1 <- readRDS("model/p15gen1.rds")
p3560 <- readRDS("model/p3560.rds")

# Plot each machine
pdf("report/each.pdf", width=12, height=8)
par(mfrow=c(3,4))
plot_machine(m4700, "Freq")
plot_machine(p15gen1, "Freq")
plot_machine(p3560, "Freq")
plot_machine(p1gen8, "Freq")
plot_machine(m4700, "Fan")
plot_machine(p15gen1, "Fan")
plot_machine(p3560, "Fan")
plot_machine(p1gen8, "Fan")
plot_machine(m4700, "Temp")
plot_machine(p15gen1, "Temp")
plot_machine(p3560, "Temp")
plot_machine(p1gen8, "Temp")
dev.off()
