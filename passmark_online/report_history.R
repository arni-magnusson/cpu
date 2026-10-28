# Plot long-term historical trends

# Before: history.csv, history_fit.csv, history.rate.csv (output)
# After:  history_data.png, history_fit.png, history_rate.png,
#         history_time.png (report)

library(TAF)

mkdir("report")

# Read data
history <- read.taf("output/history.csv", colClasses=c(Date="Date"))
history.fit <- read.taf("output/history_fit.csv", colClasses=c(Date="Date"))
history.rate <- read.taf("output/history_rate.csv")

# Prepare for plotting
score <- "Score (PassMark single thread)"
lwd <- 2

# Historical observations
taf.png("history_data", width=1200)
plot(Speed~Date, history, type="n", log="y", ylab=score)
points(Speed~Date, history, subset=Period=="Early")
points(Speed~Date, history, subset=Period=="Late", pch=19)
legend("topleft", legend=c("Early", "Late"), pch=c(1, 19), bty="n", inset=0.02,
       y.intersp=1.25)
dev.off()

# Historical trends
taf.png("history_fit", width=1200)
plot(Speed~Date, history, type="n", log="y", ylab=score)
points(Speed~Date, history, subset=Period=="Early")
points(Speed~Date, history, subset=Period=="Late", pch=19)
lines(Speed~Date, history.fit, subset=Period=="Early")
lines(Speed~Date, history.fit, subset=Period=="Late")
legend("topleft", legend=c("Early", "Late"), pch=c(1, 19), bty="n", inset=0.02,
       y.intersp=1.25)
dev.off()

# Annual improvement
taf.png("history_rate", width=1200)
barplot(100*Annual~Period, history.rate, ylab="Annual improvement (%)")
dev.off()

# Doubling time
taf.png("history_time", width=1200)
barplot(Doubling~Period, history.rate, ylab="Doubling time (yr)")
dev.off()
