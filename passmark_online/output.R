# Extract results of interest, write CSV output tables

# Before: companies_fit.csv, companies_intercept.csv, i7_high.csv, i7_low.csv,
#         i7_medium.csv, r7_high.csv, r7_low.csv (model)
# After:  companies_fit.csv, companies_intercept.csv, i7_high.csv, i7_low.csv,
#         i7_medium.csv, r7_high.csv, r7_low.csv (output)

library(TAF)

mkdir("output")

cp("model/*.csv", "output")
