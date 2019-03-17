* Replicates results from "Physiological Arousal and Political Beliefs"
* Published in Political Psychology
* Authors: Jonathan Renshon, Julia Lee & Dustin Tingley

* Note: nearly all figures and tables can be replicated from this code. For the few things that cannot, please see accompanying R code




* Open Data
clear
use replicationdata.dta, replace


*Label variables so tables look nice
label var SCDBradVidManipAll_mean "SCD (Mean) During Video"
label var SCDBradSelfReport1_mean "SCD (Mean) While Answering Questions"
label var emo "Self-Reported Immigration Beliefs"
label var CellID "Brader Condition (6 cells)"
label var anxcond "Anxiety Manipulation Dummy"
label var storycond "Story Condition"
label var interaction "Story X Anxiety"
label variable age "Age"
label variable race "Race"
label variable income "Income"
label variable education "Education"
label variable ideology "Ideology"
label variable anxietyvid "Anxiety Manipulation"
label variable relaxvid "Relax Manipulation"
label variable anxcond3 "Anxiety Condition"
label variable immigration "Immigration DV"







*Figure 1 a schematic of the experimental design


*Figure 2 
* Means of Skin Conductance Reactivity by Video Condition
ciplot SCDBradVidManipAll_mean,by(anxcond3)


*Figure 3 is causal mediation plot 
* (see R code)


* Table 1 in paper
* (1)
reg SCDBradSelfReport1_mean anxcond if anxcond3 ~=0

* (2) 
reg immigration storycond anxcond SCDBradSelfReport1_mean if anxcond3 ~=0


*Appendices

* Appendix C
* Figure 4 
* Means of Skin Conductance by treatment condition
ciplot SCDBradVidManipAll_mean,by(CellID)


* Appendix E
* Figure 5
* Manipulation Check for Anxiety Stimulus (mTurk Study)
* (see R code)




* Appendix F
* Table 2 (Alternate Main Results Table 1)

* (1) 
reg SCDBradSelfReport1_mean anxietyvid relaxvid

* (2)
reg immigration anxietyvid relaxvid

* (3)
reg immigration anxietyvid relaxvid SCDBradSelfReport1_mean

* (4) 
reg immigration anxietyvid relaxvid SCDBradSelfReport1_mean age ideology race income education


* Appendix G
* Table 3 (Alternate Main Results Table 2)

* (1) 
reg SCDBradSelfReport1_mean anxcond storycond interaction if anxcond3 ~=0

* (2)
reg immigration storycond anxcond SCDBradSelfReport1_mean interaction if anxcond3 ~=0




* Appendix H
* Table 4 (Effects of Physiological Reactivity on Immigration Preferences, Controlling for Self-Reported Immigration Beliefs)

* (1) 
reg immigration emo storycond SCDBradSelfReport1_mean if anxcond3 ==1

* (2) 
reg immigration emo storycond SCDBradSelfReport1_mean if anxcond3 ==2



* Appendix I (Mediation Results with Controls)
* (see R code)


* Appendix J (Sensitivity Results for Mediation with Controls)
* (see R code)




