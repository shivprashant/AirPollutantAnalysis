# Addresses Question 3 of the assignment http://goo.gl/rzjpek
# Question 3: Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which of these four sources 
# have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

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

# Read the data.Loading frames takes a lot of time. 
# So Reload data only if you have to. Use forceDataFrameReload to 
# force enable re-loading.
if(FALSE == exists("NEI")){
  NEI<-readRDS("summarySCC_PM25.rds")
}

forceDataFrameReload<-FALSE
if(0 == nrow(NEI) | TRUE == forceDataFrameReload) {
  NEI<-readRDS("summarySCC_PM25.rds")
}

#Open a deviceof type png, create plot and close device.
png(file="plot3.png", height=480, width=1000)

#SubSet the data to Baltimore and use qplot.
#qplot 'stat' parameter can be used to sum up the values on the y-axis.
NEI_Baltimore<-NEI[NEI$fips==24510,c(1,2,3,4,5,6)]
qplot(year,Emissions, data=NEI_Baltimore, facets=.~type, stat="summary", 
      fun.y="sum", geom=c("point","smooth"),
      xlab="Years", ylab="Total PM2.5 emissions",
      main="Total PM2.5 emissions in Baltimore from each of the sources")


dev.off()