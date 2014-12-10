NEI_dataFrame<-readRDS("summarySCC_PM25.rds")

# Question 1: Have the total emissions of PM2 decreased over the years?
yearF<-split(NEI_dataFrame, NEI_dataFrame$year)
pollutantSum<-sapply(yearF,function(x) colSums(x[,c("Emissions","Emissions")]))

plot(c(1999,2002,2005,2008),pollutantSum[1,],"l",col="red")

# Question 2: Has the PM2 emission decreased in Baltimore, Maryland ( fips==24510)?
# Make a plot that answers this question.
NEI_dataFrame_Baltimore<-NEI_dataFrame[NEI_dataFrame$fips==24510,c(1,2,3,4,5,6)]
yearBaltiMore<-split(NEI_dataFrame_Baltimore, NEI_dataFrame_Baltimore$year)
pollutantSum_Baltimore<-sapply(yearBaltiMore,function(x) colSums(x[,c("Emissions","Emissions")]))

plot(c(1999,2002,2005,2008),pollutantSum_Baltimore[1,],"l",col="red")

# Question 3: Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which of these four sources 
# have seen decreases in emissions from 1999–2008 for Baltimore City?



