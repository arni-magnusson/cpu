# Plot improvement
implot <- function(x, xlim=c(0,52), plt=c(0.3,0.9,0.2,0.9))
{
  par(plt=plt)
  labels <- paste0(x$Model[-1], " (", format(x$Date[-1], "%Y"), ")")
  barplot(100*x$Improve[-1], names=labels, horiz=TRUE, las=1,
          xlim=xlim, xlab="Relative speed improvement (%)")
}
