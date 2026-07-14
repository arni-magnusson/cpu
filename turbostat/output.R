# Extract results of interest, write CSV output tables

# Before: p1gen8.rds (model)
# After:  p1gen8*.csv (output)

library(TAF)

mkdir("output")

# Read data
p1gen8 <- readRDS("model/p1gen8.rds")

# Write tables
write.taf(p1gen8$idle, "output/p1gen8_idle.csv")
write.taf(p1gen8$single, "output/p1gen8_single.csv")
write.taf(p1gen8$main, "output/p1gen8_main.csv")
write.taf(p1gen8$full, "output/p1gen8_full.csv")
