# Run analysis, write model results

# Before: passmark.csv (data)
# After:  passmark.csv (model)

library(TAF)

mkdir("model")

# Read data
passmark <- read.taf("data/passmark.csv")

# Select and rename columns
passmark <- passmark[c("machine", "single", "cpu", "memory")]
names(passmark)[names(passmark) == "cpu"] <- "multi"

# Write table
write.taf(passmark, dir="model")
