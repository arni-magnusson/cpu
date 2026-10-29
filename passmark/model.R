# Run analysis, write model results

# Before: passmark.csv (data)
# After:  single.csv (model)

library(TAF)

mkdir("model")

# Read data
passmark <- read.taf("data/passmark.csv")

# Prepare single-thread benchmark score
single <- data.frame(machine=passmark$machine, score=passmark$single)

# Write table
write.taf(single, dir="model")
