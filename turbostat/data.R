# Prepare data, write CSV data tables

# Before: turbo_*.dat (boot/data/lenovo_p1_gen_8),
#         turbo_*.dat (boot/data/lenovo_p15_gen_1)
# After: p1gen8_*.csv, p1gen8.rds, p15gen1_*.csv, p15gen1.rds (data)

library(TAF)
source("utilities.R")

mkdir("data")

# Read data
p1gen8 <- list()
p1gen8$idle <- read_turbostat("boot/data/lenovo_p1_gen_8/turbo_0.dat")
p1gen8$single <- read_turbostat("boot/data/lenovo_p1_gen_8/turbo_1.dat")
p1gen8$main <- read_turbostat("boot/data/lenovo_p1_gen_8/turbo_6.dat")
p1gen8$full <- read_turbostat("boot/data/lenovo_p1_gen_8/turbo_16.dat")
p15gen1 <- list()
p15gen1$idle <- read_turbostat("boot/data/lenovo_p15_gen_1/turbo_0.dat")
p15gen1$single <- read_turbostat("boot/data/lenovo_p15_gen_1/turbo_1.dat")
p15gen1$main <- read_turbostat("boot/data/lenovo_p15_gen_1/turbo_8.dat")
p15gen1$full <- read_turbostat("boot/data/lenovo_p15_gen_1/turbo_16.dat")

# Write tables
write.taf(p1gen8$idle, "data/p1gen8_idle.csv")
write.taf(p1gen8$single, "data/p1gen8_single.csv")
write.taf(p1gen8$main, "data/p1gen8_main.csv")
write.taf(p1gen8$full, "data/p1gen8_full.csv")
write.taf(p15gen1$idle, "data/p15gen1_idle.csv")
write.taf(p15gen1$single, "data/p15gen1_single.csv")
write.taf(p15gen1$main, "data/p15gen1_main.csv")
write.taf(p15gen1$full, "data/p15gen1_full.csv")

# Save RDS objects
saveRDS(p1gen8, "data/p1gen8.rds")
saveRDS(p15gen1, "data/p15gen1.rds")
