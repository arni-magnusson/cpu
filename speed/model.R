# Run analysis, write model results
#
# Before: passmark_online.csv, passmark_local.csv, catage.csv (data)
# After:  comparison.csv, catage_speed.csv, relationship.csv,
#         relationship_summary.csv (model)

library(TAF)
mkdir("model")

passmark_online <- read.taf("data/passmark_online.csv")
passmark_local <- read.taf("data/passmark_local.csv")
machine_order <- c("m4700", "p15gen1", "p3560", "p1gen8")

# Pair online and local PassMark measurements by laptop.
comparison <- merge(passmark_online, passmark_local, by="machine",
                    all=TRUE, sort=FALSE)
comparison <- comparison[match(comparison$machine, machine_order), ]
comparison$score_difference <- comparison$passmark_single -
  comparison$online_single
comparison$score_ratio <- comparison$passmark_single /
  comparison$online_single
comparison$score_percent_difference <- 100 * (comparison$score_ratio - 1)
row.names(comparison) <- NULL

# Calculate catage iteration rates, retaining both run lengths.
catage_speed <- read.taf("data/catage.csv")
catage_speed$iterations_per_second <- catage_speed$mcmc / catage_speed$sec

# Compare local PassMark scores with the sustained (1e7 iteration) catage run.
sustained <- catage_speed[catage_speed$mcmc == 1e7,
                          c("machine", "iterations_per_second")]
names(sustained)[2L] <- "catage_1e7_iterations_per_second"
relationship <- merge(passmark_local, sustained, by="machine",
                      all=TRUE, sort=FALSE)
relationship <- relationship[match(relationship$machine, machine_order), ]
relationship$iterations_per_second_per_passmark_point <-
  relationship$catage_1e7_iterations_per_second /
  relationship$passmark_single
relationship$passmark_rank <- rank(relationship$passmark_single)
relationship$catage_rank <- rank(relationship$catage_1e7_iterations_per_second)
row.names(relationship) <- NULL

complete <- complete.cases(relationship[, c(
  "passmark_single", "catage_1e7_iterations_per_second")])
relationship_summary <- data.frame(
  measure=c("processors", "Pearson correlation", "Spearman correlation",
            "mean iterations per second per PassMark point",
            "minimum iterations per second per PassMark point",
            "maximum iterations per second per PassMark point"),
  value=c(sum(complete),
          cor(relationship$passmark_single[complete],
              relationship$catage_1e7_iterations_per_second[complete]),
          cor(relationship$passmark_single[complete],
              relationship$catage_1e7_iterations_per_second[complete],
              method="spearman"),
          mean(relationship$iterations_per_second_per_passmark_point[complete]),
          min(relationship$iterations_per_second_per_passmark_point[complete]),
          max(relationship$iterations_per_second_per_passmark_point[complete])),
  stringsAsFactors=FALSE)

write.taf(comparison, dir="model")
write.taf(catage_speed, dir="model")
write.taf(relationship, dir="model")
write.taf(relationship_summary, dir="model")

