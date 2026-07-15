# Run analysis, write model results

# Before: p1gen8.rds, p15gen1.rds (data)
# After:  p1gen8_Repairs.png, p1gen8.rds,
#         p15gen1_Repairs.png, p15gen1.rds (model)

library(TAF)
source("utilities.R")

mkdir("model")

# Read data
p1gen8 <- readRDS("data/p1gen8.rds")
p15gen1 <- readRDS("data/p15gen1.rds")

taf.png("model/p1gen8_Repairs")
par(mfrow=c(2, 3))
# Repair p1gen8 (CorWatt)
x <- p1gen8$full$CorWatt
p1gen8$full$CorWatt <- outliers(x, span=0.43, plot=TRUE)$repaired
x <- p1gen8$main$CorWatt
p1gen8$main$CorWatt <- outliers(x, span=0.85, plot=TRUE)$repaired
x <- p1gen8$single$CorWatt
p1gen8$single$CorWatt <- outliers(x, span=0.85, plot=TRUE)$repaired
# Repair p1gen8 (PkgWatt)
x <- p1gen8$full$PkgWatt
p1gen8$full$PkgWatt <- outliers(x, span=0.43, plot=TRUE)$repaired
x <- p1gen8$main$PkgWatt
p1gen8$main$PkgWatt <- outliers(x, span=0.85, plot=TRUE)$repaired
x <- p1gen8$single$PkgWatt
p1gen8$single$PkgWatt <- outliers(x, span=0.85, plot=TRUE)$repaired
dev.off()

taf.png("model/p15gen1_Repairs")
par(mfrow=c(2, 3))
# Repair p15gen1 (CorWatt)
x <- p15gen1$full$CorWatt
p15gen1$full$CorWatt <- outliers(x, level=0.3, span=0.5, plot=TRUE)$repaired
x <- p15gen1$main$CorWatt
p15gen1$full$CorWatt <- outliers(x, span=0.5, plot=TRUE)$repaired
x <- p15gen1$single$CorWatt
p15gen1$full$CorWatt <- outliers(x, span=0.8, plot=TRUE)$repaired
# Repair p15gen1 (PkgWatt)
x <- p15gen1$full$PkgWatt
p15gen1$full$PkgWatt <- outliers(x, level=0.3, span=0.5, plot=TRUE)$repaired
x <- p15gen1$main$PkgWatt
p15gen1$main$PkgWatt <- outliers(x, span=0.5, plot=TRUE)$repaired
x <- p15gen1$single$PkgWatt
p15gen1$single$PkgWatt <- outliers(x, level=0.3, span=0.8, plot=TRUE)$repaired
dev.off()

# Save RDS objects
saveRDS(p1gen8, "model/p1gen8.rds")
saveRDS(p15gen1, "model/p15gen1.rds")
