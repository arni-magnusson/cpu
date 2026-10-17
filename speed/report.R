# Produce plots and tables for report
#
# Before: analysis CSV tables (output)
# After:  report CSV tables and PNG plots (report)

dir.create("report", showWarnings=FALSE, recursive=TRUE)

comparison <- read.csv("output/comparison.csv", stringsAsFactors=FALSE)
catage_speed <- read.csv("output/catage_speed.csv", stringsAsFactors=FALSE)
relationship <- read.csv("output/relationship.csv", stringsAsFactors=FALSE)
relationship_summary <- read.csv("output/relationship_summary.csv",
                                 stringsAsFactors=FALSE)

# Write compact tables for the report.
passmark_comparison <- comparison[, c(
  "machine", "processor_online", "processor_local", "online_single",
  "passmark_single", "score_difference", "score_percent_difference")]
catage_speeds <- catage_speed[, c(
  "machine", "mcmc", "sec", "iterations_per_second")]
relationship_table <- relationship[, c(
  "machine", "passmark_single", "catage_1e7_iterations_per_second",
  "iterations_per_second_per_passmark_point", "passmark_rank", "catage_rank")]

write.csv(passmark_comparison, "report/passmark_comparison.csv",
          row.names=FALSE)
write.csv(catage_speeds, "report/catage_speeds.csv", row.names=FALSE)
write.csv(relationship_table, "report/relationship.csv", row.names=FALSE)
write.csv(relationship_summary, "report/relationship_summary.csv",
          row.names=FALSE)

# Plot the relationship between the two local performance measurements.
png("report/passmark_vs_catage.png", width=1200, height=900, res=150)
par(mar=c(5, 5, 3, 1))
plot(relationship$passmark_single,
     relationship$catage_1e7_iterations_per_second,
     type="n", xlab="Local PassMark single-thread score",
     ylab="Catage speed (iterations per second; 1e7 run)",
     ylim=c(0, max(relationship$catage_1e7_iterations_per_second) * 1.12),
     main="Local PassMark score and catage speed")
points(relationship$passmark_single,
       relationship$catage_1e7_iterations_per_second,
       pch=19, col="steelblue", cex=1.3)
text(relationship$passmark_single,
     relationship$catage_1e7_iterations_per_second,
     labels=relationship$machine, pos=3, cex=0.9)
abline(lm(catage_1e7_iterations_per_second ~ passmark_single,
          data=relationship), col="gray40", lty=2)
dev.off()

# Show how catage speed per PassMark point varies by processor.
scale_order <- order(relationship$iterations_per_second_per_passmark_point)
scale_values <- relationship$iterations_per_second_per_passmark_point[scale_order]
scale_names <- relationship$machine[scale_order]
png("report/catage_speed_per_passmark_point.png",
    width=1200, height=900, res=150)
par(mar=c(7, 5, 3, 1))
bars <- barplot(scale_values, names.arg=scale_names, las=2,
                ylim=c(0, max(scale_values) * 1.15),
                ylab="Catage iterations per second per PassMark point",
                main="Catage speed per local PassMark point",
                col="steelblue")
text(bars, scale_values, labels=round(scale_values, 1), pos=3, cex=1)
dev.off()

