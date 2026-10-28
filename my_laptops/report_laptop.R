# Plot laptop variables

# Before: specs.csv (output)
# After:  laptop_display.png, laptop_memory.png, laptop_power.png,
#         laptop_storage.png, laptop_thick.png, laptop_weight.png,
#         screen_density.png, screen_megapixels.png, screen_pixels.png (report)

library(TAF)

mkdir("report")

# Read data
specs <- read.taf("output/specs.csv", colClasses=c(Date="Date"))

# Plot laptop variables
taf.png("laptop_display")
plot(Disp~Date, specs, pch=21, bg=bg, ylab="Screen size (in)", yaxt="n",
     ylim=c(13,16.2))
axis(2, c(13, 14, 15, 16))
dev.off()

taf.png("laptop_memory")
plot(RAM~Date, specs, log="y", pch=21, bg=bg, yaxt="n", ylab="Memory (GB)",
     ylim=c(0.4, 75))
values <- c("0.5", "1", "2", "4", "8", "16", "32", "64")
axis(2, as.numeric(values), values)
dev.off()

taf.png("laptop_power")
plot(Power~Date, specs, ylim=lim(Power), pch=21, bg=bg)
dev.off()

taf.png("laptop_storage")
plot(Storage~Date, specs, log="y", pch=21, bg=bg, yaxt="n", ylim=c(0.03, 4),
     ylab="Storage (TB)")
values <- c("0.05", "0.1", "0.2", "0.5", "1", "2", "4")
axis(2, as.numeric(values), values)
dev.off()

taf.png("laptop_thick")
plot(Height~Date, specs, ylim=lim(Height), pch=21, bg=bg, ylab="Thickness (cm)",
     yaxs="i")
dev.off()

taf.png("laptop_weight")
plot(Weight~Date, specs, ylim=lim(Weight), pch=21, bg=bg, ylab="Weight (kg)")
dev.off()

# Plot screen variables
taf.png("screen_density")
plot(ppi~Date, specs, log="y", pch=21, bg=bg, ylab="Density (PPI)",
     ylim=c(80, 300))
dev.off()

taf.png("screen_megapixels")
plot(mp~Date, specs, log="y", pch=21, bg=bg, ylab="Megapixels",
     ylim=c(0.7, 10.5))
dev.off()

taf.png("screen_pixels")
plot(h~Date, specs, log="y", pch=21, bg=bg, ylab="Vertical pixels", yaxt="n",
     ylim=c(720, 2550))
axis(2, c(768, 1080, 1440, 2400))
dev.off()
