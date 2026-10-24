# Plot speed (single thread) over time

# Before: apple.csv (data), companies.csv, i7_high.csv, r7_high (output)
# After:  apple.png, companies.png (report)

library(TAF)

mkdir("report")

# Read tables
apple <- read.taf("data/apple.csv", colClasses=c(Date="Date"))
companies <- read.taf("data/companies.csv", colClasses=c(Date="Date"))
i7_high <- read.taf("output/i7_high.csv", colClasses=c(Date="Date"))
r7_high <- read.taf("output/r7_high.csv", colClasses=c(Date="Date"))

# Air vs Pro
taf.png("apple", width=1200)
plot(Speed~Date, apple, log="y", pch=c(1,19))
legend("topleft", legend=c("Pro", "Air"), pch=c(19,1), bty="n", inset=0.02,
       y.intersp=1.25)
dev.off()

# Apple vs Intel vs AMD
taf.png("companies", width=1200)
plot(Speed~Date, companies, type="n", log="y")
points(Speed~Date, companies, subset=Company=="Apple", pch=19, col=1)
points(Speed~Date, companies, subset=Company=="Intel", pch=19, col=4)
points(Speed~Date, companies, subset=Company=="AMD", pch=19, col=2)
legend("topleft", legend=c("Apple", "Intel", "AMD"), pch=19, col=c(1,4,2),
       bty="n", inset=0.02, y.intersp=1.25)
dev.off()
