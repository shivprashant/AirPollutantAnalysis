# Addresses Question 1 of the assignment http://goo.gl/rzjpek
# Question 1: Have the total emissions of PM2 decreased over the years?

library(ggplot2)

downloadAndUnzip<-function(url) {
  SUCCESS<-0
  tempZipFile<-"temp.zip"
  if(SUCCESS == download.file(url,destfile=tempZipFile,method="auto")){
    message("Finished downloading...")
    #unzip the downloaded file and delete the temporary zip file.
    unzip(tempZipFile)
    rm(tempZipFile) 
  }
  else{
    message("Downloading failed")
  }
}

#Download the zip file unzip it to get 2 data files. File are summarySCC_PM25.rds 
#and Source_Classification_Code.rds
dataFile1<-"summarySCC_PM25.rds"
dataFile2<-"Source_Classification_Code.rds"

#Check that both the files exist. If not download.
if(FALSE == file.exists(dataFile1)) {
  rm(dataFile1)
  rm(dataFile2)
  
  dataZipURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  downloadAndUnzip(dataZipURL)
}

message(dataFile1 , " in place for analysis. Carry on ...")



#Read the data
NEI<-readRDS("summarySCC_PM25.rds")
#SCC<-readRDS("Source_Classification_Code.rds")
#NEI_SCC<-merge(NEI,SCC,ID="SCC")


yearF<-split(NEI, NEI$year)
pollutantSum<-sapply(yearF,function(x) colSums(x[,c("Emissions","Emissions")]))

#Open a deviceof type png, create plot and close device.
png(file="plot1.png", height=480, width=480)

plot(c(1999,2002,2005,2008),pollutantSum[1,],"l",col="red" ,ylab="Total Pollutants", xlab="Years")

dev.off()