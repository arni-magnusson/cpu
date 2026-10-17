# Prepare data, write CSV data tables
#
# Before: my_laptops.dat, catage.dat, and Passmark .dat files (boot/data)
# After:  passmark_online.csv, passmark_local.csv, catage.csv (data)

library(TAF)
mkdir("data")
source("boot/software/utilities.R")

# Read online PassMark single-thread scores.
online <- read.table("boot/data/passmark_online/my_laptops.dat",
                     header=TRUE, check.names=FALSE, stringsAsFactors=FALSE)

laptop_machine <- c(
  "Dell-Precision-M4700"="m4700",
  "Lenovo-P15-Gen1"="p15gen1",
  "Dell-Precision-3560"="p3560",
  "Lenovo-P1-Gen8"="p1gen8")

online$machine <- unname(laptop_machine[online$Laptop])
if (anyNA(online$machine))
  stop("An online PassMark laptop name has no machine mapping")

passmark_online <- data.frame(
  machine=online$machine,
  processor_online=online$Model,
  online_single=online$Single,
  stringsAsFactors=FALSE)

# Read local PassMark results and keep the single-thread scores.
passmark_files <- c(
  m4700="boot/data/passmark/data/dell_precision_m4700.dat",
  p15gen1="boot/data/passmark/data/lenovo_p15_gen1.dat",
  p3560="boot/data/passmark/data/dell_precision_3560.dat",
  p1gen8="boot/data/passmark/data/lenovo_p1_gen8.dat")

passmark_results <- lapply(passmark_files, readPass)
passmark_local <- do.call(rbind, passmark_results)
passmark_local <- passmark_local[passmark_local$Variable == "single", , drop=FALSE]
passmark_local$machine <- names(passmark_files)
passmark_local$passmark_single <- as.numeric(passmark_local$Value)
passmark_local <- passmark_local[c("machine", "passmark_single")]
row.names(passmark_local) <- NULL

# Read catage run times.
catage <- read.table("boot/data/catage.dat", header=TRUE,
                     stringsAsFactors=FALSE)

write.taf(passmark_online, dir="data")
write.taf(passmark_local, dir="data")
write.taf(catage, dir="data")

