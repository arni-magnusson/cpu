# Run analysis, write model results

# Before: m4700.rds, p1gen8.rds, p15gen1.rds, p3560.rds (data)
# After:  m4700.rds, p1gen8.rds, p15gen1.rds, p3560.rds, results.rds,
#         summary.csv (model)

library(TAF)
source("utilities.R")  # means, remove_first, summary_machine

mkdir("model")

# Read data
m4700 <- readRDS("data/m4700.rds")
p1gen8 <- readRDS("data/p1gen8.rds")
p15gen1 <- readRDS("data/p15gen1.rds")
p3560 <- readRDS("data/p3560.rds")

# Remove first measurements, keep 300 measurements
m4700 <- mapply(remove_first, m4700, burn=c(3,1,1,1), SIMPLIFY=FALSE)
p1gen8 <- mapply(remove_first, p1gen8, burn=c(0,1,1,1), SIMPLIFY=FALSE)
p15gen1 <- mapply(remove_first, p15gen1, burn=c(0,0,0,1), SIMPLIFY=FALSE)
p3560 <- mapply(remove_first, p3560, burn=c(0,1,1,0), SIMPLIFY=FALSE)

# Prepare p15gen1 repairs
na.begin <- 257
na.count <- 300 - na.begin + 1
iter <- 1:300

# Repair p15gen1$idle$Freq1
steady.freq.begin <- 100
freq.measurements <- p15gen1$idle$Freq1[steady.freq.begin:(na.begin-1)]
set.seed(2)
freq.noise <- sample(freq.measurements, na.count)
p15gen1$idle$Freq1[na.begin:300] <- freq.noise

# Repair p15gen1$idle$Temp1
cool.begin <- 228
temp.coef <- coef(lm(Temp1~iter, p15gen1$idle, subset=cool.begin:na.begin))
temp.fit <- temp.coef[[1]] + temp.coef[[2]] * iter
set.seed(0)
temp.noise <- round(temp.fit + rnorm(300, 0, 0.3))
p15gen1$idle$Temp1[na.begin:300] <- temp.noise[na.begin:300]

# Repair p15gen1$idle$Fan1
steady.fan.begin <- 234
fan.measurements <- p15gen1$idle$Fan1[steady.fan.begin:(na.begin-1)]
fan.noise <- sample(fan.measurements, na.count, replace=TRUE)
p15gen1$idle$Fan1[na.begin:300] <- fan.noise

# Repair p15gen1$single
p15gen1$single$Freq1 <- c(4693, 4690)
p15gen1$single$Temp1 <- c(100, 100)
p15gen1$single$Fan1 <- c(3937, 3938)

# Calculate results averaging over time
results <- list(m4700=sapply(m4700, means),
                p1gen8=sapply(p1gen8, means),
                p15gen1=sapply(p15gen1, means),
                p3560=sapply(p3560, means))

# Calculate summary table
summary <- rbind(summary_machine(m4700),
                 summary_machine(p1gen8),
                 summary_machine(p15gen1),
                 summary_machine(p3560))

# Save RDS objects
saveRDS(m4700, "model/m4700.rds")
saveRDS(p1gen8, "model/p1gen8.rds")
saveRDS(p15gen1, "model/p15gen1.rds")
saveRDS(p3560, "model/p3560.rds")
saveRDS(results, "model/results.rds")

# Write table
write.taf(summary, dir="model")
