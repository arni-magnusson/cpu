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
par(mfrow=c(1, 4))
x <- m4700$idle$Watt
m4700$idle$Watt <- outliers(x, dist=0.5, plot=TRUE)$repaired
dev.off()

taf.png("model/p1gen8_Repairs")
par(mfrow=c(1, 4))
x <- p1gen8$main$Watt
p1gen8$main$Watt <- outliers(x, dist=20, plot=TRUE)$repaired
dev.off()

taf.png("model/p15gen1_Repairs")
par(mfrow=c(1, 4))
x <- p15gen1$idle$Watt
p15gen1$idle$Watt <- outliers(x, dist=0.2, plot=TRUE)$repaired
dev.off()

taf.png("model/p3560_Repairs")
par(mfrow=c(1, 4))
x <- p3560$single$Watt
p3560$single$Watt <- outliers(x, dist=0.5, span=0.3, plot=TRUE)$repaired
x <- p3560$idle$Watt
p3560$idle$Watt <- outliers(x, dist=5, plot=TRUE)$repaired
dev.off()

# Save RDS objects
saveRDS(m4700, "model/m4700.rds")
saveRDS(p1gen8, "model/p1gen8.rds")
saveRDS(p15gen1, "model/p15gen1.rds")
saveRDS(p3560, "model/p3560.rds")
