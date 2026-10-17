# Prepare data, write CSV data tables
#
# Before: my_laptops.dat, catage.dat, and Passmark .dat files (boot/data)
# After:  passmark_online.csv, passmark_local.csv, catage.csv (data)

dir.create("data", showWarnings=FALSE, recursive=TRUE)

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

# Read the CPU single-thread score and processor label from each local report.
passmark_files <- c(
  m4700="boot/data/passmark/data/dell_precision_m4700.dat",
  p15gen1="boot/data/passmark/data/lenovo_p15_gen1.dat",
  p3560="boot/data/passmark/data/dell_precision_3560.dat",
  p1gen8="boot/data/passmark/data/lenovo_p1_gen8.dat")

read_passmark <- function(machine, file) {
  lines <- readLines(file, warn=FALSE)
  processor_line <- grep("\\(x86_64\\)", lines, value=TRUE)
  score_line <- grep("CPU Single Threaded", lines, value=TRUE)
  if (length(processor_line) != 1L || length(score_line) != 1L)
    stop("Could not identify processor and single-thread score in ", file)

  processor <- trimws(sub("\\s*\\(x86_64\\).*", "", processor_line))
  score <- as.numeric(sub(".*CPU Single Threaded[[:space:]]+([0-9.]+).*",
                          "\\1", score_line))
  if (is.na(score))
    stop("Could not parse CPU Single Threaded score in ", file)

  data.frame(machine=machine, processor_local=processor,
             passmark_single=score, stringsAsFactors=FALSE)
}

passmark_local <- do.call(rbind, Map(read_passmark, names(passmark_files),
                                     unname(passmark_files)))
row.names(passmark_local) <- NULL

# Read catage run times.
catage <- read.table("boot/data/catage.dat", header=TRUE,
                     stringsAsFactors=FALSE)

write.csv(passmark_online, "data/passmark_online.csv", row.names=FALSE)
write.csv(passmark_local, "data/passmark_local.csv", row.names=FALSE)
write.csv(catage, "data/catage.csv", row.names=FALSE)

