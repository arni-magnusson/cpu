# Produce plots and tables for report

# Before: m4700.rds, p1gen8.rds, p15gen1.rds, p3560.rds (data)
# After:

library(TAF)
source("utilities.R")

mkdir("report")

# Read data
m4700 <- readRDS("model/m4700.rds")
p1gen8 <- readRDS("model/p1gen8.rds")
p15gen1 <- readRDS("model/p15gen1.rds")
p3560 <- readRDS("model/p3560.rds")


plot_machine <- function(machine, variable,
                         main=paste(deparse(substitute(machine)), variable),
                         xlab="Time", ylab="", pch=1, lwd=1.5,
                         col=c(8,1,4,5), type="p", ...)
{
  x <- lapply(machine, `[`, c("Time", variable))
  plot(NA, xlim=c(0,300), ylim=lim(x$single[[variable]]), xlab=xlab, ylab=ylab)
  mapply(points, x, col=col)
  legend("bottomleft", rev(names(machine)), pch=pch, pt.lwd=lwd, col=rev(col),
         bty="n", inset=0.02, y.intersp=1.25)
}
