
library(readxl)
library(tidyverse)
library(SIS)
library(openxlsx)

####### index 156 ######
ind156 <- read.csv('C:\\Users\\amy71\\Downloads\\index data\\index156.csv',header=T) 


######################################################################
################################ EEG #################################
######################################################################

EEG <- read.csv('C:\\Users\\amy71\\Downloads\\final data\\EEG.csv',header=T) 
(EEG <- tibble(EEG))
EEG[EEG['group']=='HC','group'] = '0'
EEG[EEG['group']=='AUD','group'] = '1'
EEG[EEG['group']=='IGD','group'] = '2'

EEG[EEG['sex']==2,'sex'] = 0
EEG['group'] = as.numeric(EEG[['group']])
EEG['sex'] = as.character(EEG[['sex']])


#### class 1 (HC vs. AUD)#####

selected_var1 = list(0,0,0,0,0)
selected_var2 = list(0,0,0,0,0)
selected_var3 = list(0,0,0,0,0)
### Sure Independence Screening ####

for (i in 1:5){
  data = EEG[na.omit(as.numeric(ind156[[i]])),]
  data1 = data[data['group']!=2,]

    ## scaling
  X = as.matrix(cbind(scale(subset(data1, select = -c(group,sex))),data1['sex']))
  y = data1$group
  
  ## ISIS vanilla 40
  model1 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', seed=2022, standardize = FALSE)
  selected_var1[i] = list(model1$ix)
  ## ISIS perm vanilla 40
  model2 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', perm=TRUE, seed=2022, standardize = FALSE)
  selected_var2[i] = list(model2$ix)
  ## ISIS aggr 40
  model3 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='aggr',  seed=2022, standardize = FALSE)
  selected_var3[i] = list(model3$ix)
}



#### dataframe / xlsx 
columns = cbind(subset(EEG, select = -c(group,sex)),EEG['sex'])
to_dataframe <- function(selected_var){
  var_names <- list(0,0,0,0,0)
  for (i in 1:5){var_names[i] <- list(names(columns[selected_var[[i]]]))}
  for (i in 1:5){length(var_names[[i]]) <- max(length(var_names[[1]]),length(var_names[[2]]),length(var_names[[3]]),length(var_names[[4]]),length(var_names[[5]]))}
  data.frame(do.call(cbind, var_names))
}

(var_names1 <- to_dataframe(selected_var1))
(var_names2 <- to_dataframe(selected_var2))
(var_names3 <- to_dataframe(selected_var3))

dataset_names <- list('vanilla40' = var_names1, 'vanilla40perm' = var_names2, 'aggr40' = var_names3)
openxlsx::write.xlsx(dataset_names, file = 'EEG_class1_selected_vars.xlsx') 






#### class 2 (HC vs.  IGD)#####

selected_var1 = list(0,0,0,0,0)
selected_var2 = list(0,0,0,0,0)
selected_var3 = list(0,0,0,0,0)

### Sure Independence Screening ####
for (i in 1:5){
  
  data = EEG[na.omit(as.numeric(ind156[[i]])),]
  data1 = data[data['group']!=1,]
  data1[data1['group']== 2,'group'] = 1
  
  ## scaling
  X = as.matrix(cbind(scale(subset(data1, select = -c(group,sex))),data1['sex']))
  y = data1$group
  
  ## ISIS vanilla 40
  model1 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', seed=2022, standardize = FALSE)
  selected_var1[i] = list(model1$ix)
  ## ISIS perm vanilla 40
  model2 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', perm=TRUE, seed=2022, standardize = FALSE)
  selected_var2[i] = list(model2$ix)
  ## ISIS aggr 40
  model3 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='aggr',  seed=2022, standardize = FALSE)
  selected_var3[i] = list(model3$ix)
  
  
}


#### dataframe / xlsx ?‚´ë³´ë‚´ê¸? #####
(var_names1 <- to_dataframe(selected_var1))
(var_names2 <- to_dataframe(selected_var2))
(var_names3 <- to_dataframe(selected_var3))

openxlsx::write.xlsx(dataset_names, file = 'EEG_class2_selected_vars.xlsx') 









#### class 3 (HC vs. DIS)#####


selected_var1 = list(0,0,0,0,0)
selected_var2 = list(0,0,0,0,0)
selected_var3 = list(0,0,0,0,0)

### Sure Independence Screening ####
for (i in 1:5){
  
  data = EEG[na.omit(as.numeric(ind156[[i]])),]
  data[data['group']== 2,'group'] = 1
  data1 = data
  
  ## scaling
  X = as.matrix(cbind(scale(subset(data1, select = -c(group,sex))),data1['sex']))
  y = data1$group
  
  ## ISIS vanilla 40
  model1 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', seed=2022, standardize = FALSE)
  selected_var1[i] = list(model1$ix)
  ## ISIS perm vanilla 40
  model2 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', perm=TRUE, seed=2022, standardize = FALSE)
  selected_var2[i] = list(model2$ix)
  ## ISIS aggr 40
  model3 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='aggr',  seed=2022, standardize = FALSE)
  selected_var3[i] = list(model3$ix)
}

#### dataframe / xlsx ?‚´ë³´ë‚´ê¸? #####
(var_names1 <- to_dataframe(selected_var1))
(var_names2 <- to_dataframe(selected_var2))
(var_names3 <- to_dataframe(selected_var3))
openxlsx::write.xlsx(dataset_names, file = 'EEG_class3_selected_vars.xlsx') 





# ¿Ï·á




######################################################################
################################ HRV #################################
######################################################################

HRV <- read.csv('C:\\Users\\amy71\\Downloads\\final data\\HRV.csv',header=T) 
(HRV <- tibble(HRV))

HRV[HRV['group']=='HC','group'] = '0'
HRV[HRV['group']=='AUD','group'] = '1'
HRV[HRV['group']=='IGD','group'] = '2'

HRV[HRV['sex']==2,'sex'] = 0
HRV['group'] = as.numeric(HRV[['group']])
HRV['sex'] = as.character(HRV[['sex']])


#### class 1 (HC vs. AUD)#####

selected_var1 = list(0,0,0,0,0)
selected_var2 = list(0,0,0,0,0)
selected_var3 = list(0,0,0,0,0)
### Sure Independence Screening ####

for (i in 1:5){
  data = HRV[na.omit(as.numeric(ind156[[i]])),]
  data1 = data[data['group']!=2,]
  
  ## scaling
  X = as.matrix(cbind(scale(subset(data1, select = -c(group,sex))),data1['sex']))
  y = data1$group
  
  ## ISIS vanilla 40
  model1 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', seed=2022, standardize = FALSE)
  selected_var1[i] = list(model1$ix)
  ## ISIS perm vanilla 40
  model2 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', perm=TRUE, seed=2022, standardize = FALSE)
  selected_var2[i] = list(model2$ix)
  ## ISIS aggr 40
  model3 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='aggr',  seed=2022, standardize = FALSE)
  selected_var3[i] = list(model3$ix)
}



#### dataframe / xlsx 
columns = cbind(subset(HRV, select = -c(group,sex)),HRV['sex'])
to_dataframe <- function(selected_var){
  var_names <- list(0,0,0,0,0)
  for (i in 1:5){var_names[i] <- list(names(columns[selected_var[[i]]]))}
  for (i in 1:5){length(var_names[[i]]) <- max(length(var_names[[1]]),length(var_names[[2]]),length(var_names[[3]]),length(var_names[[4]]),length(var_names[[5]]))}
  data.frame(do.call(cbind, var_names))
}

(var_names1 <- to_dataframe(selected_var1))
(var_names2 <- to_dataframe(selected_var2))
(var_names3 <- to_dataframe(selected_var3))
openxlsx::write.xlsx(dataset_names, file = 'HRV_class1_selected_vars.xlsx') 









#### class 2 (HC vs.  IGD)#####

selected_var1 = list(0,0,0,0,0)
selected_var2 = list(0,0,0,0,0)
selected_var3 = list(0,0,0,0,0)

### Sure Independence Screening ####
for (i in 1:5){
  
  data = HRV[na.omit(as.numeric(ind156[[i]])),]
  data1 = data[data['group']!=1,]
  data1[data1['group']== 2,'group'] = 1
  
  ## scaling
  X = as.matrix(cbind(scale(subset(data1, select = -c(group,sex))),data1['sex']))
  y = data1$group
  
  ## ISIS vanilla 40
  model1 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', seed=2022, standardize = FALSE)
  selected_var1[i] = list(model1$ix)
  ## ISIS perm vanilla 40
  model2 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', perm=TRUE, seed=2022, standardize = FALSE)
  selected_var2[i] = list(model2$ix)
  ## ISIS aggr 40
  model3 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='aggr',  seed=2022, standardize = FALSE)
  selected_var3[i] = list(model3$ix)
  
  
}


#### dataframe / xlsx ?‚´ë³´ë‚´ê¸? #####
(var_names1 <- to_dataframe(selected_var1))
(var_names2 <- to_dataframe(selected_var2))
(var_names3 <- to_dataframe(selected_var3))

openxlsx::write.xlsx(dataset_names, file = 'HRV_class2_selected_vars.xlsx') 









#### class 3 (HC vs. DIS)#####


selected_var1 = list(0,0,0,0,0)
selected_var2 = list(0,0,0,0,0)
selected_var3 = list(0,0,0,0,0)

### Sure Independence Screening ####
for (i in 1:5){
  
  data = HRV[na.omit(as.numeric(ind156[[i]])),]
  data[data['group']== 2,'group'] = 1
  data1 = data
  
  ## scaling
  X = as.matrix(cbind(scale(subset(data1, select = -c(group,sex))),data1['sex']))
  y = data1$group
  
  ## ISIS vanilla 40
  model1 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', seed=2022, standardize = FALSE)
  selected_var1[i] = list(model1$ix)
  ## ISIS perm vanilla 40
  model2 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', perm=TRUE, seed=2022, standardize = FALSE)
  selected_var2[i] = list(model2$ix)
  ## ISIS aggr 40
  model3 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='aggr',  seed=2022, standardize = FALSE)
  selected_var3[i] = list(model3$ix)
}

#### dataframe / xlsx ?‚´ë³´ë‚´ê¸? #####
(var_names1 <- to_dataframe(selected_var1))
(var_names2 <- to_dataframe(selected_var2))
(var_names3 <- to_dataframe(selected_var3))
openxlsx::write.xlsx(dataset_names, file = 'HRV_class3_selected_vars.xlsx') 












######################################################################
########################### EEG + HRV #################################
######################################################################

EEGHRV <- read.csv('C:\\Users\\amy71\\Downloads\\final data\\EEGHRV.csv',header=T) 
(EEGHRV <- tibble(EEGHRV))

EEGHRV[EEGHRV['group']=='HC','group'] = '0'
EEGHRV[EEGHRV['group']=='AUD','group'] = '1'
EEGHRV[EEGHRV['group']=='IGD','group'] = '2'

EEGHRV[EEGHRV['sex']==2,'sex'] = 0
EEGHRV['group'] = as.numeric(EEGHRV[['group']])
EEGHRV['sex'] = as.character(EEGHRV[['sex']])


#### class 1 (HC vs. AUD)#####

selected_var1 = list(0,0,0,0,0)
selected_var2 = list(0,0,0,0,0)
selected_var3 = list(0,0,0,0,0)
### Sure Independence Screening ####

for (i in 1:5){
  data = EEGHRV[na.omit(as.numeric(ind156[[i]])),]
  data1 = data[data['group']!=2,]
  
  ## scaling
  X = as.matrix(cbind(scale(subset(data1, select = -c(group,sex))),data1['sex']))
  y = data1$group
  
  ## ISIS vanilla 40
  model1 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', seed=2022, standardize = FALSE)
  selected_var1[i] = list(model1$ix)
  ## ISIS perm vanilla 40
  model2 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', perm=TRUE, seed=2022, standardize = FALSE)
  selected_var2[i] = list(model2$ix)
  ## ISIS aggr 40
  model3 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='aggr',  seed=2022, standardize = FALSE)
  selected_var3[i] = list(model3$ix)
}


#### dataframe / xlsx 
columns = cbind(subset(EEGHRV, select = -c(group,sex)),EEGHRV['sex'])
to_dataframe <- function(selected_var){
  var_names <- list(0,0,0,0,0)
  for (i in 1:5){var_names[i] <- list(names(columns[selected_var[[i]]]))}
  for (i in 1:5){length(var_names[[i]]) <- max(length(var_names[[1]]),length(var_names[[2]]),length(var_names[[3]]),length(var_names[[4]]),length(var_names[[5]]))}
  data.frame(do.call(cbind, var_names))
}

(var_names1 <- to_dataframe(selected_var1))
(var_names2 <- to_dataframe(selected_var2))
(var_names3 <- to_dataframe(selected_var3))

openxlsx::write.xlsx(dataset_names, file = 'EEGHRV_class1_selected_vars.xlsx') 









#### class 2 (HC vs.  IGD)#####

selected_var1 = list(0,0,0,0,0)
selected_var2 = list(0,0,0,0,0)
selected_var3 = list(0,0,0,0,0)

### Sure Independence Screening ####
for (i in 1:5){
  
  data = EEGHRV[na.omit(as.numeric(ind156[[i]])),]
  data1 = data[data['group']!=1,]
  data1[data1['group']== 2,'group'] = 1
  
  ## scaling
  X = as.matrix(cbind(scale(subset(data1, select = -c(group,sex))),data1['sex']))
  y = data1$group
  
  ## ISIS vanilla 40
  model1 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', seed=2022, standardize = FALSE)
  selected_var1[i] = list(model1$ix)
  ## ISIS perm vanilla 40
  model2 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', perm=TRUE, seed=2022, standardize = FALSE)
  selected_var2[i] = list(model2$ix)
  ## ISIS aggr 40
  model3 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='aggr',  seed=2022, standardize = FALSE)
  selected_var3[i] = list(model3$ix)
  
  
}


#### dataframe / xlsx ?‚´ë³´ë‚´ê¸? #####
(var_names1 <- to_dataframe(selected_var1))
(var_names2 <- to_dataframe(selected_var2))
(var_names3 <- to_dataframe(selected_var3))

openxlsx::write.xlsx(dataset_names, file = 'EEGHRV_class2_selected_vars.xlsx') 









#### class 3 (HC vs. DIS)#####


selected_var1 = list(0,0,0,0,0)
selected_var2 = list(0,0,0,0,0)
selected_var3 = list(0,0,0,0,0)

### Sure Independence Screening ####
for (i in 1:5){
  
  data = EEGHRV[na.omit(as.numeric(ind156[[i]])),]
  data[data['group']== 2,'group'] = 1
  data1 = data
  
  ## scaling
  X = as.matrix(cbind(scale(subset(data1, select = -c(group,sex))),data1['sex']))
  y = data1$group
  
  ## ISIS vanilla 40
  model1 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', seed=2022, standardize = FALSE)
  selected_var1[i] = list(model1$ix)
  ## ISIS perm vanilla 40
  model2 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', perm=TRUE, seed=2022, standardize = FALSE)
  selected_var2[i] = list(model2$ix)
  ## ISIS aggr 40
  model3 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='aggr',  seed=2022, standardize = FALSE)
  selected_var3[i] = list(model3$ix)
}

#### dataframe / xlsx ?‚´ë³´ë‚´ê¸? #####
(var_names1 <- to_dataframe(selected_var1))
(var_names2 <- to_dataframe(selected_var2))
(var_names3 <- to_dataframe(selected_var3))
openxlsx::write.xlsx(dataset_names, file = 'EEGHRV_class3_selected_vars.xlsx') 









###### index 99 (clinical?¬?•¨)
ind99 <- read.csv('C:\\Users\\amy71\\Downloads\\index data\\index99.csv',header=T) 


######################################################################
########################### clinical #################################
######################################################################
clinical <- read.csv('C:\\Users\\amy71\\Downloads\\final data\\clinical.csv',header=T) 
(clinical <- tibble(clinical))

clinical[clinical['group']=='HC','group'] = '0'
clinical[clinical['group']=='AUD','group'] = '1'
clinical[clinical['group']=='IGD','group'] = '2'

clinical[clinical['sex']==2,'sex'] = 0
clinical['group'] = as.numeric(clinical[['group']])
clinical['sex'] = as.character(clinical[['sex']])
clinical['X5.marriage'] = as.character(clinical[['X5.marriage']])


  

#### class 1 (HC vs. AUD)#####

selected_var1 = list(0,0,0,0,0)
selected_var2 = list(0,0,0,0,0)
selected_var3 = list(0,0,0,0,0)
### Sure Independence Screening ####
for (i in 1:5){
  
  data = clinical[na.omit(as.numeric(ind99[[i]])),]
  data1 = data[data['group']!=2,]
  
  ## scaling
  X = as.matrix(cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')]))
  y = data1$group
  
  ## ISIS vanilla 40
  model1 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', seed=2022, standardize = FALSE)
  selected_var1[i] = list(model1$ix)
  ## ISIS perm vanilla 40
  model2 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', perm=TRUE, seed=2022, standardize = FALSE)
  selected_var2[i] = list(model2$ix)
  ## ISIS aggr 40
  model3 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='aggr',  seed=2022, standardize = FALSE)
  selected_var3[i] = list(model3$ix)
 

}


#### dataframe / xlsx ?‚´ë³´ë‚´ê¸? #####
columns = cbind(subset(clinical, select = -c(group,sex,X5.marriage)),clinical[c('sex','X5.marriage')])
to_dataframe <- function(selected_var){
  var_names <- list(0,0,0,0,0)
  for (i in 1:5){var_names[i] <- list(names(columns[selected_var[[i]]]))}
  for (i in 1:5){length(var_names[[i]]) <- max(length(var_names[[1]]),length(var_names[[2]]),length(var_names[[3]]),length(var_names[[4]]),length(var_names[[5]]))}
  data.frame(do.call(cbind, var_names))
}

(var_names1 <- to_dataframe(selected_var1))
(var_names2 <- to_dataframe(selected_var2))
(var_names3 <- to_dataframe(selected_var3))

openxlsx::write.xlsx(dataset_names, file = 'clinical_class1_selected_vars.xlsx') 









#### class 2 (HC vs.  IGD)#####


selected_var1 = list(0,0,0,0,0)
selected_var2 = list(0,0,0,0,0)
selected_var3 = list(0,0,0,0,0)
### Sure Independence Screening ####
for (i in 1:5){
  
  data = clinical[na.omit(as.numeric(ind99[[i]])),]
  data1 = data[data['group']!=1,]
  data1[data1['group']== 2,'group'] = 1

  ## scaling
  X = as.matrix(cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')]))
  y = data1$group
  
  ## ISIS vanilla 40
  model1 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', seed=2022, standardize = FALSE)
  selected_var1[i] = list(model1$ix)
  ## ISIS perm vanilla 40
  model2 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', perm=TRUE, seed=2022, standardize = FALSE)
  selected_var2[i] = list(model2$ix)
  ## ISIS aggr 40
  model3 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='aggr',  seed=2022, standardize = FALSE)
  selected_var3[i] = list(model3$ix)
  
  
  
}


#### dataframe / xlsx ?‚´ë³´ë‚´ê¸? #####
(var_names1 <- to_dataframe(selected_var1))
(var_names2 <- to_dataframe(selected_var2))
(var_names3 <- to_dataframe(selected_var3))
openxlsx::write.xlsx(dataset_names, file = 'clinical_class2_selected_vars.xlsx') 









#### class 3 (HC vs. DIS)#####


selected_var1 = list(0,0,0,0,0)
selected_var2 = list(0,0,0,0,0)
selected_var3 = list(0,0,0,0,0)

### Sure Independence Screening ####
for (i in 1:5){
  
  data = clinical[na.omit(as.numeric(ind99[[i]])),]
  data[data['group']== 2,'group'] = 1
  data1 = data
  
  ## scaling
  X = as.matrix(cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')]))
  y = data1$group
  
  ## ISIS vanilla 40
  model1 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', seed=2022, standardize = FALSE)
  selected_var1[i] = list(model1$ix)
  ## ISIS perm vanilla 40
  model2 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', perm=TRUE, seed=2022, standardize = FALSE)
  selected_var2[i] = list(model2$ix)
  ## ISIS aggr 40
  model3 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='aggr',  seed=2022, standardize = FALSE)
  selected_var3[i] = list(model3$ix)
  
  
  
}


#### dataframe / xlsx ?‚´ë³´ë‚´ê¸? #####
(var_names1 <- to_dataframe(selected_var1))
(var_names2 <- to_dataframe(selected_var2))
(var_names3 <- to_dataframe(selected_var3))
openxlsx::write.xlsx(dataset_names, file = 'clinical_class3_selected_vars.xlsx') 










######################################################################
########################### EEGCli #################################
######################################################################
EEGCli <- read.csv('C:\\Users\\amy71\\Downloads\\final data\\EEGCli.csv',header=T) 
(EEGCli <- tibble(EEGCli))

EEGCli[EEGCli['group']=='HC','group'] = '0'
EEGCli[EEGCli['group']=='AUD','group'] = '1'
EEGCli[EEGCli['group']=='IGD','group'] = '2'

EEGCli[EEGCli['sex']==2,'sex'] = 0
EEGCli['group'] = as.numeric(EEGCli[['group']])
EEGCli['sex'] = as.character(EEGCli[['sex']])
EEGCli['X5.marriage'] = as.character(EEGCli[['X5.marriage']])




#### class 1 (HC vs. AUD)#####

selected_var1 = list(0,0,0,0,0)
selected_var2 = list(0,0,0,0,0)
selected_var3 = list(0,0,0,0,0)
### Sure Independence Screening ####
for (i in 1:5){
  
  data = EEGCli[na.omit(as.numeric(ind99[[i]])),]
  data1 = data[data['group']!=2,]
  
  ## scaling
  X = as.matrix(cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')]))
  y = data1$group
  
  ## ISIS vanilla 40
  model1 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', seed=2022, standardize = FALSE)
  selected_var1[i] = list(model1$ix)
  ## ISIS perm vanilla 40
  model2 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', perm=TRUE, seed=2022, standardize = FALSE)
  selected_var2[i] = list(model2$ix)
  ## ISIS aggr 40
  model3 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='aggr',  seed=2022, standardize = FALSE)
  selected_var3[i] = list(model3$ix)
  
}


#### dataframe / xlsx ?‚´ë³´ë‚´ê¸? #####
columns = cbind(subset(EEGCli, select = -c(group,sex,X5.marriage)),EEGCli[c('sex','X5.marriage')])
to_dataframe <- function(selected_var){
  var_names <- list(0,0,0,0,0)
  for (i in 1:5){var_names[i] <- list(names(columns[selected_var[[i]]]))}
  for (i in 1:5){length(var_names[[i]]) <- max(length(var_names[[1]]),length(var_names[[2]]),length(var_names[[3]]),length(var_names[[4]]),length(var_names[[5]]))}
  data.frame(do.call(cbind, var_names))
}

(var_names1 <- to_dataframe(selected_var1))
(var_names2 <- to_dataframe(selected_var2))
(var_names3 <- to_dataframe(selected_var3))
openxlsx::write.xlsx(dataset_names, file = 'EEGCli_class1_selected_vars.xlsx') 







#### class 2 (HC vs.  IGD)#####


selected_var1 = list(0,0,0,0,0)
selected_var2 = list(0,0,0,0,0)
selected_var3 = list(0,0,0,0,0)

### Sure Independence Screening ####
for (i in 1:5){
  
  data = EEGCli[na.omit(as.numeric(ind99[[i]])),]
  data1 = data[data['group']!=1,]
  data1[data1['group']== 2,'group'] = 1
  
  ## scaling
  X = as.matrix(cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')]))
  y = data1$group
  
  ## ISIS vanilla 40
  model1 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', seed=2022, standardize = FALSE)
  selected_var1[i] = list(model1$ix)
  ## ISIS perm vanilla 40
  model2 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', perm=TRUE, seed=2022, standardize = FALSE)
  selected_var2[i] = list(model2$ix)
  ## ISIS aggr 40
  model3 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='aggr',  seed=2022, standardize = FALSE)
  selected_var3[i] = list(model3$ix)
  
}


#### dataframe / xlsx ?‚´ë³´ë‚´ê¸? #####
(var_names1 <- to_dataframe(selected_var1))
(var_names2 <- to_dataframe(selected_var2))
(var_names3 <- to_dataframe(selected_var3))
openxlsx::write.xlsx(dataset_names, file = 'EEGCli_class2_selected_vars.xlsx') 









#### class 3 (HC vs. DIS)#####


selected_var1 = list(0,0,0,0,0)
selected_var2 = list(0,0,0,0,0)
selected_var3 = list(0,0,0,0,0)

### Sure Independence Screening ####
for (i in 1:5){
  
  data = EEGCli[na.omit(as.numeric(ind99[[i]])),]
  data[data['group']== 2,'group'] = 1
  data1 = data
  
  
  ## scaling
  X = as.matrix(cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')]))
  y = data1$group
  
  ## ISIS vanilla 40
  model1 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', seed=2022, standardize = FALSE)
  selected_var1[i] = list(model1$ix)
  ## ISIS perm vanilla 40
  model2 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', perm=TRUE, seed=2022, standardize = FALSE)
  selected_var2[i] = list(model2$ix)
  ## ISIS aggr 40
  model3 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='aggr',  seed=2022, standardize = FALSE)
  selected_var3[i] = list(model3$ix)
  
  
}


#### dataframe / xlsx ?‚´ë³´ë‚´ê¸? #####
(var_names1 <- to_dataframe(selected_var1))
(var_names2 <- to_dataframe(selected_var2))
(var_names3 <- to_dataframe(selected_var3))
openxlsx::write.xlsx(dataset_names, file = 'EEGCli_class3_selected_vars.xlsx') 








######################################################################
########################### HRVCli #################################
######################################################################
HRVCli <- read.csv('C:\\Users\\amy71\\Downloads\\final data\\HRVCli.csv',header=T) 
(HRVCli <- tibble(HRVCli))

HRVCli[HRVCli['group']=='HC','group'] = '0'
HRVCli[HRVCli['group']=='AUD','group'] = '1'
HRVCli[HRVCli['group']=='IGD','group'] = '2'

HRVCli[HRVCli['sex']==2,'sex'] = 0
HRVCli['group'] = as.numeric(HRVCli[['group']])
HRVCli['sex'] = as.character(HRVCli[['sex']])
HRVCli['X5.marriage'] = as.character(HRVCli[['X5.marriage']])




#### class 1 (HC vs. AUD)#####

selected_var1 = list(0,0,0,0,0)
selected_var2 = list(0,0,0,0,0)
selected_var3 = list(0,0,0,0,0)
### Sure Independence Screening ####
for (i in 1:5){
  
  data = HRVCli[na.omit(as.numeric(ind99[[i]])),]
  data1 = data[data['group']!=2,]
  
  ## scaling
  X = as.matrix(cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')]))
  y = data1$group
  
  ## ISIS vanilla 40
  model1 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', seed=2022, standardize = FALSE)
  selected_var1[i] = list(model1$ix)
  ## ISIS perm vanilla 40
  model2 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', perm=TRUE, seed=2022, standardize = FALSE)
  selected_var2[i] = list(model2$ix)
  ## ISIS aggr 40
  model3 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='aggr',  seed=2022, standardize = FALSE)
  selected_var3[i] = list(model3$ix)
  
}


#### dataframe / xlsx ?‚´ë³´ë‚´ê¸? #####
columns = cbind(subset(HRVCli, select = -c(group,sex,X5.marriage)),HRVCli[c('sex','X5.marriage')])
to_dataframe <- function(selected_var){
  var_names <- list(0,0,0,0,0)
  for (i in 1:5){var_names[i] <- list(names(columns[selected_var[[i]]]))}
  for (i in 1:5){length(var_names[[i]]) <- max(length(var_names[[1]]),length(var_names[[2]]),length(var_names[[3]]),length(var_names[[4]]),length(var_names[[5]]))}
  data.frame(do.call(cbind, var_names))
}

(var_names1 <- to_dataframe(selected_var1))
(var_names2 <- to_dataframe(selected_var2))
(var_names3 <- to_dataframe(selected_var3))
openxlsx::write.xlsx(dataset_names, file = 'HRVCli_class1_selected_vars.xlsx') 









#### class 2 (HC vs.  IGD)#####


selected_var1 = list(0,0,0,0,0)
selected_var2 = list(0,0,0,0,0)
selected_var3 = list(0,0,0,0,0)

### Sure Independence Screening ####
for (i in 1:5){
  
  data = HRVCli[na.omit(as.numeric(ind99[[i]])),]
  data1 = data[data['group']!=1,]
  data1[data1['group']== 2,'group'] = 1
  
  ## scaling
  X = as.matrix(cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')]))
  y = data1$group
  
  ## ISIS vanilla 40
  model1 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', seed=2022, standardize = FALSE)
  selected_var1[i] = list(model1$ix)
  ## ISIS perm vanilla 40
  model2 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', perm=TRUE, seed=2022, standardize = FALSE)
  selected_var2[i] = list(model2$ix)
  ## ISIS aggr 40
  model3 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='aggr',  seed=2022, standardize = FALSE)
  selected_var3[i] = list(model3$ix)
  
  
}


#### dataframe / xlsx ?‚´ë³´ë‚´ê¸? #####
(var_names1 <- to_dataframe(selected_var1))
(var_names2 <- to_dataframe(selected_var2))
(var_names3 <- to_dataframe(selected_var3))
openxlsx::write.xlsx(dataset_names, file = 'HRVCli_class2_selected_vars.xlsx') 









#### class 3 (HC vs. DIS)#####


selected_var1 = list(0,0,0,0,0)
selected_var2 = list(0,0,0,0,0)
selected_var3 = list(0,0,0,0,0)

### Sure Independence Screening ####
for (i in 1:5){
  
  data = HRVCli[na.omit(as.numeric(ind99[[i]])),]
  data[data['group']== 2,'group'] = 1
  data1 = data
  
  
  ## scaling
  X = as.matrix(cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')]))
  y = data1$group
  
  ## ISIS vanilla 40
  model1 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', seed=2022, standardize = FALSE)
  selected_var1[i] = list(model1$ix)
  ## ISIS perm vanilla 40
  model2 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', perm=TRUE, seed=2022, standardize = FALSE)
  selected_var2[i] = list(model2$ix)
  ## ISIS aggr 40
  model3 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='aggr',  seed=2022, standardize = FALSE)
  selected_var3[i] = list(model3$ix)
  
  
}


#### dataframe / xlsx ?‚´ë³´ë‚´ê¸? #####
(var_names1 <- to_dataframe(selected_var1))
(var_names2 <- to_dataframe(selected_var2))
(var_names3 <- to_dataframe(selected_var3))
openxlsx::write.xlsx(dataset_names, file = 'HRVCli_class3_selected_vars.xlsx') 








######################################################################
########################### EEGHRVCli #################################
######################################################################
EEGHRVCli <- read.csv('C:\\Users\\amy71\\Downloads\\final data\\EEGHRVCli.csv',header=T) 
(EEGHRVCli <- tibble(EEGHRVCli))

EEGHRVCli[EEGHRVCli['group']=='HC','group'] = '0'
EEGHRVCli[EEGHRVCli['group']=='AUD','group'] = '1'
EEGHRVCli[EEGHRVCli['group']=='IGD','group'] = '2'

EEGHRVCli[EEGHRVCli['sex']==2,'sex'] = 0
EEGHRVCli['group'] = as.numeric(EEGHRVCli[['group']])
EEGHRVCli['sex'] = as.character(EEGHRVCli[['sex']])
EEGHRVCli['X5.marriage'] = as.character(EEGHRVCli[['X5.marriage']])




#### class 1 (HC vs. AUD)#####

selected_var1 = list(0,0,0,0,0)
selected_var2 = list(0,0,0,0,0)
selected_var3 = list(0,0,0,0,0)
### Sure Independence Screening ####
for (i in 1:5){
  
  data = EEGHRVCli[na.omit(as.numeric(ind99[[i]])),]
  data1 = data[data['group']!=2,]
  
  ## scaling
  X = as.matrix(cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')]))
  y = data1$group
  
  ## ISIS vanilla 40
  model1 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', seed=2022, standardize = FALSE)
  selected_var1[i] = list(model1$ix)
  ## ISIS perm vanilla 40
  model2 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', perm=TRUE, seed=2022, standardize = FALSE)
  selected_var2[i] = list(model2$ix)
  ## ISIS aggr 40
  model3 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='aggr',  seed=2022, standardize = FALSE)
  selected_var3[i] = list(model3$ix)
  
}


#### dataframe / xlsx ?‚´ë³´ë‚´ê¸? #####
columns = cbind(subset(EEGHRVCli, select = -c(group,sex,X5.marriage)),EEGHRVCli[c('sex','X5.marriage')])
to_dataframe <- function(selected_var){
  var_names <- list(0,0,0,0,0)
  for (i in 1:5){var_names[i] <- list(names(columns[selected_var[[i]]]))}
  for (i in 1:5){length(var_names[[i]]) <- max(length(var_names[[1]]),length(var_names[[2]]),length(var_names[[3]]),length(var_names[[4]]),length(var_names[[5]]))}
  data.frame(do.call(cbind, var_names))
}

(var_names1 <- to_dataframe(selected_var1))
(var_names2 <- to_dataframe(selected_var2))
(var_names3 <- to_dataframe(selected_var3))
openxlsx::write.xlsx(dataset_names, file = 'EEGHRVCli_class1_selected_vars.xlsx') 









#### class 2 (HC vs.  IGD)#####


selected_var1 = list(0,0,0,0,0)
selected_var2 = list(0,0,0,0,0)
selected_var3 = list(0,0,0,0,0)

### Sure Independence Screening ####
for (i in 1:5){
  
  data = EEGHRVCli[na.omit(as.numeric(ind99[[i]])),]
  data1 = data[data['group']!=1,]
  data1[data1['group']== 2,'group'] = 1
  
  ## scaling
  X = as.matrix(cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')]))
  y = data1$group
  
  ## ISIS vanilla 40
  model1 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', seed=2022, standardize = FALSE)
  selected_var1[i] = list(model1$ix)
  ## ISIS perm vanilla 40
  model2 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', perm=TRUE, seed=2022, standardize = FALSE)
  selected_var2[i] = list(model2$ix)
  ## ISIS aggr 40
  model3 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='aggr',  seed=2022, standardize = FALSE)
  selected_var3[i] = list(model3$ix)
  
  
}


#### dataframe / xlsx ?‚´ë³´ë‚´ê¸? #####
(var_names1 <- to_dataframe(selected_var1))
(var_names2 <- to_dataframe(selected_var2))
(var_names3 <- to_dataframe(selected_var3))
openxlsx::write.xlsx(dataset_names, file = 'EEGHRVCli_class2_selected_vars.xlsx') 









#### class 3 (HC vs. DIS)#####


selected_var1 = list(0,0,0,0,0)
selected_var2 = list(0,0,0,0,0)
selected_var3 = list(0,0,0,0,0)

### Sure Independence Screening ####
for (i in 1:5){
  
  data = EEGHRVCli[na.omit(as.numeric(ind99[[i]])),]
  data[data['group']== 2,'group'] = 1
  data1 = data
  
  
  ## scaling
  X = as.matrix(cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')]))
  y = data1$group
  
  ## ISIS vanilla 40
  model1 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', seed=2022, standardize = FALSE)
  selected_var1[i] = list(model1$ix)
  ## ISIS perm vanilla 40
  model2 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='vanilla', perm=TRUE, seed=2022, standardize = FALSE)
  selected_var2[i] = list(model2$ix)
  ## ISIS aggr 40
  model3 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
               varISIS='aggr',  seed=2022, standardize = FALSE)
  selected_var3[i] = list(model3$ix)
  
  
}


#### dataframe / xlsx ?‚´ë³´ë‚´ê¸? #####
(var_names1 <- to_dataframe(selected_var1))
(var_names2 <- to_dataframe(selected_var2))
(var_names3 <- to_dataframe(selected_var3))
openxlsx::write.xlsx(dataset_names, file = 'EEGHRVCli_class3_selected_vars.xlsx') 








