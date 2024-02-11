require(gvlma)
library(psych)
library(glmulti)
library(MASS)
library(rsq)
library(ggplot2)
library(outliers)
library(ggpmisc)
library(car)
library(lmtest)
library(plotrix)
library(BBmisc)
#you may specify your own workspace
# Data input, note that this is only for region A case, the same for Bestfit_Data and Validation_Data
Regression_Data = read.csv("SG3000.csv",header=T)

#Scatterplot
pairs.panels(Regression_Data,
             method = "pearson", # correlation method
             hist.col = "#00AFBB",
             density = TRUE,  # show density plots
             ellipses = TRUE # show correlation ellipses
)

#these section is designed to find bestfit models based on lower AIC and higher R. 
#Please change the csv filename of Bestfit_Data to SB3000,SC3000,SD3000, SG3000 to run other cases
#Or you can check those resulting variables in CSV file.
Bestfit_Data = read.csv("SA3000.csv",header=T)

#Best-model selection using glmulti package
glmulti(Y1 ~ X1+X2, data=Bestfit_Data, level = 2, method = 'h', plotty = TRUE, crit = "aic")

#Best glmulti model: region C and region D
modg <- lm(Y1 ~ Glmulti, data=Bestfit_Data)
AIC(modg)
summary(modg)
#Prism regression model: linear
mod1 <- lm(Y1 ~ X1, data=Bestfit_Data)
AIC(mod1)
summary(mod1)
#Prism regression model: quadratic polynomial
mod2 <- lm(Y1 ~ poly, data=Bestfit_Data)
AIC(mod2)
summary(mod2)
#Prism regression model: power
mod3 <- lm(Y1 ~ power, data=Bestfit_Data)
AIC(mod3)
summary(mod3)
#Prism regression model: complex power, region A and region B
mod4 <- lm(Y1 ~ cp , data=Bestfit_Data)
AIC(mod4)
summary(mod4)

#Selected bestfit models
#Region A: Complex Power Y=0.2707X^1.124+9.074×10^(-12) X^4.248
Bestfit_Data = read.csv("SA3000.csv",header=T)
sel <- 0.2707*(Bestfit_Data$X1)^1.124+9.074*10^(-12)*(Bestfit_Data$X1)^4.248
mod <- lm(Y1 ~ sel, data=Bestfit_Data)
#Region B: Complex Power Y=5.32X^0.6046+2.788×10^(-6) X^2.744
Bestfit_Data = read.csv("SB3000.csv",header=T)
sel <- 5.32*(Bestfit_Data$X1)^0.6046+2.788*10^(-6)*(Bestfit_Data$X1)^2.744
mod <- lm(Y1 ~ sel, data=Bestfit_Data)
#Region C: Glmulti Y=86.67+3.972×10^(-4) X^2+7.364×10^(-8) X^3
Bestfit_Data = read.csv("SC3000.csv",header=T)
sel <- 86.67+3.972*10^(-4)*(Bestfit_Data$X1)^2+7.364*10^(-8)*(Bestfit_Data$X1)^3
mod <- lm(Y1 ~ sel, data=Bestfit_Data)
#Region D: Glmulti Y=83.39-0.2487X+4.334×10^(-4) X^2+2.941×10^(-7) X^3
Bestfit_Data = read.csv("SD3000.csv",header=T)
sel <- 83.39-0.2487*(Bestfit_Data$X1)+4.334*10^(-4)*(Bestfit_Data$X1)^2+2.941*10^(-7)*(Bestfit_Data$X1)^3
mod <- lm(Y1 ~ sel, data=Bestfit_Data)
#Region global: Complex Power Y=88.39+3.971×10^(-4) X+1.151×10^(-7) X^3
Bestfit_Data = read.csv("SG3000.csv",header=T)
sel <- 2.799*10^(-5)*(Bestfit_Data$X1)^2.407+37.62*(Bestfit_Data$X1)^0.1808
mod <- lm(Y1 ~ sel, data=Bestfit_Data)
#Regression AIC & R square
AIC(mod)
summary(mod)
#regression diagnostics
par(mfrow=c(2,2))
plot(mod)
dwtest(mod)

#Validation
#you may choose different filenames to check correlation results by region: SAV, SBV, SCV, SDV, SGV
Validation_Data = read.csv("SGV3000.csv",header=T)
cor(Validation_Data$Erosivity,Validation_Data$Model,method = c("pearson"))
#Taylor
taylor.diagram(Validation_Data$Erosivity,Validation_Data$Model,add=FALSE,col="red",pch=18,pos.cor=TRUE,
               xlab="",ylab="",main="Taylor Diagram of Region G",show.gamma=TRUE,ngamma=6,
               gamma.col=8,sd.arcs=4,ref.sd=TRUE,sd.method="sample",
               grad.corr.lines=c(0.2,0.4,0.6,0.8,0.9),
               pcex=1.5,cex.axis=1,normalize=TRUE,mar=c(5,4,6,6))
#Correlation between ENSO and Erosivity by momth
#you may manually select columns to check the resulting correlations
#Scatterplots were saved in folders named scatterplot erosivity _ElNino, scatterplot erosivity _LaNina, and Correlation plot erosivity_ENSO 
#you can input three csv files here named La Nina, El Nino, and ENSO_ori
ENSO = read.csv("La Nina.csv",header=T)
ENSO_norm = normalize(ENSO, method = "standardize", range = c(0, 1), margin = 1L, on.constant = "quiet")
#Jan    c(2,14,26,38,50,62,74)
#Feb    c(3,15,27,39,51,63,75)
#Mar    c(4,16,28,40,52,64,76)
#Apr    c(5,17,29,41,53,65,77)
#May    c(6,18,30,42,54,66,78)
#Jun    c(7,19,31,43,55,67,79)
#Jul    c(8,20,32,44,56,68,80)
#Aug    c(9,21,33,45,57,69,81)
#Sep    c(10,22,34,46,58,70,82)
#Oct    c(11,23,35,47,59,71,83)
#Nov    c(12,24,36,48,60,72,84)
#Dec    c(13,25,37,49,61,73,85)
pairs.panels(ENSO_norm[, c(13,25,37,49,61,73,85)],
             method = "pearson", # correlation method
             hist.col = "#00AFBB",
             density = TRUE,  # show density plots
             ellipses = TRUE # show correlation ellipses
)

#Boxplot of El Nino and La Nina seasons against rainfall erosivity 
Boxplot = read.csv("Boxplot.csv",header=T)
A1 <- Boxplot$A_El_Nino
A2 <- Boxplot$A_La_Nina
B1 <- Boxplot$B_EL_Nino
B2 <- Boxplot$B_La_Nina
B1 <- Boxplot$B_EL_Nino
B2 <- Boxplot$B_La_Nina
C1 <- Boxplot$C_El_Nino
C2 <- Boxplot$C_La_Nina
D1 <- Boxplot$D_El_Nino
D2 <- Boxplot$D_La_Nina
boxplot(A1, A2, B1, B2, C1, C2, D1, D2,
        main = "Multiple boxplots for comparision",
        names = c("A1", "A2", "B1", "B2","C1","C2","D1","D2"),
        las = 2,
        col = c("orange","red"),
        border = "brown",
        horizontal = TRUE,
        notch = FALSE
)
