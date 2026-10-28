# Plot CPU variables

# Before: specs.csv, speed_fit.csv (output)
# After:  cpu_cache.png, cpu_cores.png, cpu_freq.png, cpu_nm.png,
#         cpu_speed_data.png, cpu_speed_fit.png, cpu_speed_nm.png,
#         cpu_speed_watts.png, cpu_threads.png, cpu_watts.png (report)

library(TAF)

mkdir("report")

# Read data
specs <- read.taf("output/specs.csv", colClasses=c(Date="Date"))
speed.fit <- read.taf("output/speed_fit.csv", colClasses=c(Date="Date"))

# Univariate time series
taf.png("cpu_cache")
plot(Cache~Date, specs, log="y", pch=21, bg=bg, ylab="Cache (MB)", yaxt="n",
     ylim=c(0.4, 32))
values <- c("0.5", "1", "2", "4", "8", "16", "32")
axis(2, as.numeric(values), values)
dev.off()

taf.png("cpu_cores")
plot(Cores~Date, specs, pch=21, bg=bg, yaxt="n", ylim=c(0.5, 8.5))
axis(2, c(1,2,4,6,8))
dev.off()

taf.png("cpu_freq")
plot(Turbo/1000~Date, specs, log="y", pch=21, bg=bg, ylab="Frequency (GHz)",
     ylim=c(2,6))
dev.off()

taf.png("cpu_nm")
plot(nm~Date, specs, log="y", pch=21, bg=bg, ylab="Process (nm)",
     ylim=c(2.5, 150))
dev.off()

taf.png("cpu_speed_data")
plot(Speed~Date, specs, log="y", pch=21, bg=bg, ylim=c(350, 5000),
     ylab="Score (PassMark single thread)")
dev.off()

taf.png("cpu_threads")
plot(Threads~Date, specs, pch=21, bg=bg, yaxt="n", ylim=c(0.5, 16.5))
values <- c(0.9, 2.1, 4, 6, 8, 10, 12, 14, 16)
axis(2, values, round(values))
dev.off()

taf.png("cpu_watts")
plot(W~Date, specs, ylim=lim(W), pch=21, bg=bg, ylab="Thermal design (W)")
dev.off()

# Fitted historical trend
taf.png("cpu_speed_fit")
plot(Speed~Date, specs, log="y", pch=21, bg=bg, ylim=c(350, 5000),
      ylab="Score (PassMark single thread)")
lines(Speed~Date, speed.fit)
dev.off()

# Relationships between variables
taf.png("cpu_speed_nm")
plot(Speed~sqrt(nm), specs, log="y", pch=21, bg=bg, ylim=c(350, 5000),
     xlab="sqrt(Process nm)", ylab="Score (PassMark single thread)")
dev.off()

taf.png("cpu_speed_watts")
plot(Speed/W~Date, specs, log="y", pch=21, bg=bg,
     ylab="Processor speed per watt")
dev.off()
