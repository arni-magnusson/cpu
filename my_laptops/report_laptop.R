# Plot laptop variables

# Before: specs.csv (output)
# After:  laptop_display.png, laptop_memory.png, laptop_power.png,
#         laptop_storage.png, laptop_thick.png, laptop_weight.png,
#         screen_density.png, screen_megapixels.png, screen_pixels.png,
#         specs.csv, specs.md, storage_memory_prop.png,
#         storage_memory_text.png (report)

library(TAF)
library(knitr)

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

# Relationship between variables
n <- nrow(specs)
taf.png("storage_memory_prop")
specs$Percentage <- specs$RAM / (1000*specs$Storage)
plot(Percentage~Date, specs, pch=21, bg=bg, ylim=lim(Percentage),
     main="Memory tends to be around 2% of storage", ylab="Memory / Storage")
dev.off()

taf.png("storage_memory_text")
specs$Percentage <- specs$RAM / (1000*specs$Storage)
plot(Percentage~Date, specs, pch=21, bg=bg, ylim=lim(Percentage),
     main="Memory tends to be around 2% of storage", ylab="Memory / Storage")
abline(h=0.02, lty=3)
text(specs$Date[1]+130, specs$Percentage[1]+0.004, "512 MB\nRAM", cex=0.9,
     col="darkgray")
text(specs$Date[1]+120, specs$Percentage[1]-0.004, "40 GB\nHDD", cex=0.9,
     col="darkgray")
text(specs$Date[n]-80, specs$Percentage[n]+0.004, "64 GB\nRAM", cex=0.9,
     col="darkgray")
text(specs$Date[n]-30, specs$Percentage[n]-0.004, "2 TB\nSSD", cex=0.9,
     col="darkgray")
dev.off()

# Format specs
specs <- specs[c("Date", "Laptop", "Model", "Cores", "Turbo", "RAM", "Storage")]
names(specs)[names(specs) == "Date"] <- "Year"
names(specs)[names(specs) == "Model"] <- "Processor"
names(specs)[names(specs) == "Turbo"] <- "Freq"
names(specs)[names(specs) == "RAM"] <- "Memory"
specs$Year <- as.integer(format(specs$Year, "%Y"))
specs$Freq <- format(round(specs$Freq / 1000, 1))
specs$Memory <- formatC(specs$Memory)
specs$Storage <- formatC(specs$Storage)

# Write to Markdown format
specs.md <- kable(specs, "pipe", align="lllrrrr")
writeLines(specs.md, "report/specs.md")

# Write tables
write.taf(specs, dir="report")
