

# Replicates results from "Physiological Arousal and Political Beliefs"
# Published in Political Psychology
# Authors: Jonathan Renshon, Julia Lee & Dustin Tingley

# Note: most figures and tables are created with accompanying Stata .do file



# Figure 3
# Causal Mediation Plot

# Load Data
anxiety<-read.csv("midterm_dataverse_files/anxiety.csv") 

## Make Subsets (do this last)
noRelaxCond <- subset(anxiety, anxcond3>0)

#Outcome Model
y <- zelig(immigration ~ anxcond + SCDBradSelfReport1_mean+storycond, model="ls", data= noRelaxCond)
summary(y) # summarize results from model

#Mediator Model
m<-zelig(SCDBradSelfReport1_mean ~ anxcond+storycond, model="ls", data= noRelaxCond)
summary(m) # summarize results from model

# Mediation Analysis
m.out<-mediate(m,y, sims=500, treat="anxcond", mediator="SCDBradSelfReport1_mean", dropobs=TRUE, boot=TRUE, conf.level=.90)
summary(m.out)
plot(m.out, labels=c("ACME\n(Physiological \nReactivity)", "Direct Effect \n(Anxiety)", "Total Effect"))








# Appendix E
# Figure 5
# Manipulation Check for Anxiety Stimulus (mTurk Study)

library(mediation)
library(memisc)
library(Zelig)
library(gplots)

mturk<-read.csv("midterm_dataverse_files/mTurk.csv") 
vidcond<-factor(x=mturk$anxcond3, labels=c("Relax", "Neutral", "Cliffhanger"))
mturk<-cbind(mturk, vidcond)

# Anxiety
plot( 0 , type = "n" , bty = "n" , xlab = "Video Condition" , ylab = "Self-reported Anxiety" , main = "(a)" , xlim = c(.75,3.25) , ylim = c(0,5), axes=TRUE, xaxt='n' )
polygon(x=c(-100,100,100,-100),y=c(-100,-100,100,100),col="gray80")
abline(v=seq(0,5,.25),col="gray95",lwd=.5)
abline(h=seq(0,5,.25),col="gray95",lwd=.5)
abline(h=seq(0,5,.5),col="gray95",lwd=2)
plotmeans(anxious_video ~ vidcond, data=mturk,connect=FALSE, n.label=TRUE, xlab="Video Condition", ylab="",barwidth=6,ylim=c(-1,2), add=TRUE)  
box()

# Anxiety Plus (Anxiety/Worry/Angry)
plot( 0 , type = "n" , bty = "n" , xlab = "Video Condition" , ylab = "Self-reported \nAnxiety/Worry/Angry" , main = "(b)" , xlim = c(.75,3.25) , ylim = c(0,5), axes=TRUE, xaxt='n' )
polygon(x=c(-100,100,100,-100),y=c(-100,-100,100,100),col="gray80")
abline(v=seq(0,5,.25),col="gray95",lwd=.5)
abline(h=seq(0,5,.25),col="gray95",lwd=.5)
abline(h=seq(0,5,.5),col="gray95",lwd=2)
plotmeans(anxiousplus_video ~ vidcond, data=mturk,connect=FALSE, n.label=TRUE, xlab="Video Condition", ylab="",barwidth=6,ylim=c(-1,2), add=TRUE)  
box()

# Hope
plot( 0 , type = "n" , bty = "n" , xlab = "Video Condition" , ylab = "Self-reported Hope" , main = "(c)" , xlim = c(.75,3.25) , ylim = c(0,5), axes=TRUE, xaxt='n' )
polygon(x=c(-100,100,100,-100),y=c(-100,-100,100,100),col="gray80")
abline(v=seq(0,5,.25),col="gray95",lwd=.5)
abline(h=seq(0,5,.25),col="gray95",lwd=.5)
abline(h=seq(0,5,.5),col="gray95",lwd=2)
plotmeans(hopeful ~ vidcond, data=mturk,connect=FALSE, n.label=TRUE, xlab="Video Condition", ylab="",barwidth=6,ylim=c(-1,2), add=TRUE)  
box()

# Pride
plot( 0 , type = "n" , bty = "n" , xlab = "Video Condition" , ylab = "Self-reported Pride" , main = "(d)" , xlim = c(.75,3.25) , ylim = c(0,5), axes=TRUE, xaxt='n' )
polygon(x=c(-100,100,100,-100),y=c(-100,-100,100,100),col="gray80")
abline(v=seq(0,5,.25),col="gray95",lwd=.5)
abline(h=seq(0,5,.25),col="gray95",lwd=.5)
abline(h=seq(0,5,.5),col="gray95",lwd=2)
plotmeans(proud ~ vidcond, data=mturk,connect=FALSE, n.label=TRUE, xlab="Video Condition", ylab="",barwidth=6,ylim=c(-1,2), add=TRUE)  
box()


# Appendix I
# Figure 6
# Mediation Results with Controls

# Make Subsets (do this last)
noRelaxCond <- subset(anxiety, anxcond3>0)

#Outcome Model
y <- lm(immigration ~ anxcond+SCDBradSelfReport1_mean+storycond+ideology+age+race+income+education, data=noRelaxCond)
summary(y) # summarize results from model

#Mediator Model
m<-lm(SCDBradSelfReport1_mean ~ anxcond+storycond+ideology+age+income+race+education, data= noRelaxCond)
summary(m) # summarize results from model

#Mediation Analysis
m.out<-mediate(m,y, sims=10000, treat="anxcond", mediator="SCDBradSelfReport1_mean", dropobs=TRUE, boot=TRUE, conf.level=.90)
summary(m.out)
plot(m.out, labels=c("ACME\n(Physiological \nReactivity)", "Direct Effect \n(Anxiety)", "Total Effect"))


# Appendix J
# Figure 7
# Sensitivity Results for Mediation with Controls
sensitivity<-medsens(m.out, rho.by = 0.1)
summary(sensitivity)
plot(sensitivity, sign.prod="positive", sens.par = "R2", r.type = c("residual"), xlab="Proportion of Total Variance in M \nExplained by Confounder", ylab="Proportion of Total Variance in Y \n Explained by Confounder", main="(a)")

plot(sensitivity, sign.prod="negative", sens.par = "R2", r.type = c("residual"), xlab="Proportion of Total Variance in M \nExplained by Confounder", ylab="Proportion of Total Variance in Y \n Explained by Confounder", main="(b)")