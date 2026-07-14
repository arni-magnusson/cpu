# Produce plots and tables for report

# Before: p1gen8.rds (model)
# After:  p1gen8CorWatt.png, p1gen8PkgWatt.png, p1gen8SysWatt.png (report)

library(TAF)
source("utilities.R")

mkdir("report")

# Read data
p1gen8 <- readRDS("model/p1gen8.rds")

# Plot p1gen8
taf.png("p1gen8_CorWatt")
plot_machine(p1gen8, "CorWatt")
dev.off()
taf.png("p1gen8_PkgWatt")
plot_machine(p1gen8, "PkgWatt")
dev.off()
taf.png("p1gen8_SysWatt")
plot_machine(p1gen8, "SysWatt")
dev.off()
