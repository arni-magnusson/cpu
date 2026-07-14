# Run analysis, write model results

# Before: p1gen8.rds (data)
# After:  p1gen8.rds (model)

library(TAF)

mkdir("model")

p1gen8 <- readRDS("data/p1gen8.rds")

saveRDS(p1gen8, "model/p1gen8.rds")
