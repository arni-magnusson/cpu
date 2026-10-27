# Prepare data, write CSV data tables

# Before: apple.dat, i7_high.dat, i7_low.dat, i7_medium.dat, prehistory.dat,
#         r7_high.dat, r7_low.dat (boot/data)
# After:  apple.csv, companies.csv, history.csv, i7_high.csv, i7_low.csv,
#         i7_medium.csv, r7_high.csv, r7_low.csv (data)

library(TAF)

mkdir("data")

# Read initial data
apple <- read.table("boot/data/apple.dat", header=TRUE, fill=TRUE)
i7_high <- read.table("boot/data/i7_high.dat", header=TRUE, fill=TRUE)
i7_medium <- read.table("boot/data/i7_medium.dat", header=TRUE, fill=TRUE)
i7_low <- read.table("boot/data/i7_low.dat", header=TRUE, fill=TRUE)
prehistory <- read.table("boot/data/prehistory.dat", header=TRUE, fill=TRUE)
r7_high <- read.table("boot/data/r7_high.dat", header=TRUE, fill=TRUE)
r7_low <- read.table("boot/data/r7_low.dat", header=TRUE, fill=TRUE)

# Remove column
apple$Laptop <- NULL
i7_high$Laptop <- NULL
i7_medium$Laptop <- NULL
i7_low$Laptop <- NULL
prehistory$Laptop <- NULL
r7_high$Laptop <- NULL
r7_low$Laptop <- NULL

# Rename column
names(apple)[names(apple) == "Single"] <- "Speed"
names(i7_high)[names(i7_high) == "Single"] <- "Speed"
names(i7_medium)[names(i7_medium) == "Single"] <- "Speed"
names(i7_low)[names(i7_low) == "Single"] <- "Speed"
names(prehistory)[names(prehistory) == "Single"] <- "Speed"
names(r7_high)[names(r7_high) == "Single"] <- "Speed"
names(r7_low)[names(r7_low) == "Single"] <- "Speed"

# Replace outlier with prediction
basis <- apple[-grep("M3", apple$Model),]
air <- basis$Speed[grep("[0-9]$", basis$Model)]
pro <- basis$Speed[grep("Pro", basis$Model)]
# Relationship between Air and Pro tends to be around 97%
pred <- round(apple$Speed[apple$Model == "M3-Pro"] * mean(air) / mean(pro))
apple$Speed[apple$Model == "M3"] <- pred

# Combine companies for analysis
pro <- apple[grep("Pro", apple$Model),]
pro$Company <- "Apple"
intel <- transform(i7_high, Company="Intel")
amd <- transform(r7_high, Company="AMD")
companies <- rbind(pro, intel, amd)

# Combine Intel history
history <- rbind(prehistory, i7_high[-1,])

# Save tables
write.taf(apple, dir="data")
write.taf(companies, dir="data")
write.taf(history, dir="data")
write.taf(i7_high, dir="data")
write.taf(i7_medium, dir="data")
write.taf(i7_low, dir="data")
write.taf(r7_high, dir="data")
write.taf(r7_low, dir="data")
