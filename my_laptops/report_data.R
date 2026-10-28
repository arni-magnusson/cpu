# Plot time series of data

# Before: specs.csv (output)
# After:

library(TAF)

mkdir("report")

# Read data
specs <- read.taf("output/specs.csv", colClasses=c(Date="Date"))

# Time series
plot(nm~Date, specs, log="y", pch=21, bg=bg)
plot(Turbo~Date, specs, log="y", pch=21, bg=bg)
plot(Cores~Date, specs, ylim=lim(Cores), pch=21, bg=bg)
plot(Threads~Date, specs, ylim=lim(Threads), pch=21, bg=bg)
plot(Cache~Date, specs, log="y", pch=21, bg=bg)
plot(W~Date, specs, ylim=lim(W), pch=21, bg=bg)
plot(Speed~Date, specs, log="y", pch=21, bg=bg)
plot(RAM~Date, specs, log="y", pch=21, bg=bg)
plot(Storage~Date, specs, log="y", pch=21, bg=bg)
plot(Disp~Date, specs, pch=21, bg=bg)
plot(Power~Date, specs, ylim=lim(Power), pch=21, bg=bg)
plot(Height~Date, specs, ylim=lim(Height), pch=21, bg=bg)
plot(Weight~Date, specs, ylim=lim(Weight), pch=21, bg=bg)
plot(h~Date, specs, ylim=lim(h), pch=21, bg=bg)
plot(mp~Date, specs, log="y", pch=21, bg=bg)
plot(ppi~Date, specs, pch=21, bg=bg)
