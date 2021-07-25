setwd(".")
source("mse.R")
filename<-"import/precomp_testdata.dat"
x<-import(filename)
g(header,noM,noU,noD,noAttr,distanceMatrices,matchMatrix,mate)%=%x

#Create payoffMatrix
Cx<-Cx(noAttr)
payoffMatrix<-CpayoffMatrix(noM,noU,noD,Cx,distanceMatrices,noAttr)

#Assign payoffMatrix numerical values (set x's)
#xval<-c(1,2)  # 3 attributesxval<-c(1,2,3,4) 
xval<-c(1,2,3,4)  # 5 attributes
payoffMatrix<-assignpayoffMatrix(payoffMatrix,xval)

#Create inequality members
ineqmembers<-Cineqmembers(mate)

#Create Data Array
dataArray<-CdataArray(distanceMatrices,ineqmembers)

#Objective function
coefficient1<-1
b<-Cx #Define x1,x2,... values
#obj<-objective(b)
#maximize function
#lower <- c(-10, -10)  # 3 attributes
lower <- c(-10, -10, -10, -10)  # 5 attributes
upper <- -lower
par<-list(lower=lower,upper=upper,NP=50,itermax=100,trace=FALSE,reltol=0.001,CR=0.5,F=0.6,RandomSeed=0)
x<-maximize(par)
g(bestmem,bestval)%=%x
print(bestmem)
print(bestval)

#Create groupIDs
groupIDs<-groupIDs(ineqmembers)
#ssSize<-3  # 3 attributes, markets to select
ssSize<-2  # 5 attributes, markets to select
options<-list()
options["progressUpdate"]<-1
options["confidenceLevel"]<-0.95
options["asymptotics"]<-"nests"
options["symmetric"]<-FALSE
numSubsamples<-50
pointEstimate<-as.numeric(bestmem)
#b<-Cx[2:3]
b<-Cx[2:5]
#lower <- c(-10, -10)  # 3 attributes
lower <- c(-10, -10, -10, -10)  # 5 attributes
upper <- -lower
par<-list(lower=lower,upper=upper,NP=50,itermax=100,trace=FALSE,reltol=0.001,CR=0.5,F=0.6,RandomSeed=0)
pointIdentifiedCR(ssSize, numSubsamples,pointEstimate,Cx,groupIDs,dataArray,options,par)