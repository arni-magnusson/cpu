outliers <- function(x, level=0.5, plot=FALSE, ...)
{
  # Fit loess model
  iter <- 1:length(x)
  trend <- loess(x~iter, ...)$fitted

  # Calculate distance
  dist <- abs(log(x) - log(trend))

  # Identify outliers
  index <- which(dist > level)
  values <- x[index]
  expected <- trend[index]

  # Repair outliers
  repaired <- replace(x, index, expected)

  # Plot
  if(plot)
  {
    plot(x, ylim=lim(x))
    lines(trend, lwd=2)
    points(index, values, pch=4, cex=1.5, lwd=3, col=2)
    points(index, expected, pch=16, cex=1.5, col=3)
  }

  out <- list(trend=trend, repaired=repaired, index=index, values=values,
              expected=expected)
  out
}

plot_machine <- function(machine, name,
                         main=paste(deparse(substitute(machine)), name),
                         xlab="Iteration", ylab="", pch=1, lwd=1.5,
                         col=c(8,1,4,5), type="p", ...)
{
  # Prepare plot elements
  k <- length(machine)
  col <- rep(col, length=k)
  xlim <- c(0, max(sapply(p1gen8, nrow)))
  ylim <- lim(unlist(lapply(machine, `[[`, name)))

  # Plot
  plot(NA, xlim=xlim, ylim=ylim, main=main, xlab=xlab, ylab=ylab, ...)
  for(i in 1:k)
    points(machine[[i]][[name]], pch=pch, lwd=lwd, col=col[i], type=type)
  legend("topright", rev(names(machine)), pch=pch, pt.lwd=lwd, col=rev(col),
         bty="n", inset=0.02, y.intersp=1.25)
}

read_turbostat <- function(file, n=300, burn=0)
{
  # Parse args
  burn <- rep(burn, length=2)  # first and last rows to remove

  # Read file
  txt <- readLines(file)
  beg <- grep("^Avg_MHz", txt)
  out <- read.table(text=txt, header=TRUE, skip=beg-1)

  # Subset cols
  out <- out[c("PkgTmp", "PkgWatt", "CorWatt")]

  # Subset rows
  if(burn[1] > 0)
    out <- tail(out, -burn[1])  # remove first rows
  if(burn[2] > 0)
    out <- head(out, -burn[2])  # remove last rows
  if(is.numeric(n) && n > 0 && is.finite(n))  # return n rows
    out <- out[1:n,]

  out
}
