# Extract results of interest, write CSV output tables
#
# Before: comparison.csv, catage_speed.csv, relationship.csv,
#         relationship_summary.csv (model)
# After:  same analysis tables (output)

dir.create("output", showWarnings=FALSE, recursive=TRUE)

comparison <- read.csv("model/comparison.csv", stringsAsFactors=FALSE)
catage_speed <- read.csv("model/catage_speed.csv", stringsAsFactors=FALSE)
relationship <- read.csv("model/relationship.csv", stringsAsFactors=FALSE)
relationship_summary <- read.csv("model/relationship_summary.csv",
                                 stringsAsFactors=FALSE)

write.csv(comparison, "output/comparison.csv", row.names=FALSE)
write.csv(catage_speed, "output/catage_speed.csv", row.names=FALSE)
write.csv(relationship, "output/relationship.csv", row.names=FALSE)
write.csv(relationship_summary, "output/relationship_summary.csv",
          row.names=FALSE)

