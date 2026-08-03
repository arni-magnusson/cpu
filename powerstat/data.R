# Prepare data, write CSV data tables

# Before: info.csv (boot/data)
#         power_*.dat (boot/data/lenovo_p15_gen_1)
# After:  info.csv,
#         p15gen1_*.csv, p15gen1.rds (data)

library(TAF)

mkdir("data")

