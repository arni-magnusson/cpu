# Run analysis, write model results

# Before: m4700.rds, p1gen8.rds, p15gen1.rds, p3560.rds (data)
# After:  m4700_Repairs.png, m4700.rds,
#         p1gen8_Repairs.png, p1gen8.rds,
#         p15gen1_Repairs.png, p15gen1.rds,
#         p3560_Repairs.png, p3560.rds (model)

library(TAF)
source("utilities.R")

mkdir("model")

# Read data
m4700 <- readRDS("data/m4700.rds")
p1gen8 <- readRDS("data/p1gen8.rds")
p15gen1 <- readRDS("data/p15gen1.rds")
p3560 <- readRDS("data/p3560.rds")

taf.png("model/m4700_Repairs")
par(mfrow=c(2, 4))
# Repair m4700 (CorWatt)
x <- m4700$full$CorWatt
m4700$full$CorWatt <- outliers(x, level=0.4, span=10, plot=TRUE)$repaired
x <- m4700$main$CorWatt
m4700$main$CorWatt <- outliers(x, level=0.3, span=10, plot=TRUE)$repaired
x <- m4700$single$CorWatt
m4700$single$CorWatt <- outliers(x, span=10, plot=TRUE)$repaired
x <- m4700$idle$CorWatt
m4700$idle$CorWatt <- outliers(x, plot=TRUE)$repaired
# Repair m4700 (PkgWatt)
x <- m4700$full$PkgWatt
m4700$full$PkgWatt <- outliers(x, level=0.4, span=10, plot=TRUE)$repaired
x <- m4700$main$PkgWatt
m4700$main$PkgWatt <- outliers(x, level=0.3, span=10, plot=TRUE)$repaired
x <- m4700$single$PkgWatt
m4700$single$PkgWatt <- outliers(x, span=10, plot=TRUE)$repaired
x <- m4700$idle$PkgWatt
m4700$idle$PkgWatt <- outliers(x, level=0.07, plot=TRUE)$repaired
dev.off()

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
par(mfrow=c(2, 4))
# Repair p15gen1 (CorWatt)
x <- p15gen1$full$CorWatt
p15gen1$full$CorWatt <- outliers(x, level=0.3, span=0.5, plot=TRUE)$repaired
x <- p15gen1$main$CorWatt
p15gen1$main$CorWatt <- outliers(x, span=0.5, plot=TRUE)$repaired
x <- p15gen1$single$CorWatt
p15gen1$single$CorWatt <- outliers(x, span=0.8, plot=TRUE)$repaired
x <- p15gen1$idle$CorWatt
p15gen1$idle$CorWatt <- outliers(x, level=1.2, span=0.8, plot=TRUE)$repaired
# Repair p15gen1 (PkgWatt)
x <- p15gen1$full$PkgWatt
p15gen1$full$PkgWatt <- outliers(x, level=0.3, span=0.5, plot=TRUE)$repaired
x <- p15gen1$main$PkgWatt
p15gen1$main$PkgWatt <- outliers(x, span=0.5, plot=TRUE)$repaired
x <- p15gen1$single$PkgWatt
p15gen1$single$PkgWatt <- outliers(x, level=0.3, span=0.8, plot=TRUE)$repaired
x <- p15gen1$idle$PkgWatt
p15gen1$idle$PkgWatt <- outliers(x, level=0.1, span=0.8, plot=TRUE)$repaired
dev.off()

taf.png("model/p3560_Repairs")
par(mfrow=c(2, 4))
# Repair p3560 (CorWatt)
x <- p3560$full$CorWatt
p3560$full$CorWatt <- outliers(x, span=0.3, plot=TRUE)$repaired
x <- p3560$main$CorWatt
p3560$main$CorWatt <- outliers(x, span=0.25, plot=TRUE)$repaired
x <- p3560$single$CorWatt
p3560$single$CorWatt <- outliers(x, level=0.04, span=0.65, plot=TRUE)$repaired
# Repair p3560 (PkgWatt)
x <- p3560$full$PkgWatt
p3560$full$PkgWatt <- outliers(x, span=0.3, plot=TRUE)$repaired
x <- p3560$main$PkgWatt
p3560$main$PkgWatt <- outliers(x, span=0.25, plot=TRUE)$repaired
x <- p3560$single$PkgWatt
p3560$single$PkgWatt <- outliers(x, level=0.04, span=0.65, plot=TRUE)$repaired
x <- p3560$idle$PkgWatt
p3560$idle$PkgWatt <- outliers(x, level=0.7, span=0.65, plot=TRUE)$repaired
dev.off()

# Save RDS objects
saveRDS(m4700, "model/m4700.rds")
saveRDS(p1gen8, "model/p1gen8.rds")
saveRDS(p15gen1, "model/p15gen1.rds")
saveRDS(p3560, "model/p3560.rds")
