# Addresses Question 6 of the assignment http://goo.gl/rzjpek
# Question 6: Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, 
# California (fips == 06037). 
# Which city has seen greater changes over time in motor vehicle emissions?

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
png(file="plot6.png", height=480, width=1000)

#Consider records where the EI.Sector contain Vehicals
#SubSet data for baltimore and los angles using respective fips values.
NEI_SCC_VEHICALS_BALTI<-NEI_SCC[grepl("Vehicles", NEI_SCC$'EI.Sector') & 
                                (NEI_SCC$fips=='24510' | NEI_SCC$fips=='06037'),
                                c("SCC", "fips", "Emissions", "year")]

qplot(year,Emissions,data=NEI_SCC_VEHICALS_BALTI, stat="summary", fun.y="sum", 
      geom=c("point", "smooth"), facets=.~fips,
      xlab="Years", ylab="Total Emissions", 
      main="Total Emissions from Vechical source for Baltimore City and Los Angles")
dev.off()