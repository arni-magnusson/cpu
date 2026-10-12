means <- function(x, round=TRUE)
{
  freq <- sapply(x[grep("Freq", names(x))], mean)
  temp <- sapply(x[grep("Temp", names(x))], mean)
  fan <- sapply(x[grep("Fan", names(x))], mean)
  if(round)
  {
    freq <- round(freq, -2)
    temp <- round(temp)
    fan <- round(fan, -2)
  }
  c(freq, temp, fan)
}

plot_machine <- function(machine, variable,
                         main=paste(deparse(substitute(machine)), variable),
                         xlab="Iteration", ylab="", pch=1, lwd=1.5,
                         col=c(8,1,4,5), type="p", ...)
{
  # Prepare variable and variable1
  variable <- gsub("[0-9]", "", variable)  # Freq
  variable1 <- paste0(variable, "1")       # Freq1

  # Prepare plot elements
  k <- length(machine)
  col <- rep(col, length=k)
  xlim <- c(0, 300)
  ylim <- lim(unlist(lapply(machine, `[[`, variable1)))

  plot(NA, xlim=xlim, ylim=ylim, main=main, xlab=xlab, ylab=ylab, ...)
  for(i in 1:k)
    points(machine[[i]][[variable1]], pch=pch, lwd=lwd, col=col[i], type=type)
  legend("bottomleft", rev(names(machine)), pch=pch, pt.lwd=lwd, col=rev(col),
         bty="n", inset=0.02, y.intersp=1.25)
}

remove_first <- function(x, burn=0, length=300)
{
  x <- x[(1:length)+burn,]
  x$Time <- x$Time - min(x$Time)
  row.names(x) <- NULL
  x
}

summary_machine <- function(x, machine=deparse(substitute(x)))
{
  peak <- function(y)
  {
    c(freq=round(mean(y$Freq1), -2),
      temp=round(mean(y$Temp1)),
      fan=round(mean(y$Fan1), -2))
  }
  out <- sapply(x, peak)
  out <- xtab2taf(t(out), "load")
  out <- data.frame(machine=machine, out)
  out
}
