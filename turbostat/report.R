# Produce plots and tables for report

# Before: m4700.rds, p1gen8.rds, p15gen1.rds, p3560.rds (model)
# After:  m4700_PkgTmp.png, m4700_PkgWatt.png,
#         p1gen8_PkgTmp.png, p1gen8_PkgWatt.png,
#         p15gen1_PkgTmp.png, p15gen1_PkgWatt.png,
#         p3560_PkgTmp.png, p3560_PkgWatt.png (report)

library(TAF)
source("utilities.R")

mkdir("report")

# Read data
m4700 <- readRDS("model/m4700.rds")
p1gen8 <- readRDS("model/p1gen8.rds")
p15gen1 <- readRDS("model/p15gen1.rds")
p3560 <- readRDS("model/p3560.rds")

# Plot m4700
taf.png("m4700_PkgTmp")
plot_machine(m4700, "PkgTmp")
dev.off()
taf.png("m4700_PkgWatt")
plot_machine(m4700, "PkgWatt")
dev.off()

# Plot p1gen8
taf.png("p1gen8_PkgTmp")
plot_machine(p1gen8, "PkgTmp")
dev.off()
taf.png("p1gen8_PkgWatt")
plot_machine(p1gen8, "PkgWatt")
dev.off()

# Plot p15gen1
taf.png("p15gen1_PkgTmp")
plot_machine(p15gen1, "PkgTmp")
dev.off()
taf.png("p15gen1_PkgWatt")
plot_machine(p15gen1, "PkgWatt")
dev.off()

# Plot p3560
taf.png("p3560_PkgTmp")
plot_machine(p3560, "PkgTmp")
dev.off()
taf.png("p3560_PkgWatt")
plot_machine(p3560, "PkgWatt")
dev.off()
