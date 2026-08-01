# Prepare data, write CSV data tables

# Before: dell_precision_m4700.dat, lenovo_p1_gen_8.dat,
#         lenovo_p15_gen_1.dat, lenovo_p1_gen8.dat (boot/data)
# After:  m4700.csv, p15gen1.csv, p1gen8.csv, passmark.csv (data)

library(TAF)
source("utilities.R")

mkdir("data")

# Read data
m4700 <- readPass("boot/data/dell_precision_m4700.dat")
p1gen8 <- readPass("boot/data/lenovo_p1_gen_8.dat")
p15gen1 <- readPass("boot/data/lenovo_p15_gen_1.dat")

# Combine
passmark <- rbind(
  m4700 <- data.frame(machine="m4700", t(taf2xtab(m4700))),
  p15gen1 <- data.frame(machine="p15gen1", t(taf2xtab(p15gen1))),
  p1gen8 <- data.frame(machine="p1gen8", t(taf2xtab(p1gen8))))
passmark <- type.convert(passmark, as.is=TRUE)
row.names(passmark) <- NULL

# Write table
write.taf(m4700, dir="data")
write.taf(p1gen8, dir="data")
write.taf(p15gen1, dir="data")
write.taf(passmark, dir="data")
