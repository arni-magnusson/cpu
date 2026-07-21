# Produce plots and tables for report

# Before: info.csv (data), m4700.rds, p1gen8.rds, p15gen1.rds, p3560.rds (model)
# After:  m4700_Temp.png, m4700_Watt.png,
#         p1gen8_Temp.png, p1gen8_Watt.png,
#         p15gen1_Temp.png, p15gen1_Watt.png,
#         p3560_Temp.png, p3560_Watt.png (report)

library(TAF)
source("utilities.R")

mkdir("report")

# Read data
info <- read.taf("data/info.csv")
m4700 <- readRDS("model/m4700.rds")
p1gen8 <- readRDS("model/p1gen8.rds")
p15gen1 <- readRDS("model/p15gen1.rds")
p3560 <- readRDS("model/p3560.rds")

# Prepare plot elements
iter <- seq(1:nrow(m4700$idle))
machines <- list(m4700=m4700, p15gen1=p15gen1, p3560=p3560, p1gen8=p1gen8)

# Smooth m4700
smooth_m4700 <- m4700
smooth_m4700$full$Watt <- mean(m4700$full$Watt)
smooth_m4700$main$Watt <- mean(m4700$main$Watt)
smooth_m4700$single$Watt <- mean(m4700$single$Watt)
smooth_m4700$idle$Watt <- mean(m4700$idle$Watt)

# Smooth p1gen8
smooth_p1gen8 <- p1gen8
smooth_p1gen8$full$Watt <- loess(Watt~iter, p1gen8$full, span=0.4)$fitted
smooth_p1gen8$main$Watt <- loess(Watt~iter, p1gen8$main, span=0.4)$fitted
smooth_p1gen8$single$Watt <- loess(Watt~iter, p1gen8$single, span=0.6)$fitted
smooth_p1gen8$idle$Watt <- mean(p1gen8$idle$Watt)

# Smooth p15gen1
smooth_p15gen1 <- p15gen1
smooth_p15gen1$full$Watt <- loess(Watt~iter, p15gen1$full, span=0.9)$fitted
smooth_p15gen1$main$Watt <- loess(Watt~iter, p15gen1$main, span=0.9)$fitted
smooth_p15gen1$single$Watt <- loess(Watt~iter, p15gen1$single, span=0.9)$fitted
mean(p15gen1$idle$Watt)

# Smooth p3560
smooth_p3560 <- p3560
smooth_p3560$full$Watt <- loess(Watt~iter, p3560$full, span=0.11)$fitted
smooth_p3560$main$Watt <- loess(Watt~iter, p3560$main, span=0.21)$fitted
stable <- replace(p3560$single$Watt, 120:300, mean(p3560$single$Watt[120:300]))
smooth_p3560$single$Watt <- loess(stable~iter, span=0.30)$fitted
smooth_p3560$idle <- mean(p3560$idle$Watt)

# Plot each machine
taf.png("m4700_Temp")
plot_machine(m4700, "Temp")
dev.off()
taf.png("m4700_Watt")
plot_machine(m4700, "Watt")
dev.off()
taf.png("p1gen8_Temp")
plot_machine(p1gen8, "Temp")
dev.off()
taf.png("p1gen8_Watt")
plot_machine(p1gen8, "Watt")
dev.off()
taf.png("p15gen1_Temp")
plot_machine(p15gen1, "Temp")
dev.off()
taf.png("p15gen1_Watt")
plot_machine(p15gen1, "Watt")
dev.off()
taf.png("p3560_Temp")
plot_machine(p3560, "Temp")
dev.off()
taf.png("p3560_Watt")
plot_machine(p3560, "Watt")
dev.off()

# Plot machine comparison
# taf.png("x")
plot_comparison(machines, "full", "Watt", legend=legend)
# dev.off()
