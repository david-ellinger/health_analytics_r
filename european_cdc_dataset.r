# European centre for disease prevention and control data sets

if(!require(pacman)) install.packages("pacman",repos = "http://cran.us.r-project.org")

pacman::p_load(utils, httr, dplyr, install = TRUE)

data <- read.csv("https://opendata.ecdc.europa.eu/covid19/casedistribution/csv", na.strings = "", fileEncoding = "UTF-8-BOM")

data_china <- filter(data, data$geoId=="CN")

data_us <- filter(data, data$geoId=="US")

ggplot(data_us, aes(x=dateRep, y=cases)) +
  geom_point(color = "darkred") +
  geom_smooth(method="auto", se=TRUE, color="darkred") +
  xlab("Date") + 
  ylab("Cases") +
  ggtitle("US: New Cases per Day")

ggplot(data_us) +
  geom_line(aes(rev(dateRep), cumsum(cases[order(cases)])), color = "darkred") +
  xlab("Date") +
  ylab("Cases") +
  ggtitle("US: Cummulative Cases")
