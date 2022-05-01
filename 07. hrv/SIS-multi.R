library(readxl)
library(tidyverse)
library(SIS)
library(openxlsx)


EEG <- read.csv('/Users/gyony/Downloads/Final Data/EEG.csv',header=T) 
(EEG <- tibble(EEG))
EEG[EEG['group']=='HC','group'] = '0'
EEG[EEG['group']=='AUD','group'] = '1'
EEG[EEG['group']=='IGD','group'] = '2'

EEG[EEG['sex']==2,'sex'] = 0
EEG['group'] = as.numeric(EEG[['group']])
EEG['sex'] = as.character(EEG[['sex']])

################## Binary ###################
############## class 1 (HC vs. AUD)############
data = EEG
data1 = data[data['group']!=2,]


##### SIS 패키지 ###
## scaling
X = as.matrix(cbind(scale(subset(data1, select = -c(group,sex))),data1['sex']))
y = data1$group

model1 = SIS(X,y, family='binomial', penalty='lasso', tune='cv', nfolds=5, nsis=40,
             iter=FALSE ,  seed=2022, standardize = FALSE)
model1$ix
c = cbind(subset(data1, select = -c(group,sex)),data1['sex'])
names(c)[model1$ix]

####### SIS 구현 #####
library(glmnet)

X = cbind(scale(subset(data1, select = -c(group,sex))),data1['sex'])
y = data1$group

step1 <- function(X,y){
  glm.coef = c()
  for (i in 1:ncol(X)){
      glm.coef[i] <- glm(y ~ X[,i], family='binomial')$coef[2]
  }
  ind <- order(-abs(glm.coef))[1:40] 
  new_X <- X[,ind]
  output = list(new_X=new_X, ind=ind)
  return(output)
  }
result1 <- step1(X,y)
new_X <- result1$new_X
ind <- result1$ind

step2 <- function(new_X,y,ind){
  # penalize with LASSO cv
  set.seed(2022)
  lam <- cv.glmnet(as.matrix(new_X), y, alpha = 1,family='binomial')$lambda.min
  fin <- glmnet(as.matrix(new_X), y, alpha = 1, family='binomial', lambda=lam)
  ind <- ind[which(coef(fin) != 0)[-1]]
  return(ind)
}

final_ind <- step2(new_X,y,ind)
final_ind 
names(X)[final_ind]




################ Multi-class ################

############## class 4 (HC vs. AUD vs. IGD)############
data1 = EEG

####### SIS 구현 ####
library(nnet)

## scaling
X = cbind(scale(subset(data1, select = -c(group,sex))),data1['sex'])
y = as.character(data1$group)

step1 <- function(X,y){
  glm.aic = c()
  for (i in 1:ncol(X)){
    glm.aic[i] <- multinom(y ~ X[,i])$AIC  # aic 기준 
  }
  ind <- order(glm.aic)[1:40] 
  new_X <- X[,ind]
  output = list(new_X=new_X, ind=ind)
  return(output)
}
result1 <- step1(X,y)
new_X <- result1$new_X
ind <- result1$ind


step2 <- function(new_X,y,ind){
  # penalize with LASSO cv
  set.seed(2030)
  lam <- cv.glmnet(data.matrix(new_X), y, alpha = 1, family='multinomial')$lambda.min
  fin <- glmnet(as.matrix(new_X), y, alpha = 1, family='multinomial', lambda=lam)
  ind0 <- ind[which(coef(fin)$'0' != 0)[-1]]
  ind1 <- ind[which(coef(fin)$'1' != 0)[-1]]
  ind2 <- ind[which(coef(fin)$'2' != 0)[-1]]
  return(unique(c(ind0,ind1,ind2)))
}

final_ind <- step2(new_X,y,ind)
(selected_var1 = final_ind)
names(X)[selected_var1]
###############################################################################








######################## 5가지 dataset ##############################

############## EEG #################

EEG <- read.csv('/Users/gyony/Downloads/Final Data/EEG.csv',header=T) 
(EEG <- tibble(EEG))
EEG[EEG['group']=='HC','group'] = '0'
EEG[EEG['group']=='AUD','group'] = '1'
EEG[EEG['group']=='IGD','group'] = '2'

EEG[EEG['sex']==2,'sex'] = 0
EEG['group'] = as.numeric(EEG[['group']])
EEG['sex'] = as.character(EEG[['sex']])

####### index 156 ######
ind156 <- read.csv('/Users/gyony/Downloads/index data/index156.csv',header=T) 


selected_var1 = list(0,0,0,0,0)
### Sure Independence Screening ####
for (i in 1:5){
  
  data1 = EEG[na.omit(as.numeric(ind156[[i]])),]

  ## scaling
  X = cbind(scale(subset(data1, select = -c(group,sex))),data1['sex'])
  y = as.character(data1$group)
  result1 <- step1(X,y)
  new_X <- result1$new_X
  ind <- result1$ind
  final_ind <- step2(new_X,y,ind)
  selected_var1[i] = list(na.omit(final_ind))
  
}



#### dataframe / xlsx 
columns = cbind(scale(subset(data1, select = -c(group,sex))),data1['sex'])
to_dataframe <- function(selected_var){
  var_names <- list(0,0,0,0,0)
  for (i in 1:5){var_names[i] <- list(names(columns[selected_var[[i]]]))}
  for (i in 1:5){length(var_names[[i]]) <- max(length(var_names[[1]]),length(var_names[[2]]),length(var_names[[3]]),length(var_names[[4]]),length(var_names[[5]]))}
  data.frame(do.call(cbind, var_names))
}

(var_names1 <- to_dataframe(selected_var1))

dataset_names <- list('SIS' = var_names1)
openxlsx::write.xlsx(dataset_names, file = 'EEG_class4_selected_vars.xlsx') 





###################################### EEGHRV ######################################

EEGHRV <- read.csv('/Users/gyony/Downloads/Final Data/EEGHRV.csv',header=T,fileEncoding = "cp949") 
(EEGHRV <- tibble(EEGHRV))

EEGHRV[EEGHRV['group']=='HC','group'] = '0'
EEGHRV[EEGHRV['group']=='AUD','group'] = '1'
EEGHRV[EEGHRV['group']=='IGD','group'] = '2'

EEGHRV[EEGHRV['sex']==2,'sex'] = 0
EEGHRV['group'] = as.numeric(EEGHRV[['group']])
EEGHRV['sex'] = as.character(EEGHRV[['sex']])


####### index 156 ######
ind156 <- read.csv('/Users/gyony/Downloads/index data/index156.csv',header=T) 


selected_var1 = list(0,0,0,0,0)
### Sure Independence Screening ####
for (i in 1:5){
  
  data1 = EEGHRV[na.omit(as.numeric(ind156[[i]])),]
  
  ## scaling
  X = cbind(scale(subset(data1, select = -c(group,sex))),data1['sex'])
  y = as.character(data1$group)
  result1 <- step1(X,y)
  new_X <- result1$new_X
  ind <- result1$ind
  final_ind <- step2(new_X,y,ind)
  selected_var1[i] = list(na.omit(final_ind))
  
}



#### dataframe / xlsx 
columns = cbind(scale(subset(data1, select = -c(group,sex))),data1['sex'])
to_dataframe <- function(selected_var){
  var_names <- list(0,0,0,0,0)
  for (i in 1:5){var_names[i] <- list(names(columns[selected_var[[i]]]))}
  for (i in 1:5){length(var_names[[i]]) <- max(length(var_names[[1]]),length(var_names[[2]]),length(var_names[[3]]),length(var_names[[4]]),length(var_names[[5]]))}
  data.frame(do.call(cbind, var_names))
}

(var_names1 <- to_dataframe(selected_var1))

dataset_names <- list('SIS' = var_names1)
openxlsx::write.xlsx(dataset_names, file = 'EEGHRV_class4_selected_vars.xlsx') 





###################################### HRV ######################################

HRV <- read.csv('/Users/gyony/Downloads/Final Data/HRV.csv',header=T,fileEncoding = "cp949") 
(HRV <- tibble(HRV))

HRV[HRV['group']=='HC','group'] = '0'
HRV[HRV['group']=='AUD','group'] = '1'
HRV[HRV['group']=='IGD','group'] = '2'

HRV[HRV['sex']==2,'sex'] = 0
HRV['group'] = as.numeric(HRV[['group']])
HRV['sex'] = as.character(HRV[['sex']])

####### index 156 ######
ind156 <- read.csv('/Users/gyony/Downloads/index data/index156.csv',header=T) 



step1 <- function(X,y){
  glm.aic = c()
  for (i in 1:ncol(X)){
    glm.aic[i] <- multinom(y ~ X[,i])$AIC  # aic 기준 
  }
  ind <- order(glm.aic)[1:length(X)] 
  new_X <- X[,ind]
  output = list(new_X=new_X, ind=ind)
  return(output)
}



selected_var1 = list(0,0,0,0,0)
### Sure Independence Screening ####
for (i in 1:5){
  
  data1 = HRV[na.omit(as.numeric(ind156[[i]])),]
  ## scaling
  X = cbind(scale(subset(data1, select = -c(group,sex))),data1['sex'])
  y = as.character(data1$group)
  result1 <- step1(X,y)
  new_X <- result1$new_X
  ind <- result1$ind
  final_ind <- step2(new_X,y,ind)
  selected_var1[i] = list(na.omit(final_ind))
  
}



#### dataframe / xlsx 
columns = cbind(scale(subset(data1, select = -c(group,sex))),data1['sex'])
to_dataframe <- function(selected_var){
  var_names <- list(0,0,0,0,0)
  for (i in 1:5){var_names[i] <- list(names(columns[selected_var[[i]]]))}
  for (i in 1:5){length(var_names[[i]]) <- max(length(var_names[[1]]),length(var_names[[2]]),length(var_names[[3]]),length(var_names[[4]]),length(var_names[[5]]))}
  data.frame(do.call(cbind, var_names))
}

(var_names1 <- to_dataframe(selected_var1))

dataset_names <- list('SIS' = var_names1)
openxlsx::write.xlsx(dataset_names, file = 'HRV_class4_selected_vars.xlsx') 






############## Cli #################

clinical <- read.csv('/Users/gyony/Downloads/Final Data/clinical.csv',header=T,fileEncoding = "cp949") 
(clinical <- tibble(clinical))

clinical[clinical['group']=='HC','group'] = '0'
clinical[clinical['group']=='AUD','group'] = '1'
clinical[clinical['group']=='IGD','group'] = '2'

clinical[clinical['sex']==2,'sex'] = 0
clinical['group'] = as.numeric(clinical[['group']])
clinical['sex'] = as.character(clinical[['sex']])
clinical['X5.marriage'] = as.character(clinical[['X5.marriage']])




###### index 99 (clinical포함)
ind99 <- read.csv('/Users/gyony/Downloads/index data/index99.csv',header=T) 



selected_var1 = list(0,0,0,0,0)
### Sure Independence Screening ####
for (i in 1:5){
  
  data1 = clinical[na.omit(as.numeric(ind99[[i]])),]
  
  ## scaling
  X = cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')])
  y = as.character(data1$group)
  result1 <- step1(X,y)
  new_X <- result1$new_X
  ind <- result1$ind
  final_ind <- step2(new_X,y,ind)
  selected_var1[i] = list(na.omit(final_ind))
  
}



#### dataframe / xlsx 
columns = cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')])
to_dataframe <- function(selected_var){
  var_names <- list(0,0,0,0,0)
  for (i in 1:5){var_names[i] <- list(names(columns[selected_var[[i]]]))}
  for (i in 1:5){length(var_names[[i]]) <- max(length(var_names[[1]]),length(var_names[[2]]),length(var_names[[3]]),length(var_names[[4]]),length(var_names[[5]]))}
  data.frame(do.call(cbind, var_names))
}

(var_names1 <- to_dataframe(selected_var1))

dataset_names <- list('SIS' = var_names1)
openxlsx::write.xlsx(dataset_names, file = 'clinical_class4_selected_vars.xlsx') 




############## HRVCli #################

HRVCli <- read.csv('/Users/gyony/Downloads/Final Data/HRVCli.csv',header=T,fileEncoding = "cp949")
(HRVCli <- tibble(HRVCli))

HRVCli[HRVCli['group']=='HC','group'] = '0'
HRVCli[HRVCli['group']=='AUD','group'] = '1'
HRVCli[HRVCli['group']=='IGD','group'] = '2'

HRVCli[HRVCli['sex']==2,'sex'] = 0
HRVCli['group'] = as.numeric(HRVCli[['group']])
HRVCli['sex'] = as.character(HRVCli[['sex']])
HRVCli['X5.marriage'] = as.character(HRVCli[['X5.marriage']])


###### index 99 (clinical포함)
ind99 <- read.csv('/Users/gyony/Downloads/index data/index99.csv',header=T) 



selected_var1 = list(0,0,0,0,0)
### Sure Independence Screening ####
for (i in 1:5){
  
  data1 = HRVCli[na.omit(as.numeric(ind99[[i]])),]
  
  ## scaling
  X = cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')])
  y = as.character(data1$group)
  result1 <- step1(X,y)
  new_X <- result1$new_X
  ind <- result1$ind
  final_ind <- step2(new_X,y,ind)
  selected_var1[i] = list(na.omit(final_ind))
  
}



#### dataframe / xlsx 
columns = cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')])
to_dataframe <- function(selected_var){
  var_names <- list(0,0,0,0,0)
  for (i in 1:5){var_names[i] <- list(names(columns[selected_var[[i]]]))}
  for (i in 1:5){length(var_names[[i]]) <- max(length(var_names[[1]]),length(var_names[[2]]),length(var_names[[3]]),length(var_names[[4]]),length(var_names[[5]]))}
  data.frame(do.call(cbind, var_names))
}

(var_names1 <- to_dataframe(selected_var1))

dataset_names <- list('SIS' = var_names1)
openxlsx::write.xlsx(dataset_names, file = 'HRVCli_class4_selected_vars.xlsx') 








############## EEGHRVCli #################

EEGHRVCli <- read.csv('/Users/gyony/Downloads/final data/EEGHRVCli.csv',header=T,fileEncoding = "cp949") 
(EEGHRVCli <- tibble(EEGHRVCli))

EEGHRVCli[EEGHRVCli['group']=='HC','group'] = '0'
EEGHRVCli[EEGHRVCli['group']=='AUD','group'] = '1'
EEGHRVCli[EEGHRVCli['group']=='IGD','group'] = '2'

EEGHRVCli[EEGHRVCli['sex']==2,'sex'] = 0
EEGHRVCli['group'] = as.numeric(EEGHRVCli[['group']])
EEGHRVCli['sex'] = as.character(EEGHRVCli[['sex']])
EEGHRVCli['X5.marriage'] = as.character(EEGHRVCli[['X5.marriage']])

###### index 99 (clinical포함)
ind99 <- read.csv('/Users/gyony/Downloads/index data/index99.csv',header=T) 

step1 <- function(X,y){
  glm.aic = c()
  for (i in 1:ncol(X)){
    glm.aic[i] <- multinom(y ~ X[,i])$AIC  # aic 기준 
  }
  ind <- order(glm.aic)[1:40] 
  new_X <- X[,ind]
  output = list(new_X=new_X, ind=ind)
  return(output)
}

selected_var1 = list(0,0,0,0,0)
### Sure Independence Screening ####
for (i in 1:5){
  
  data1 = EEGHRVCli[na.omit(as.numeric(ind99[[i]])),]
  
  ## scaling
  X = cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')])
  y = as.character(data1$group)
  result1 <- step1(X,y)
  new_X <- result1$new_X
  ind <- result1$ind
  final_ind <- step2(new_X,y,ind)
  selected_var1[i] = list(na.omit(final_ind))
  
}



#### dataframe / xlsx 
columns = cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')])
to_dataframe <- function(selected_var){
  var_names <- list(0,0,0,0,0)
  for (i in 1:5){var_names[i] <- list(names(columns[selected_var[[i]]]))}
  for (i in 1:5){length(var_names[[i]]) <- max(length(var_names[[1]]),length(var_names[[2]]),length(var_names[[3]]),length(var_names[[4]]),length(var_names[[5]]))}
  data.frame(do.call(cbind, var_names))
}

(var_names1 <- to_dataframe(selected_var1))

dataset_names <- list('SIS' = var_names1)
openxlsx::write.xlsx(dataset_names, file = 'EEGHRVCli_class4_selected_vars.xlsx') 





######################################################################
########################### EEGCli #################################
######################################################################
EEGCli <- read.csv('/Users/gyony/Downloads/final data/EEGCli.csv',header=T,fileEncoding = "cp949") 
(EEGCli <- tibble(EEGCli))

EEGCli[EEGCli['group']=='HC','group'] = '0'
EEGCli[EEGCli['group']=='AUD','group'] = '1'
EEGCli[EEGCli['group']=='IGD','group'] = '2'

EEGCli[EEGCli['sex']==2,'sex'] = 0
EEGCli['group'] = as.numeric(EEGCli[['group']])
EEGCli['sex'] = as.character(EEGCli[['sex']])
EEGCli['X5.marriage'] = as.character(EEGCli[['X5.marriage']])



selected_var1 = list(0,0,0,0,0)
### Sure Independence Screening ####
for (i in 1:5){
  
  data1 = EEGCli[na.omit(as.numeric(ind99[[i]])),]
  
  ## scaling
  X = cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')])
  y = as.character(data1$group)
  result1 <- step1(X,y)
  new_X <- result1$new_X
  ind <- result1$ind
  final_ind <- step2(new_X,y,ind)
  selected_var1[i] = list(na.omit(final_ind))
  
}



#### dataframe / xlsx 
columns = cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')])
to_dataframe <- function(selected_var){
  var_names <- list(0,0,0,0,0)
  for (i in 1:5){var_names[i] <- list(names(columns[selected_var[[i]]]))}
  for (i in 1:5){length(var_names[[i]]) <- max(length(var_names[[1]]),length(var_names[[2]]),length(var_names[[3]]),length(var_names[[4]]),length(var_names[[5]]))}
  data.frame(do.call(cbind, var_names))
}

(var_names1 <- to_dataframe(selected_var1))
dataset_names <- list('SIS' = var_names1)
openxlsx::write.xlsx(dataset_names, file = 'EEGCli_class4_selected_vars.xlsx') 















################################# train set #####################################




################################### SIS 구현 ####################################
library(nnet)
step1 <- function(X,y){
  glm.aic = c()
  for (i in 1:ncol(X)){
    glm.aic[i] <- multinom(y ~ X[,i])$AIC  # aic 기준 
  }
  ind <- order(glm.aic)[1:40] 
  new_X <- X[,ind]
  output = list(new_X=new_X, ind=ind)
  return(output)
}

step2 <- function(new_X,y,ind){
  # penalize with LASSO cv
  set.seed(2030)
  lam <- cv.glmnet(data.matrix(new_X), y, alpha = 1, family='multinomial')$lambda.min
  fin <- glmnet(as.matrix(new_X), y, alpha = 1, family='multinomial', lambda=lam)
  ind0 <- ind[which(coef(fin)$'0' != 0)[-1]]
  ind1 <- ind[which(coef(fin)$'1' != 0)[-1]]
  ind2 <- ind[which(coef(fin)$'2' != 0)[-1]]
  return(unique(c(ind0,ind1,ind2)))
}

###############################################################################








######################## 5가지 dataset ##############################

############## EEG #################

EEG <- read.csv('/Users/gyony/Downloads/Final Data/EEG.csv',header=T) 
(EEG <- tibble(EEG))
EEG[EEG['group']=='HC','group'] = '0'
EEG[EEG['group']=='AUD','group'] = '1'
EEG[EEG['group']=='IGD','group'] = '2'

EEG[EEG['sex']==2,'sex'] = 0
EEG['group'] = as.numeric(EEG[['group']])
EEG['sex'] = as.character(EEG[['sex']])



### Sure Independence Screening ####


data1 = EEG
## scaling
X = cbind(scale(subset(data1, select = -c(group,sex))),data1['sex'])
y = as.character(data1$group)
result1 <- step1(X,y)
new_X <- result1$new_X
ind <- result1$ind
final_ind <- step2(new_X,y,ind)
selected_var1 = na.omit(final_ind)


#### dataframe / xlsx 
columns = cbind(scale(subset(data1, select = -c(group,sex))),data1['sex'])

(var_names1 <- data.frame(X1=list(names(columns[selected_var1]))[[1]]))
dataset_names <- list('SIS' = var_names1)
openxlsx::write.xlsx(dataset_names, file = 'EEG_class4_selected_vars_trainset.xlsx') 





###################################### EEGHRV ######################################

EEGHRV <- read.csv('/Users/gyony/Downloads/Final Data/EEGHRV.csv',header=T,fileEncoding = "cp949") 
(EEGHRV <- tibble(EEGHRV))

EEGHRV[EEGHRV['group']=='HC','group'] = '0'
EEGHRV[EEGHRV['group']=='AUD','group'] = '1'
EEGHRV[EEGHRV['group']=='IGD','group'] = '2'

EEGHRV[EEGHRV['sex']==2,'sex'] = 0
EEGHRV['group'] = as.numeric(EEGHRV[['group']])
EEGHRV['sex'] = as.character(EEGHRV[['sex']])


data1 = EEGHRV

## scaling
X = cbind(scale(subset(data1, select = -c(group,sex))),data1['sex'])
y = as.character(data1$group)
result1 <- step1(X,y)
new_X <- result1$new_X
ind <- result1$ind
final_ind <- step2(new_X,y,ind)
selected_var1 = na.omit(final_ind)


#### dataframe / xlsx 
columns = cbind(scale(subset(data1, select = -c(group,sex))),data1['sex'])

(var_names1 <- data.frame(X1=list(names(columns[selected_var1]))[[1]]))
dataset_names <- list('SIS' = var_names1)
openxlsx::write.xlsx(dataset_names, file = 'EEGHRV_class4_selected_vars_trainset.xlsx') 





###################################### HRV ######################################

HRV <- read.csv('/Users/gyony/Downloads/Final Data/HRV.csv',header=T,fileEncoding = "cp949") 
(HRV <- tibble(HRV))

HRV[HRV['group']=='HC','group'] = '0'
HRV[HRV['group']=='AUD','group'] = '1'
HRV[HRV['group']=='IGD','group'] = '2'

HRV[HRV['sex']==2,'sex'] = 0
HRV['group'] = as.numeric(HRV[['group']])
HRV['sex'] = as.character(HRV[['sex']])

####### index 156 ######

step1 <- function(X,y){
  glm.aic = c()
  for (i in 1:ncol(X)){
    glm.aic[i] <- multinom(y ~ X[,i])$AIC  # aic 기준 
  }
  ind <- order(glm.aic)[1:length(X)] 
  new_X <- X[,ind]
  output = list(new_X=new_X, ind=ind)
  return(output)
}

### Sure Independence Screening ####
data1 = HRV
## scaling
X = cbind(scale(subset(data1, select = -c(group,sex))),data1['sex'])
y = as.character(data1$group)
result1 <- step1(X,y)
new_X <- result1$new_X
ind <- result1$ind
final_ind <- step2(new_X,y,ind)
selected_var1 = na.omit(final_ind)


#### dataframe / xlsx 
columns = cbind(scale(subset(data1, select = -c(group,sex))),data1['sex'])
(var_names1 <- data.frame(X1=list(names(columns[selected_var1]))[[1]]))
dataset_names <- list('SIS' = var_names1)
openxlsx::write.xlsx(dataset_names, file = 'HRV_class4_selected_vars_trainset.xlsx') 






############## Cli #################

clinical <- read.csv('/Users/gyony/Downloads/Final Data/clinical.csv',header=T,fileEncoding = "cp949") 
(clinical <- tibble(clinical))

clinical[clinical['group']=='HC','group'] = '0'
clinical[clinical['group']=='AUD','group'] = '1'
clinical[clinical['group']=='IGD','group'] = '2'

clinical[clinical['sex']==2,'sex'] = 0
clinical['group'] = as.numeric(clinical[['group']])
clinical['sex'] = as.character(clinical[['sex']])
clinical['X5.marriage'] = as.character(clinical[['X5.marriage']])


### Sure Independence Screening ####
data1 = clinical

## scaling
X = cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')])
y = as.character(data1$group)
result1 <- step1(X,y)
new_X <- result1$new_X
ind <- result1$ind
final_ind <- step2(new_X,y,ind)
selected_var1 = na.omit(final_ind)


#### dataframe / xlsx 
columns = cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')])
(var_names1 <- data.frame(X1=list(names(columns[selected_var1]))[[1]]))
dataset_names <- list('SIS' = var_names1)
openxlsx::write.xlsx(dataset_names, file = 'clinical_class4_selected_vars_trainset.xlsx') 




############## HRVCli #################

HRVCli <- read.csv('/Users/gyony/Downloads/Final Data/HRVCli.csv',header=T,fileEncoding = "cp949")
(HRVCli <- tibble(HRVCli))

HRVCli[HRVCli['group']=='HC','group'] = '0'
HRVCli[HRVCli['group']=='AUD','group'] = '1'
HRVCli[HRVCli['group']=='IGD','group'] = '2'

HRVCli[HRVCli['sex']==2,'sex'] = 0
HRVCli['group'] = as.numeric(HRVCli[['group']])
HRVCli['sex'] = as.character(HRVCli[['sex']])
HRVCli['X5.marriage'] = as.character(HRVCli[['X5.marriage']])



data1 = HRVCli

## scaling
X = cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')])
y = as.character(data1$group)
result1 <- step1(X,y)
new_X <- result1$new_X
ind <- result1$ind
final_ind <- step2(new_X,y,ind)
selected_var1 = na.omit(final_ind)  


#### dataframe / xlsx 
columns = cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')])
(var_names1 <- data.frame(X1=list(names(columns[selected_var1]))[[1]]))
dataset_names <- list('SIS' = var_names1)
openxlsx::write.xlsx(dataset_names, file = 'HRVCli_class4_selected_vars_trainset.xlsx') 










############## EEGHRVCli #################

EEGHRVCli <- read.csv('/Users/gyony/Downloads/final data/EEGHRVCli.csv',header=T,fileEncoding = "cp949") 
(EEGHRVCli <- tibble(EEGHRVCli))

EEGHRVCli[EEGHRVCli['group']=='HC','group'] = '0'
EEGHRVCli[EEGHRVCli['group']=='AUD','group'] = '1'
EEGHRVCli[EEGHRVCli['group']=='IGD','group'] = '2'

EEGHRVCli[EEGHRVCli['sex']==2,'sex'] = 0
EEGHRVCli['group'] = as.numeric(EEGHRVCli[['group']])
EEGHRVCli['sex'] = as.character(EEGHRVCli[['sex']])
EEGHRVCli['X5.marriage'] = as.character(EEGHRVCli[['X5.marriage']])


step1 <- function(X,y){
  glm.aic = c()
  for (i in 1:ncol(X)){
    glm.aic[i] <- multinom(y ~ X[,i])$AIC  # aic 기준 
  }
  ind <- order(glm.aic)[1:40] 
  new_X <- X[,ind]
  output = list(new_X=new_X, ind=ind)
  return(output)
}


### Sure Independence Screening ####
data1 = EEGHRVCli

## scaling
X = cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')])
y = as.character(data1$group)
result1 <- step1(X,y)
new_X <- result1$new_X
ind <- result1$ind
final_ind <- step2(new_X,y,ind)
selected_var1 = na.omit(final_ind)



#### dataframe / xlsx 
columns = cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')])
(var_names1 <- data.frame(X1=list(names(columns[selected_var1]))[[1]]))
dataset_names <- list('SIS' = var_names1)
openxlsx::write.xlsx(dataset_names, file = 'EEGHRVCli_class4_selected_vars_trainset.xlsx') 


########################### EEGCli #################################
######################################################################
EEGCli <- read.csv('/Users/gyony/Downloads/final data/EEGCli.csv',header=T,fileEncoding = "cp949") 
(EEGCli <- tibble(EEGCli))

EEGCli[EEGCli['group']=='HC','group'] = '0'
EEGCli[EEGCli['group']=='AUD','group'] = '1'
EEGCli[EEGCli['group']=='IGD','group'] = '2'

EEGCli[EEGCli['sex']==2,'sex'] = 0
EEGCli['group'] = as.numeric(EEGCli[['group']])
EEGCli['sex'] = as.character(EEGCli[['sex']])
EEGCli['X5.marriage'] = as.character(EEGCli[['X5.marriage']])


data1 = EEGCli

## scaling
X = cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')])
y = as.character(data1$group)
result1 <- step1(X,y)
new_X <- result1$new_X
ind <- result1$ind
final_ind <- step2(new_X,y,ind)
selected_var1 = na.omit(final_ind)


#### dataframe / xlsx 
columns = cbind(scale(subset(data1, select = -c(group,sex,X5.marriage))),data1[c('sex','X5.marriage')])
(var_names1 <- data.frame(X1=list(names(columns[selected_var1]))[[1]]))
dataset_names <- list('SIS' = var_names1)
openxlsx::write.xlsx(dataset_names, file = 'EEGCli_class4_selected_vars_trainset.xlsx') 




