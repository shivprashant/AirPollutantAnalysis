# Addresses Question 4 of the assignment http://goo.gl/rzjpek
# Question 3: Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999–2008?

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
if(FALSE == file.exists(dataFile1) | FALSE==file.exists(dataFile2)) {
  rm(dataFile1)
  rm(dataFile2)
  
  dataZipURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  downloadAndUnzip(dataZipURL)
}

message(dataFile1 , " in place for analysis. Carry on ...")

# Read the data.Loading frames takes a lot of time. 
# So Reload data only if you have to. Use forceDataFrameReload to 
# force enable re-loading.
forceDataFrameReload<-FALSE
if(FALSE == exists("NEI") | FALSE==exists("SCC")){
  forceDataFrameReload<-TRUE
}

if(TRUE == forceDataFrameReload) {
  NEI<-readRDS("summarySCC_PM25.rds")
  SCC<-readRDS("Source_Classification_Code.rds")
}

# Merge the 2 data sets together to get a common view.
# Merge takes too much time
if(FALSE == exists("NEI_SCC")) {
  NEI_SCC<-merge(NEI,SCC,ID="SCC")
}

#Open a deviceof type png, create plot and close device.
png(file="plot4.png", height=480, width=1000)

#Consider records where the EI.Sector contain Coal.
NEI_SCC_COAL<-NEI_SCC[grepl("Coal", NEI_SCC$'EI.Sector'),c("SCC", "fips", "Emissions", "year")]
qplot(year, Emissions, data=NEI_SCC_COAL, stat="summary", fun.y="sum", geom=c("point", "smooth"),
      xlab="Years",ylab="Total Emissions", main="Emissions from coal combustions related sources")

dev.off()