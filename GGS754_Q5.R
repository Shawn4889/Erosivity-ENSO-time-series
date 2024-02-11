library(spectral)
library(WaveletComp)
data <- read.table("E:/temp/9292019/GGS754/5/GGS754_HW5_Package/sstoi.indices_old.txt", header = TRUE, sep = "")
SST <- data[1:720,10]
X.k <- fft(SST)
freq <- 735

plot.frequency.spectrum <- function(X.k, xlimits=c(0,length(X.k))) {
    plot.data  <- cbind(0:(length(X.k)-1), Mod(X.k))
    
    # TODO: why this scaling is necessary?
    plot.data[2:length(X.k),2] <- 2*plot.data[2:length(X.k),2] 
    
    plot(plot.data, t="h", lwd=2, main="", 
         xlab="Frequency (Hz)", ylab="Spectrum", 
         xlim=xlimits, ylim=c(0,max(Mod(plot.data[,2]))))
}


plot.frequency.spectrum(X.k,xlimits=c(0,freq/2))



my.date <- seq(as.POSIXct("1950-1-1 00:00:00", format = "%F %T"), 
               by = "month", 
               length.out = 720)     
my.data <- data.frame(date = my.date, x = SST)

my.wt = analyze.wavelet(my.data, "x", 
                        loess.span=0, 
                        dt=1/24, dj=1/20, 
                        lowerPeriod=1/4, 
                        make.pval=T, n.sim=10)
wt.image(my.wt, color.key="interval", legend.params=list(lab="wavelet power levels"))
wt.avg(my.wt, siglvl=0.05, sigcol="red")
