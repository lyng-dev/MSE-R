import2<-function(filename){

	#Importing data
	DT <<- data.table::fread(filename, header=TRUE)

	#Adding keys for fast filtering
	#setkey(DT,Market,UpStream,DownStream)

	#Header names
	header <<- colnames(DT)

	#Calculating number of attributes
	noAttr <<- length(DT)-3-1

	#Calculating number of markets
	noM <<- length(unique(DT[[1]]))

	#Calculating number of up streams and down streams in each market
	noU <<- DT[, .(max(UpStream)), by=.(Market)]
	noD <<- DT[, .(max(DownStream)), by=.(Market)]

	#Calculating distance matrices
	distanceMatrices <<-1

	#Calculating matchMatrix
	matchMatrix <<-1

	#Calculating mate
	mate <<-1

	#return(list("header"=header,"noM"=noM,"noU"=noU,"noD"=noD,"noAttr"=noAttr,"distanceMatrices"=distanceMatrices,"matchMatrix"=matchMatrix,"mate"=mate))
}
