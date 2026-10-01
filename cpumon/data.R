# Prepare data, write CSV data tables

# Before: info.csv (boot/data),
#         cpumon_*.dat (boot/data/dell_precision_m4700)
#         cpumon_*.dat (boot/data/lenovo_p1_gen_8)
#         cpumon_*.dat (boot/data/lenovo_p15_gen_1)
#         cpumon_*.dat (boot/data/dell_precision_p3560)
# After:  info.csv,
#         m4700_*.csv, m4700.rds,
#         p1gen8_*.csv, p1gen8.rds,
#         p15gen1_*.csv, p15gen1.rds,
#         p3560_*.csv, p3560.rds (data)

library(TAF)

mkdir("data")

# Read data
info <- read.csv("boot/data/info.csv")
m4700 <- list()
m4700$idle <- read.taf("boot/data/dell_precision_m4700/cpumon_0.csv")
m4700$single <- read.taf("boot/data/dell_precision_m4700/cpumon_1.csv")
m4700$main <- read.taf("boot/data/dell_precision_m4700/cpumon_4.csv")
m4700$full <- read.taf("boot/data/dell_precision_m4700/cpumon_8.csv")
p15gen1 <- list()
p15gen1$idle <- read.taf("boot/data/lenovo_p15_gen_1/cpumon_0.csv")
p15gen1$single <- read.taf("boot/data/lenovo_p15_gen_1/cpumon_1.csv")
p15gen1$main <- read.taf("boot/data/lenovo_p15_gen_1/cpumon_8.csv")
p15gen1$full <- read.taf("boot/data/lenovo_p15_gen_1/cpumon_16.csv")
p3560 <- list()
p3560$idle <- read.taf("boot/data/dell_precision_3560/cpumon_0.csv")
p3560$single <- read.taf("boot/data/dell_precision_3560/cpumon_1.csv")
p3560$main <- read.taf("boot/data/dell_precision_3560/cpumon_4.csv")
p3560$full <- read.taf("boot/data/dell_precision_3560/cpumon_8.csv")

# Write tables
write.taf(info, dir="data")
write.taf(m4700$idle, "data/m4700_idle.csv")
write.taf(m4700$single, "data/m4700_single.csv")
write.taf(m4700$main, "data/m4700_main.csv")
write.taf(m4700$full, "data/m4700_full.csv")
write.taf(p15gen1$idle, "data/p15gen1_idle.csv")
write.taf(p15gen1$single, "data/p15gen1_single.csv")
write.taf(p15gen1$main, "data/p15gen1_main.csv")
write.taf(p15gen1$full, "data/p15gen1_full.csv")
write.taf(p3560$idle, "data/p3560_idle.csv")
write.taf(p3560$single, "data/p3560_single.csv")
write.taf(p3560$main, "data/p3560_main.csv")
write.taf(p3560$full, "data/p3560_full.csv")

# Save RDS objects
saveRDS(m4700, "data/m4700.rds")
saveRDS(p15gen1, "data/p15gen1.rds")
saveRDS(p3560, "data/p3560.rds")
