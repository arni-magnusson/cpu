# Extract results of interest, write CSV output tables
#
# Before: comparison.csv, catage_speed.csv, relationship.csv,
#         relationship_summary.csv (model)
# After:  same analysis tables (output)

library(TAF)
mkdir("output")

comparison <- read.taf("model/comparison.csv")
catage_speed <- read.taf("model/catage_speed.csv")
relationship <- read.taf("model/relationship.csv")
relationship_summary <- read.taf("model/relationship_summary.csv")

write.taf(comparison, dir="output")
write.taf(catage_speed, dir="output")
write.taf(relationship, dir="output")
write.taf(relationship_summary, dir="output")

