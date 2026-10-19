# Extract results of interest, write CSV output tables

# Before: passmark.csv (model)
# After:  passmark.csv (output)

library(TAF)

mkdir("output")

cp("model/passmark.csv", "output")
