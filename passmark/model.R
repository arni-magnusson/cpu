# Run analysis, write model results

# Before: passmark.csv (data)
# After:  passmark.csv (model)

library(TAF)

mkdir("model")

# Read data
passmark <- read.taf("data/passmark.csv")

# Select columns
passmark <- passmark[c("machine", "single")]

# Write table
write.taf(passmark, dir="model")
