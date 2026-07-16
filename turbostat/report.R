# Produce plots and tables for report

# Before: m4700.rds, p1gen8.rds, p15gen1.rds, p3560.rds (model)
# After:  m4700_Temp.png, m4700_Watt.png,
#         p1gen8_Temp.png, p1gen8_Watt.png,
#         p15gen1_Temp.png, p15gen1_Watt.png,
#         p3560_Temp.png, p3560_Watt.png (report)

library(TAF)
source("utilities.R")

mkdir("report")

# Read data
m4700 <- readRDS("model/m4700.rds")
p1gen8 <- readRDS("model/p1gen8.rds")
p15gen1 <- readRDS("model/p15gen1.rds")
p3560 <- readRDS("model/p3560.rds")

# Plot m4700
taf.png("m4700_Temp")
plot_machine(m4700, "Temp")
dev.off()
taf.png("m4700_Watt")
plot_machine(m4700, "Watt")
dev.off()

# Plot p1gen8
taf.png("p1gen8_Temp")
plot_machine(p1gen8, "Temp")
dev.off()
taf.png("p1gen8_Watt")
plot_machine(p1gen8, "Watt")
dev.off()

# Plot p15gen1
taf.png("p15gen1_Temp")
plot_machine(p15gen1, "Temp")
dev.off()
taf.png("p15gen1_Watt")
plot_machine(p15gen1, "Watt")
dev.off()

# Plot p3560
taf.png("p3560_Temp")
plot_machine(p3560, "Temp")
dev.off()
taf.png("p3560_Watt")
plot_machine(p3560, "Watt")
dev.off()
