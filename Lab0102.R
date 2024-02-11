require(gvlma)
library(psych)
library(xlsx)
library(car)
library(glmulti)
library(MASS)
library(rsq)
library(ggplot2)
library(outliers)
#Plot frame and data import
par(mfrow=c(2,2))
Data<-read.csv("E:\\temp\\NewIdea\\Quantitative Method\\lab\\Lab01.csv", sep=",", header=T)
#Scatterplot of original
pairs.panels(Data,
             method = "pearson", # correlation method
             hist.col = "#00AFBB",
             density = TRUE,  # show density plots
             ellipses = TRUE # show correlation ellipses
)

#First scenario: original model
mod1 <- lm(Y ~ X1+X2+X3+A, data=Data)
#Test of assumptions: Homoscedasticity(1), Normality(2), Non-Linearity(3,4)   
plot(mod1)
#Summary
summary (mod1)

#Test original model's regression assumptions of homoscedasticity, linearity and normality
m1 <- lm(Data$Y ~ Data$X1)
m2 <- lm(Data$Y ~ Data$X2) 
m3 <- lm(Data$Y ~ Data$X3) 
m4 <- lm(Data$Y ~ Data$A) 
qqPlot(m1)
qqPlot(m2)
qqPlot(m3)
qqPlot(m4)
shapiro.test(m1$residuals)
shapiro.test(m2$residuals)
shapiro.test(m3$residuals)
shapiro.test(m4$residuals)

#Original dataset outliers detection
cut <- 4/((nrow(Data)-length(mod1$coefficients))) 
plot(mod1, which=4, cook.levels=cut)
scores(Data$Y, type="chisq", prob=0.9)

#Second scenario: best model selection
#Reomove outliers
vars <- c("X2")
Data2 <- Data
Data2 <- Data2[-c(6, 28, 43, 45), ]
#Variable X2 transformation
Data2[vars] <- lapply(Data2[vars], sqrt)
pairs.panels(Data2,
             method = "pearson", # correlation method
             hist.col = "#00AFBB",
             density = TRUE,  # show density plots
             ellipses = TRUE # show correlation ellipses
)

#Stepwise process to list all possible models
glmulti(Y ~ X1+X2+X3, data=Data2, level = 2, method = 'h', plotty = TRUE, crit = "aicc")
#The best-fit model: 
mod2 <- glm(Y ~ X1  +   X2  +    X3   +    X1:X2   +     X2:X3, data=Data2)
#Check adjust-R value of best-fit model
rsq(mod2, adj=TRUE)
#Additional dummy variables evaluation using ANOVA
Anova(mod2, test.statistic="F")
#Test the best-fit model's regression assumptions of homoscedasticity, linearity and normality
plot(mod2)
qqPlot(mod2$residuals)

#Error term against variables 
plot(Data2$Y ~ mod2$residuals)
plot(Data2$X1 ~ mod2$residuals)
plot(Data2$X2 ~ mod2$residuals)
plot(Data2$X3 ~ mod2$residuals)
plot(Data2$A ~ mod2$residuals)
plot(Data2$X1*Data2$X2 ~ mod2$residuals)
plot(Data2$X2*Data2$X3 ~ mod2$residuals)

#Predict observation 25 using the best-fit model
pred <- predict(mod2, se.fit = TRUE)
fit <- pred$fit
se <- pred$se.fit
lower <- fit - 1.96*pred$se.fit
upper <- fit + 1.96*pred$se.fit
fit[24]
lower[24]
upper[24]

#Visualize observations, best-fit predictions and confidence intervals at 0.95 level
ggplot(Data2, aes(Data2$Index, y = Data2$Y))+
    geom_line(aes(y = Data2$Y, colours="b"), data = Data2, color = "blue", size=1)+
    geom_line(aes(y = mod2$fitted.values, colours="c"), 
              data = data.frame(mod2$fitted.values), color = "red", size=1)+
    geom_ribbon(data=Data2,aes(ymin=lower,ymax=upper),alpha=0.3)
#Examine the relationship between predicted values and observations
lm <- lm(mod2$fitted.values~Data2$Y)
summary(lm)
cor(mod2$fitted.values, Data2$Y, method = c("pearson", "kendall", "spearman"))
# The second best model
mod3 <- glm(Y ~ X1  +   X2    +    X1:X2  +    X1:X3, data=Data2)
