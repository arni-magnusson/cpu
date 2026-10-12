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

get.summary <- function(x, machine=deparse(substitute(x)))
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

remove.first <- function(x, n=0, max.time=300)
{
  if(n >= 1)
    x <- x[-seq_len(n),]
  x$Time <- x$Time - min(x$Time)
  x <- x[x$Time <= max.time,]
  row.names(x) <- NULL
  x
}
