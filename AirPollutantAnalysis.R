#NEI_dataFrame<-readRDS("summarySCC_PM25.rds")
yearF<-split(NEI_dataFrame, NEI_dataFrame$year)
pollutantSum<-sapply(yearF,function(x) colSums(x[,c("Emissions","Emissions")]))
#str(pollutantSum)

plot(c(1999,2002,2005,2008),pollutantSum[1,],"l",col="red")