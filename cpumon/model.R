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

# Remove first measurements, keep 3 minutes of measurements
m4700 <- mapply(remove_first, m4700, n=c(3,1,0,0), SIMPLIFY=FALSE)
p1gen8 <- mapply(remove_first, p1gen8, n=c(0,0,1,1), SIMPLIFY=FALSE)
p15gen1 <- mapply(remove_first, p15gen1, n=c(0,0,0,1), SIMPLIFY=FALSE)
p3560 <- mapply(remove_first, p3560, n=c(0,0,1,0), SIMPLIFY=FALSE)

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
