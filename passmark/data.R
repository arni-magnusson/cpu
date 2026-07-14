# Prepare data, write CSV data tables

# Before: i7_high.dat, i7_low.dat, i7_medium.dat, r7_high.dat,
#         r7_low.dat (boot/data)
# After:  i7_high.csv, i7_low.csv, i7_medium.csv, r7_high.csv, r7_low.csv (data)

library(TAF)

mkdir("data")

# Read initial data
i7_high <- read.table("boot/data/i7_high.dat", header=TRUE, fill=TRUE)
i7_medium <- read.table("boot/data/i7_medium.dat", header=TRUE, fill=TRUE)
i7_low <- read.table("boot/data/i7_low.dat", header=TRUE, fill=TRUE)
r7_high <- read.table("boot/data/r7_high.dat", header=TRUE, fill=TRUE)
r7_low <- read.table("boot/data/r7_low.dat", header=TRUE, fill=TRUE)

# Remove column
i7_high$Laptop <- NULL
i7_medium$Laptop <- NULL
i7_low$Laptop <- NULL
r7_high$Laptop <- NULL
r7_low$Laptop <- NULL

# Rename column
names(i7_high)[names(i7_high) == "Single"] <- "Speed"
names(i7_medium)[names(i7_medium) == "Single"] <- "Speed"
names(i7_low)[names(i7_low) == "Single"] <- "Speed"
names(r7_high)[names(r7_high) == "Single"] <- "Speed"
names(r7_low)[names(r7_low) == "Single"] <- "Speed"

# Save tables
write.taf(i7_high, dir="data")
write.taf(i7_medium, dir="data")
write.taf(i7_low, dir="data")
write.taf(r7_high, dir="data")
write.taf(r7_low, dir="data")
