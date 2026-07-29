# Run analysis, write model results

# Before: i7_high.csv, i7_low.csv, i7_medium.csv, r7_high.csv, r7_low.csv (data)
# After:  i7_high.csv, i7_low.csv, i7_medium.csv, r7_high.csv,
#         r7_low.csv (model)

library(TAF)

mkdir("model")

# Read tables
i7_high <- read.taf("data/i7_high.csv")
i7_medium <- read.taf("data/i7_medium.csv")
i7_low <- read.taf("data/i7_low.csv")
r7_high <- read.taf("data/r7_high.csv")
r7_low <- read.taf("data/r7_low.csv")

# Calculate relative speed improvement
improve <- function(x) c(NA, x$Speed[-1] / x$Speed[-nrow(x)]) - 1
i7_high$Improve <- improve(i7_high)
i7_medium$Improve <- improve(i7_medium)
i7_low$Improve <- improve(i7_low)
r7_high$Improve <- improve(r7_high)
r7_low$Improve <- improve(r7_low)

# Save tables
write.taf(i7_high, dir="model")
write.taf(i7_medium, dir="model")
write.taf(i7_low, dir="model")
write.taf(r7_high, dir="model")
write.taf(r7_low, dir="model")
