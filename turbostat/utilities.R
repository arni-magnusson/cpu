plot_machine <- function(machine, name, main=name, xlab="Iteration", ylab="",
                         pch=1, lwd=1.5, col=c(8,1,4,5), type="p", ...)
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
  out <- out[c("PkgTmp", "PkgWatt", "CorWatt", "SysWatt")]

  # Subset rows
  if(burn[1] > 0)
    out <- tail(out, -burn[1])  # remove first rows
  if(burn[2] > 0)
    out <- head(out, -burn[2])  # remove last rows
  if(is.numeric(n) && n > 0 && is.finite(n))  # return n rows
    out <- out[1:n,]

  out
}
