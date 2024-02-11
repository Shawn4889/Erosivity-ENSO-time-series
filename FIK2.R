#Call required libires
require(gvlma)
library(psych)
library(xlsx)
library(car)
library(glmulti)
library(MASS)
library(rsq)
library(ggplot2)
#library(outliers)
library(PerformanceAnalytics)
________________________________________________________________________________________________________
#Import files
list.files()
A <- read.csv("A.csv",head=T)
B <- read.csv("B.csv",head=T)
C <- read.csv("C.csv",head=T)
D <- read.csv("D.csv",head=T)
________________________________________________________________________________________________________
#correlate the Variables

corA<- cor(A$Y,A$X)
corB<- cor(B$Y,B$X)
corC<- cor(C$Y,C$X)
corD<- cor(D$Y,D$X)
plot(A$Y,A$X)
pairs.panels(A,
             method = "pearson", # correlation method
             hist.col = "#00AFBB",
             density = TRUE,  # show density plots
             ellipses = TRUE # show correlation ellipses
)

pairs.panels(B,
             method = "pearson", # correlation method
             hist.col = "#00AFBB",
             density = TRUE,  # show density plots
             ellipses = TRUE # show correlation ellipses
)
pairs.panels(C,
             method = "pearson", # correlation method
             hist.col = "#00AFBB",
             density = TRUE,  # show density plots
             ellipses = TRUE # show correlation ellipses
)
pairs.panels(D,
             method = "pearson", # correlation method
             hist.col = "#00AFBB",
             density = TRUE,  # show density plots
             ellipses = TRUE # show correlation ellipses
)
________________________________________________________________________________________________________
#simple linear Regression
A1 <- lm(A$Y~A$X)
B1 <- lm(B$Y~B$X)
C1 <- lm(C$Y~C$X)
D1 <- lm(D$Y~D$X)
summary(A1)
________________________________________________________________________________________________________

library(gvlma)
library(c("glmulti","car","gvlma"))
reg<-read.csv("E:\\FIK\\Data1\\Combined_matrix.csv", header=T)
reg<-data.frame(reg)
chart.Correlation(reg[,-1], histogram=TRUE, pch=15) #make a correlation matrix (Diagnostic procedure)
chart.Correlation(Ero1,Pre1)
pairs.panels(reg,
             method = "pearson", # correlation method
             hist.col = "#00AFBB",
             density = TRUE,  # show density plots
             ellipses = TRUE # show correlation ellipses
)
_______________________________________________________________________________________________________

# Global validation of Linear assumption
gvmodel<- gvlma(regression_fit)
summary(gvmodel)
______________________________________________________________________________________________________

library("MuMIn")
options(na.action = "na.fail")
fm1 <- lm(Erosivity ~ Rainfall, data = df)
dd <- dredge(fm1)
plot(dd, labAsExpr = TRUE)
dredge(fm1, beta = c("none", "sd", "partial.sd"), evaluate = TRUE,
       rank = "AICc")
____________________________________________________________________________________________________


regression_fit3<-lm(Mortgage ~ Income + sqrt(Squarefoot) + Is_15year, data=Data)
iteratemodel <- glmulti(Mortgage ~ Income*sqrt(Squarefoot)*Is_15year, data = reg1, 
                        level = 2, method = 'h', plotty = TRUE, crit = "aicc")
data(Cement)
fm1 <- lm(y ~ ., data = Cement)
ms1 <- dredge(fm1)
plot(ms1)
model.avg(ms1, subset = delta < 4)
confset.95p <- get.models(ms1, cumsum(weight) <= .95)
avgmod.95p <- model.avg(confset.95p)
summary(avgmod.95p)
confint(avgmod.95p)