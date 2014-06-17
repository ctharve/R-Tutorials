## GGPlot2 examples
setwd('/your/working/directory/')

## 1.) let's import and plot these three series 
my.dat <- read.table('tss.txt', header=TRUE, sep='\t')

## 2.) plot these data using base plot
plot(my.dat[, 1], my.dat[, 2], log='x', ylim=c(23000, 27000))
points(my.dat[, 1], my.dat[, 3], col='red')
points(my.dat[, 1], my.dat[, 4], col='blue')

## what would this look like in ggplot2?
require('ggplot2')

## 3.) casting data from wide to long 
## Think for a moment about how to make this data set 'long'.
## Rather than a row of data with a data point for each measure 
## noEffect, upBinding, and downBinding.... lets flatten all of
## that data into one long vector and add a variable to indicate
## noEffect, upBinding, and downBinding.

## Identifiers: make a vector of identifiers for each column of data
## GOTCHA'S ggplot2 uses factors, so....
n.obs <- dim(my.dat)[1]
effect <- as.factor(c(rep('noEffect', n.obs), rep('upBinding', n.obs), rep('downBinding', n.obs)))

## Y values: now concatonate the data into one long vector
distTSS <- c(my.dat$noEffect, my.dat$upBinding, my.dat$downBinding)

## X values: now repeat the original vecotr of x values three times, so the above data
## has corresponding x values
bins <- rep(my.dat[, 1], 3)

## combine the x.vals, y.vals, and identifiers into 1 long data set!
## GOTCHA'S ggplot2 acts on data.frames 
long.dat <- data.frame(bins, distTSS, effect)

## compare the two, does everything match up?
long.dat; my.dat

## there are faster ways to 'melt' this data set from wide to long, using packages such as plyr, 
## but it is good to learn how to do things without packages

## 4.) let's ggplot
## open a new window so we can compare the new and old plots
quartz()	
## make a plotting object
my.plot <- ggplot(long.dat, aes(x=log10(bins), y=distTSS))
## make a simple dot plot
my.plot + geom_point(aes(colour=effect)) + ggtitle('TSSsites & stuff')
## perhaps a line plot?
my.plot + geom_line(aes(colour=effect)) + ggtitle('TSSsites & stuff')
## three different plots rather than three lines on one plot
my.plot + geom_point(aes(colour=effect)) + ggtitle('TSSsites & stuff') + facet_grid( effect ~.)
my.plot + geom_line(aes(colour=effect)) + ggtitle('TSSsites & stuff') + facet_grid( effect ~.)
