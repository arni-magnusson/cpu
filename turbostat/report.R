# Produce plots and tables for report

# Before: p1gen8.rds, p15gen1.rds (model)
# After:  p1gen8CorWatt.png, p1gen8PkgWatt.png,
#         p15gen1CorWatt.png, p15gen1PkgWatt.png (report)

library(TAF)
source("utilities.R")

mkdir("report")

# Read data
p1gen8 <- readRDS("model/p1gen8.rds")
p15gen1 <- readRDS("model/p15gen1.rds")

# Plot p1gen8
taf.png("p1gen8_CorWatt")
plot_machine(p1gen8, "CorWatt")
dev.off()
taf.png("p1gen8_PkgWatt")
plot_machine(p1gen8, "PkgWatt")
dev.off()

# Plot p15gen1
taf.png("p15gen1_CorWatt")
plot_machine(p15gen1, "CorWatt")
dev.off()
taf.png("p15gen1_PkgWatt")
plot_machine(p15gen1, "PkgWatt")
dev.off()
