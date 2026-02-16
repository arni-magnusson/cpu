# Plot speed (single thread) over time

# Before: i7_high.csv, i7_low.csv, i7_medium.csv, r7_high.csv,
#         r7_low.csv (output)
# After:  speed_all.png, speed_high.png, speed_low.png,
#         speed_medium.png (report)

library(TAF)

mkdir("report")

# Read tables
i7_high <- read.taf("output/i7_high.csv", colClasses=c(Date="Date"))
i7_medium <- read.taf("output/i7_medium.csv", colClasses=c(Date="Date"))
i7_low <- read.taf("output/i7_low.csv", colClasses=c(Date="Date"))
r7_high <- read.taf("output/r7_high.csv", colClasses=c(Date="Date"))
r7_low <- read.taf("output/r7_low.csv", colClasses=c(Date="Date"))

# Plot speed over time
taf.png("speed_all", width=1200)
plot(Speed~Date, i7_high, log="y", type="o", col=4,
     xlim=as.Date(c("2009-01-01", "2027-01-01")), ylim=c(900, 4400))
lines(Speed~Date, r7_high, type="o", col=2)
lines(Speed~Date, i7_medium, type="o", col=4)
lines(Speed~Date, i7_low, type="o", col=4)
lines(Speed~Date, r7_low, type="o", col=2)
dev.off()

taf.png("speed_high", width=1200)
plot(Speed~Date, i7_high, log="y", type="o", col=4,
     xlim=as.Date(c("2009-01-01", "2027-01-01")), ylim=c(900, 4400))
lines(Speed~Date, r7_high, type="o", col=2)
dev.off()

taf.png("speed_low", width=1200)
plot(Speed~Date, i7_low, log="y", type="o", col=4,
     xlim=as.Date(c("2009-01-01", "2027-01-01")), ylim=c(900, 4400))
lines(Speed~Date, r7_low, type="o", col=2)
dev.off()

taf.png("speed_medium", width=1200)
plot(Speed~Date, i7_medium, log="y", type="o", col=4,
     xlim=as.Date(c("2009-01-01", "2027-01-01")), ylim=c(900, 4400))
dev.off()
