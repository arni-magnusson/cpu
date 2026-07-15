# Extract results of interest, write CSV output tables

# Before: p1gen8.rds, p15gen1.rds (model)
# After:  p1gen8*.csv, p15gen1*.csv (output)

library(TAF)

mkdir("output")

# Read data
p1gen8 <- readRDS("model/p1gen8.rds")
p15gen1 <- readRDS("model/p15gen1.rds")

# Write tables
write.taf(p1gen8$idle, "output/p1gen8_idle.csv")
write.taf(p1gen8$single, "output/p1gen8_single.csv")
write.taf(p1gen8$main, "output/p1gen8_main.csv")
write.taf(p1gen8$full, "output/p1gen8_full.csv")
write.taf(p15gen1$idle, "output/p15gen1_idle.csv")
write.taf(p15gen1$single, "output/p15gen1_single.csv")
write.taf(p15gen1$main, "output/p15gen1_main.csv")
write.taf(p15gen1$full, "output/p15gen1_full.csv")
