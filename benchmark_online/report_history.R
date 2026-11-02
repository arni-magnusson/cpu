# Plot long-term historical trends

# Before: history_analysis.csv, history_fit.csv, history.rate.csv (output)
# After:  history_data.png, history_fit.png, history_rate.png,
#         history_time.png (report)

library(TAF)

mkdir("report")

# Read data
history.analysis <- read.taf("output/history_analysis.csv",
                             colClasses=c(Date="Date"))
history.fit <- read.taf("output/history_fit.csv", colClasses=c(Date="Date"))
history.rate <- read.taf("output/history_rate.csv")

# Prepare for plotting
score <- "Score (PassMark single thread)"
intel <- "History (Intel)"
lwd <- 2

# Historical observations
taf.png("history_data", width=1200)
plot(Speed~Date, history.analysis, type="n", log="y", main=intel, ylab=score)
points(Speed~Date, history.analysis, subset=Period=="Early", col=4)
points(Speed~Date, history.analysis, subset=Period=="Late", pch=19, col=4)
legend("topleft", legend=c("Early", "Late"), pch=c(1, 19), col=4, bty="n",
       inset=0.02, y.intersp=1.25)
dev.off()

# Historical trends
taf.png("history_fit", width=1200)
plot(Speed~Date, history.analysis, type="n", log="y", main=intel, ylab=score)
points(Speed~Date, history.analysis, subset=Period=="Early", col=4)
points(Speed~Date, history.analysis, subset=Period=="Late", pch=19, col=4)
lines(Speed~Date, history.fit, subset=Period=="Early", col=4)
lines(Speed~Date, history.fit, subset=Period=="Late", col=4)
legend("topleft", legend=c("Early", "Late"), pch=c(1, 19), col=4, bty="n",
       inset=0.02, y.intersp=1.25)
dev.off()

# Annual improvement
taf.png("history_rate", width=1200)
barplot(100*Annual~Period, history.rate, col=5:4, main=intel,
        ylab="Annual improvement (%)")
dev.off()

# Doubling time
taf.png("history_time", width=1200)
barplot(Doubling~Period, history.rate, col=5:4, main=intel,
        ylab="Doubling time (yr)")
dev.off()
