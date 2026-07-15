# Run analysis, write model results

# Before: p1gen8.rds (data)
# After:  p1gen8_Repairs.png, p1gen8.rds (model)

library(TAF)
source("utilities.R")

mkdir("model")

# Read data
p1gen8 <- readRDS("data/p1gen8.rds")

taf.png("model/p1gen8_Repairs")
par(mfrow=c(3, 3))

# Repair CorWatt
x <- p1gen8$full$CorWatt
p1gen8$full$CorWatt <- outliers(x, span=0.43, plot=TRUE)$repaired
x <- p1gen8$main$CorWatt
p1gen8$main$CorWatt <- outliers(x, span=0.85, plot=TRUE)$repaired
x <- p1gen8$single$CorWatt
p1gen8$single$CorWatt <- outliers(x, span=0.85, plot=TRUE)$repaired

# Repair PkgWatt
x <- p1gen8$full$PkgWatt
p1gen8$full$PkgWatt <- outliers(x, span=0.43, plot=TRUE)$repaired
x <- p1gen8$main$PkgWatt
p1gen8$main$PkgWatt <- outliers(x, span=0.85, plot=TRUE)$repaired
x <- p1gen8$single$PkgWatt
p1gen8$single$PkgWatt <- outliers(x, span=0.85, plot=TRUE)$repaired

# Repair PkgWatt
x <- p1gen8$full$SysWatt
p1gen8$full$SysWatt <- outliers(x, span=0.43, plot=TRUE)$repaired
x <- p1gen8$main$SysWatt
p1gen8$main$SysWatt <- outliers(x, span=1.0, plot=TRUE)$repaired
x <- p1gen8$single$SysWatt
p1gen8$single$SysWatt <- outliers(x, level=0.3, span=0.85,
                                  plot=TRUE)$repaired
dev.off()

# Save RDS objects
saveRDS(p1gen8, "model/p1gen8.rds")
