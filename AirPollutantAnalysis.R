library(ggplot2)
NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")
NEI_SCC<-merge(NEI,SCC,ID="SCC")

# Question 1: Have the total emissions of PM2 decreased over the years?
yearF<-split(NEI, NEI$year)
pollutantSum<-sapply(yearF,function(x) colSums(x[,c("Emissions","Emissions")]))

plot(c(1999,2002,2005,2008),pollutantSum[1,],"l",col="red")

# Question 2: Has the PM2 emission decreased in Baltimore, Maryland ( fips==24510)?
# Make a plot that answers this question.
NEI_Baltimore<-NEI[NEI$fips==24510,c(1,2,3,4,5,6)]
yearBaltiMore<-split(NEI_Baltimore, NEI_Baltimore$year)
pollutantSum_Baltimore<-sapply(yearBaltiMore,function(x) colSums(x[,c("Emissions","Emissions")]))

plot(c(1999,2002,2005,2008),pollutantSum_Baltimore[1,],"l",col="red")

# Question 3: Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which of these four sources 
# have seen decreases in emissions from 1999–2008 for Baltimore City?

qplot(year,Emissions, data=NEI_Baltimore, facets=.~type, stat="summary", fun.y="sum", geom=c("point","smooth"))

# Anwer3: All source but for POINT have shown a decrease.
#Question 4: Across the United States, how have emissions from coal 
#combustion-related sources changed from 1999–2008?


NEI_SCC_COAL<-NEI_SCC[grepl("Coal", NEI_SCC$'EI.Sector'),c("SCC", "fips", "Emissions", "year")]
qplot(year, Emissions, data=NEI_SCC_COAL, stat="summary", fun.y="sum", geom=c("point", "smooth"))

#Answer 4: Yes, the emissions from Coal based sources have reduced. With a substantial 
#reduction seen from 2006 to 2008.

#Question5:How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
NEI_SCC_VEHICALS_BALTI<-NEI_SCC[grepl("Vehicles", NEI_SCC$'EI.Sector') & (NEI_SCC$fips=='24510' | NEI_SCC$fips=='06037'),
                                c("SCC", "fips", "Emissions", "year")]

qplot(year,Emissions,data=NEI_SCC_VEHICALS_BALTI, stat="summary", fun.y="sum", geom=c("point", "smooth"), facets=.~fips)

#Answer 5: Emissions from vechicular traffic have greatly reduced over the year in Baltimore.

#Question 6: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, 
#California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

#Answer 6: Los Angeles has had a increase from 200 to 2006 followed by decline.



