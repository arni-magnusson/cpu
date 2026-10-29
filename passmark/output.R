# Extract results of interest, write CSV output tables

# Before: single.csv (model)
# After:  single.csv (output)

library(TAF)

mkdir("output")

cp("model/single.csv", "output")
