require(gvlma)
library(psych)
library(xlsx)
library(car)
library(glmulti)
library(MASS)
library(rsq)
library(ggplot2)
library(outliers)
library(ggpmisc)
#Plot frame and data import
par(mfrow=c(1,1))
Data1<-read.csv("E:\\temp\\NewIdea\\FIKData\\data\\Result_SIndividual\\Result_Tables\\Result_Subset\\A.csv", sep=",", header=T)
Data2<-read.csv("E:\\temp\\NewIdea\\FIKData\\data\\Result_SIndividual\\Result_Tables\\Result_Subset\\B.csv", sep=",", header=T)
Data3<-read.csv("E:\\temp\\NewIdea\\FIKData\\data\\Result_SIndividual\\Result_Tables\\Result_Subset\\C.csv", sep=",", header=T)
Data4<-read.csv("E:\\temp\\NewIdea\\FIKData\\data\\Result_SIndividual\\Result_Tables\\Result_Subset\\D.csv", sep=",", header=T)
df1 <- Data1[c("Y","X")]
df2 <- Data2[c("Y","X")]
df3 <- Data3[c("Y","X")]
df4 <- Data4[c("Y","X")]
m1 <- lm(df1$Y ~ df1$X)
m2 <- lm(df2$Y ~ df2$X)
m3 <- lm(df3$Y ~ df3$X)
m4 <- lm(df4$Y ~ df4$X)
plot(m1)
plot(m2)
plot(m3)
plot(m4)
summary(m1)
summary(m2)
summary(m3)
summary(m4)

pairs.panels(df4,
             method = "pearson", # correlation method
             hist.col = "#00AFBB",
             density = TRUE,  # show density plots
             ellipses = TRUE # show correlation ellipses
)

G<-c()
G < rbind(G,(df1$X)^2)

DataG<-read.csv("E:\\temp\\NewIdea\\FIKData\\data\\Result_SIndividual\\Result_Tables\\Result_Subset_Remove_Glmulti\\C.csv", sep=",", header=T)

glmulti(Y ~ X+X_2+X_3, data=DataG, level = 2, method = 'h', plotty = TRUE, crit = "aic")



#Best-fit Model selection 
#A
DataG<-read.csv("E:\\temp\\NewIdea\\FIKData\\data\\Result_SIndividual\\Result_Tables\\Result_Subset_Remove_Glmulti\\A.csv", sep=",", header=T)
Result1 <- 0.118*(DataG$X)^1.454 
m1 <- lm(DataG$Y ~ Result1)
summary(m1)
Result2 <- 25.63*(DataG$X)^0.07696+26.05*(DataG$X)^0.6672
m2 <- lm(DataG$Y ~ Result2)
summary(m2)
AIC(m1,m2)
m3 <- glm(Y ~ X  +   X_2    + X_3 +    X:X_3    + X_2:X_3  , data=DataG)
rsq(m3, adj=TRUE)
summary(m3)
m3[1]




equation = function(x) {
    lm_coef <- list(a = round(coef(x)[1], digits = 2),
                    b = round(coef(x)[2], digits = 2),
                    r2 = round(summary(x)$r.squared, digits = 2));
    lm_eq <- substitute(italic(y) == a + b %.% italic(x)*","~~italic(R)^2~"="~r2,lm_coef)
    as.character(as.expression(lm_eq));                 
}

#plot linear model
ggplot(DataG, aes(x = DataG$Y, y = DataG$Y_model))+
    geom_point()+
    geom_smooth(method=lm, se=FALSE, colour = "black")+
    xlab("DWF (%)") + ylab("CERA SSH (%)")+ theme_bw()+
    theme(text=element_text(family="A"))+
    theme(axis.line = element_line(colour = "black"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank(),
          panel.background = element_blank(), 
          axis.line.x = element_line(), 
          axis.line.y = element_line())







#B
DataG<-read.csv("E:\\temp\\NewIdea\\FIKData\\data\\Result_SIndividual\\Result_Tables\\Result_Subset_Remove_Glmulti\\B.csv", sep=",", header=T)
Result1 <- 0.1735*(DataG$X)^1.408
m1 <- lm(DataG$Y ~ Result1)
summary(m1)
Result2 <- -14.08*(DataG$X)^0.6289+2.755*(DataG$X)^1.048
m2 <- lm(DataG$Y ~ Result2)
summary(m2)
AIC(m1,m2)

#C
DataG<-read.csv("E:\\temp\\NewIdea\\FIKData\\data\\Result_SIndividual\\Result_Tables\\Result_Subset_Remove_Glmulti\\A.csv", sep=",", header=T)
Result1 <- 0.1481*(DataG$X)^1.409
m1 <- lm(DataG$Y ~ Result1)
summary(m1)
Result2 <- -25.96*(DataG$X)^0.3593+0.6559*(DataG$X)^1.214
m2 <- lm(DataG$Y ~ Result2)
summary(m2)
AIC(m1,m2)

#D
DataG<-read.csv("E:\\temp\\NewIdea\\FIKData\\data\\Result_SIndividual\\Result_Tables\\Result_Subset_Remove_Glmulti\\A.csv", sep=",", header=T)
Result1 <- 0.118*(DataG$X)^1.432 
m1 <- lm(DataG$Y ~ Result1)
summary(m1)
Result2 <- -5.794*(DataG$X)^0.7876+1.366*(DataG$X)^1.139
m2 <- lm(DataG$Y ~ Result2)
summary(m2)
Result3 <- 0.097*(DataG$X)^1.464 
m3 <- lm(DataG$Y ~ Result3)
summary(m3)
AIC(m1,m2,m3)
#E
DataE<-read.csv("E:\\temp\\NewIdea\\FIKData\\data\\Result_SIndividual\\Result_Tables\\Result_Subset_Remove_Glmulti\\Combine_Subset.csv", sep=",", header=T)
ME <- glm(Y~1+X2:X+X3:X+X3:X2+A:X+A:X2+A:X3+C:X+C:X2+C:X3+C:A+C:B+D:X+D:X2+D:X3,data=DataE)
rsq(ME, adj=TRUE)
summary(ME)
ResultB <- -13.32*(DataE$X)^0.4986+0.6615*(DataE$X)^1.128
ME2 <- lm(DataE$Y ~ ResultB)
cor(DataE$Y,ME2$fitted.values,method = c("pearson"))
summary(ME2)


#Correlation with validation 30% data
#A
DataA<-read.csv("E:\\temp\\NewIdea\\FIKData\\data\\Result_SIndividual\\Result_Tables\\Data1V\\Validation\\A.csv", sep=",", header=T)
MA <- glm(Y ~ X + X_2 + X_3 + X:X_3 + X_2:X_3, data=DataA)
rsq(MA, adj=TRUE)
cor(DataA$Y,MA$fitted.values,method = c("pearson"))
summary(MA)
plot(DataA$Y,MA$fitted.values)
MA[[1]]





#B
DataB<-read.csv("E:\\temp\\NewIdea\\FIKData\\data\\Result_SIndividual\\Result_Tables\\Data1V\\Validation\\B.csv", sep=",", header=T)
ResultB <- -14.08*(DataB$X)^0.6289+2.755*(DataB$X)^1.048
MB <- lm(DataB$Y ~ ResultB)
cor(DataB$Y,MB$fitted.values,method = c("pearson"))
summary(MB)
#C
DataC<-read.csv("E:\\temp\\NewIdea\\FIKData\\data\\Result_SIndividual\\Result_Tables\\Data1V\\Validation\\C.csv", sep=",", header=T)
ResultC <- -25.96*(DataCV$X)^0.3593+0.6559*(DataCV$X)^1.214
MC <- lm(DataCV$Y ~ ResultC)
cor(DataC$Y,MC$fitted.values,method = c("pearson"))
#D
DataD<-read.csv("E:\\temp\\NewIdea\\FIKData\\data\\Result_SIndividual\\Result_Tables\\Data1V\\Validation\\D.csv", sep=",", header=T)
ResultD <- -5.794*(DataD$X)^0.7876+1.366*(DataD$X)^1.139
MD <- lm(DataD$Y ~ ResultD)
cor(DataD$Y,MD$fitted.values,method = c("pearson"))
#E
DataE<-read.csv("E:\\temp\\NewIdea\\FIKData\\data\\Result_SIndividual\\Result_Tables\\Data1V\\Validation\\Combine_Subset.csv", sep=",", header=T)
ResultB <- -13.32*(DataE$X)^0.4986+0.6615*(DataE$X)^1.128
ME <- lm(DataE$Y ~ ResultB)
cor(DataE$Y,ME$fitted.values,method = c("pearson"))

#TEST
DataA<-read.csv("E:\\temp\\NewIdea\\FIKData\\data\\Result_SIndividual\\Result_Tables\\Validation\\A.csv", sep=",", header=T)
DataB<-read.csv("E:\\temp\\NewIdea\\FIKData\\data\\Result_SIndividual\\Result_Tables\\Validation\\B.csv", sep=",", header=T)
DataC<-read.csv("E:\\temp\\NewIdea\\FIKData\\data\\Result_SIndividual\\Result_Tables\\Validation\\C.csv", sep=",", header=T)
DataD<-read.csv("E:\\temp\\NewIdea\\FIKData\\data\\Result_SIndividual\\Result_Tables\\Validation\\D.csv", sep=",", header=T)
DataE<-read.csv("E:\\temp\\NewIdea\\FIKData\\data\\Result_SIndividual\\Result_Tables\\Validation\\Combine_Subset.csv", sep=",", header=T)
cor(DataA$Y,DataA$Y_model,method = c("pearson"))
cor(DataB$Y,DataB$Y_model,method = c("pearson"))
cor(DataC$Y,DataC$Y_model,method = c("pearson"))
cor(DataD$Y,DataD$Y_model,method = c("pearson"))
cor(DataE$Y,DataE$Y_model,method = c("pearson"))


#ENSO
Data<-read.csv("E:\\temp\\NewIdea\\FIKData\\data\\Result_SIndividual\\Result_Tables\\ENSO_AS\\Combine.csv", sep=",", header=T)
p5 <- ggplot(Data, aes(x = Data$YEAR, y = Data$M1, group = 1))+
    geom_line(aes(y = Data5$L3, colour="Ch3L"), size = 1)+
    geom_line(aes(y = Data5$L4, colour="Ch4L"), size = 1)+
    geom_line(aes(y = Data5$L16, colour="Ch16L"), size = 1)+
    theme(text=element_text(family="A"))+
    labs(x="9/3/2017 Feature Sample Index", y="BT (K)", 
         color  = "Legend", linetype = "Legend", shape = "Legend")
#Normalize
par(mfrow=c(3,4))
Data<-read.csv("E:\\temp\\NewIdea\\FIKData\\data\\Result_SIndividual\\Result_Tables\\ENSO_AS\\Combine.csv", sep=",", header=T)
D1 <- Data[c("M1","H1","O1","A1","B1","C1","D1")]
D2 <- Data[c("M2","H2","O2","A2","B2","C2","D2")]
D3 <- Data[c("M3","H3","O3","A3","B3","C3","D3")]
D4 <- Data[c("M4","H4","O4","A4","B4","C4","D4")]
D5 <- Data[c("M5","H5","O5","A5","B5","C5","D5")]
D6 <- Data[c("M6","H6","O6","A6","B6","C6","D6")]
D7 <- Data[c("M7","H7","O7","A7","B7","C7","D7")]
D8 <- Data[c("M8","H8","O8","A8","B8","C8","D8")]
D9 <- Data[c("M9","H9","O9","A9","B9","C9","D9")]
D10 <- Data[c("M10","H10","O10","A10","B10","C10","D10")]
D11 <- Data[c("M11","H11","O11","A11","B11","C11","D11")]
D12 <- Data[c("M12","H12","O12","A12","B12","C12","D12")]
boxplot(D1,xlab="January")
boxplot(D2,xlab="February")
boxplot(D3,xlab="March")
boxplot(D4,xlab="April")
boxplot(D5,xlab="May")
boxplot(D6,xlab="June")
boxplot(D7,xlab="July")
boxplot(D8,xlab="August")
boxplot(D9,xlab="September")
boxplot(D10,xlab="October")
boxplot(D11,xlab="November")
boxplot(D12,xlab="December")


pairs.panels(D12,
             method = "pearson", # correlation method
             hist.col = "#00AFBB",
             density = TRUE,  # show density plots
             ellipses = TRUE # show correlation ellipses
             
)
MC <- lm(Data$M10~Data$A10)
cor(Data$M10,Data$A10,method = c("pearson"))

