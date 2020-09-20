# Introduction to R
# Instructors:
# Ameet Doshi ameet.doshi@library.gatech.edu
# Jay Forrest jay.forrest@library.gatech.edu

# Getting Started
# You can find R at https://cran.r-project.org/
# You cand find R Studio at https://www.rstudio.com/

# Finding Inspiration
# R Graph Gallery:  https://www.r-graph-gallery.com/

# Creating a project
# File->New Project
# New Directory
# Empty R Project
# Let's call the new directory Rclass and save it to 
# the Documents folder. We can confirm the working 
# directory by using the getwd() command in an R file 
# or directly in the console
getwd()
# We can see files in our working directory in the 
# files box in the lower helright
# You can change the working directory by using setwd( dir ) 
# By using setwd() we see the structure of an 
# R function  FunctionName ( parameters )
# To view examples of any R command, simply list it as 
# a parameter of the help function
help(setwd)
# Help will tell us which R package the command comes from, 
# example usage, and information about the va

# Now lets create a simple program
# Create a new R file by going to File->New File->R Script
# An untitled window will open like this one.
# Press the save icon and call it RClass
# Note R files get a suffix of .R 
# At the top of the screen you can see if your work 
# is unsaved by the rust text and * after the .R
# the .Rproj file includes information about what windows are open, etc

# Start with a comment by using a hastag then space and then text.
# R does not execute comments
# For multiline comments use a # at the beginning of each 
# line R lines are 80 characters wide

setwd("Z:/INTRODUCTION_TO_R_STUDIO/")
setwd(choose.dir()) 

# My first R program
# now lets create a variable named introString and assign it 
# with the assignment operator <- a value
introString <- "Intro to R Studio"
# When we run the line we can see that the variable 
# now shows in the Environment pane

# Now lets print it to the console
print (      introString       ) # we can also make a comment after a line

# A note about the run command, R will try to execute up 
# to the current line
# So if I reassign introString, but place the cursor on in
# this line and use Run, I won't execute anything after this line
introString <- "Intro to R with Ameet and Jay"

# You can see in the console below what is running ihn 
# blue as well as any output
# You can also see your command history in the history 
# tab in the upper right 
# or by clicking the up arrow at the command line in the console

# Here are some style tips for make your R files easier 
# to understand and read: 
# https://google.github.io/styleguide/Rguide.xml

# Now that are data is ready we will add the rpart package 
# to do the analysis. There are over 13,800 packages that 
# folks have developed for R (and contributed to CRAN)
# These packages allow us to do specialized analysis based on 
# functions that others have coded
# You can find a list with brief descriptions here: 
# https://cran.r-project.org/web/packages/
# By clicking a link, you can find a full description of the package, 
# examples and what other packages are required
# Just as you would in the help file.
# I am going to install the corrplot package to my local instance of r.  
# Please note, I only need to do this once per install.
install.packages("corrplot")

# Now lets work with some data
# Lets grab some data from the UCI Machine Learning Repository
# http://archive.ics.uci.edu/ml/index.php
# Lets look at Bike Sharing: 
# https://archive.ics.uci.edu/ml/datasets/bike+sharing+dataset
# Download the Zip File, Open it, and Extract day.csv to your 
# R Working Directory
# Look at the files tab in the bottom right to confirm the file location

# Load the data file
capitalBikeShareData <- read.csv('day.csv', header = TRUE)
# capitalBikeShareData <- read.csv(file.choose(), header = TRUE)
# Here we created a new variable capitalBikeShareData, 
# and assigned it the values from a csv file.  
# We included the file name in single 
# quotes and as the first line of this file includes column names 
# We used the header parameter TRUE  (Numeric and Boolean values 
# as well as variables do not need quotes). Also, all of our 
# manipulation (later) is being done on the data frame, 
# not on the orginal data.

# In the environment tab we can see that myBike data contains 
# 16 attributes or variables and 731 observations or rows
# Lets look at the data
capitalBikeShareData

# We can also look at the first few or last few lines
head(capitalBikeShareData)

# Or last few lines
tail(capitalBikeShareData)

# we can also specify how main lines to display
tail(capitalBikeShareData, n=10L)
sampleDataFrame <- tail(capitalBikeShareData, n=10L)

# Lets compare this data to the metadata from the originating site


# Now lets do some basic comparisons, like min/max, quartiles 
# and median values
summary(capitalBikeShareData)

# Lets plot two variables to see if they relate
plot(capitalBikeShareData$casual, capitalBikeShareData$windspeed)

# The first two parametes of plot are the x and y values, 
# we can plot against any data set that we have
# and we can pick variables by calling them after the $

# What does this chart tell us?
# Lets look at the correlation coefficient
cor(capitalBikeShareData$casual, capitalBikeShareData$windspeed)

# Correlation provides a value between -1 and 1 that tells us 
# about the strength and direction of two variables
# In this example we see a weak negative correlation, 
# lower wind speeds correlate to more riders

# Now lets create a regression model
fit <-lm(casual ~ windspeed, data=capitalBikeShareData)
# We named the model fit and assigned it the result of a 
# linear model where 
# the dependent variable is casual
# we have one independent variable, windspeed
# and or data is coming from the capitalBikeShareData data set

# We can also write the model like this
fit <-lm(capitalBikeShareData$casual ~ capitalBikeShareData$windspeed)

# Calling fit will display the formula and coefficients
fit

# Summary fit will give us additional details
summary(fit)

# We can see how well our model fits the data by looking at the r-squared
# R squared is a value between 0 and 1 and values closer to 1
# have a better goodness of fit

# What other variables do you think would work?


# Correlation coefficients, please note that R is 1 indexed
cleanBikeData <- capitalBikeShareData[ , -(2)] 
# we need to remove the non-numeric columns
# Here is what we are doing
# We are creating a new data frame cleanBikeData
# pulling data from capitalBikeShareData
# pulling all rows -- [ ,
# and remove the second column -- -(2)]
round(cor(cleanBikeData),2) # rounding for display

# This is a little hard to read just as a text file, so lets use a package,
# to see a graphical version.  We will talk about installing packages
# a little later.
# install.packages("corrplot") # installing the corrplot package
library(corrplot) # activating the corrplot package
corrplot(cor(cleanBikeData))

# Note the autocorrelation between temp & atemp and cnt & registered, 
# we may use 1, but should not use both of these variables

# From the correlation matrix we can see better correlations 
# (closer to 1 or -1) between casual and year, season, workingday, 
# temp, atemp, and cnt
# Why might we exclude some of these values?
# A better model?
multivariateFit2 <-lm(capitalBikeShareData$casual ~ 
                        capitalBikeShareData$workingday + 
                        capitalBikeShareData$temp)

summary(multivariateFit2)

# Data Visualization with R
# ggplot2 resources
# ggplot2 Cheat Sheet: 
# https://github.com/rstudio/cheatsheets/raw/master/data-visualization-2.1.pdf

# R Graph Gallery
# https://www.r-graph-gallery.com/

# Elegant Graphics for Data Analysis (2016): https://bit.ly/2HHpws1
# 
# Safari Books Online:
# https://learning.oreilly.com/library/view/applied-data-visualization/9781789612158/
#  
# Grammar of Graphics (2005): https://bit.ly/2CCsn1j

library(ggplot2)
library(RColorBrewer)

# RColorBrewer provides an extended set of palettes that we can use in our graphs
# The following function will show the available color sets
display.brewer.all()

# For a full cheatsheet on color see: 
# https://www.nceas.ucsb.edu/~frazier/RSpatialGuides/colorPaletteCheatsheet.pdf

# For most of the workshop, we will use iris data set.
# Iris is built-in, relatively simple and has both discrete and continuous variables
# Take a moment to look at the data set, and not the capitalization in the col names
data("iris")
summary(iris)
?(iris)
# https://en.wikipedia.org/wiki/Sepal#/media/File:Petal-sepal.jpg

# To better understand ggplot, one needs to understand the theory underlying the script -- The Grammar of Graphics 
# Grammar of Graphics - 7 layers
# Data - data to plot
# Aesthetics - position, size, color, shape
# Geometries - visual element to plot (points, lines, polygons)
# Facets - subsets of data
# Statistics - statistical transformation of data
# Coordinates - surface of the plot (cartesian, map, polar, ...)
# Themes - non-data elements

# One can see how the basic template for ggplot leverages the grammar of graphics.
# We encourage you to run this code incrementally (66-67 up to the + sign, 
# lines 66-68 up to the second plus sign, etc ) to see how each layer updates the
# graph.  This is a good practice for all of the graphs that are part of this workshop
# Basic template for ggplot2
ggplot(data = iris,     # Data Layer
       aes(x=Petal.Length, fill=Species)) +  # Aesthetics Layer
  geom_bar() + # Geometry Layer
  coord_flip() + # Coordinates Layer
  facet_wrap(~Species) +  # facets
  stat_bin(binwidth=0.5, color="white") + # Statistics Function
  theme(legend.position="none") + # Theme
  scale_fill_brewer(palette="PuRd") # Change Color of a discrete palette 

# Now we will go through some of the options available to each layer of the grammar
# Beginning with the Aesthetics: 
# Aesthetics gives us several ways of displaying features: 
# color, fill, alpha, group, size, linetype, shape
# generally linetype and shape are not used in favor of other aesthetics that are 
# easier for the human eye to distinguish
# cf https://ggplot2.tidyverse.org/articles/ggplot2-specs.html
# Note adding to aesthetics layer will also add a legend for that feature by default

# Here is a basic scatter plot that describes three variables:
# a discrete variable (Species) on the x axis,
# a continuous variable Petal.Length on the y axis, and
# a calculated measure, based on the petal area
# note that the plus symbol allows us to combine elements
# + should be the last symbol on a line for multiline ggplot scripts
ggplot(data=iris, aes(x=Species, y=Petal.Length, color=Petal.Width * Petal.Length)) +
  geom_point() 

# Blue is the default color gradient in ggplot, but we can add a scale element
# to change that gradient.  scale_color_* updates the color aesthetic, 
# _gradientn allows to create a new gradient (useful for continuous variables)
# and define the color palette, rainbow, and the number of steps in the palette (15)
ggplot(data=iris, aes(x=Species, y=Petal.Length, color=Petal.Width * Petal.Length)) +
  geom_point() + 
  scale_color_gradientn(colors = rainbow(15))

# In the next example, we add a size aesthetic based on sepal area, and modify the 
# color aesthetic to map to Petal.Width 
# The color gradient is modified as well to show other examples
ggplot(data=iris, aes(x=Species, y=Petal.Length, size=Sepal.Width * Sepal.Length,
                      color=Petal.Width)) +
  geom_point() + 
  scale_color_gradientn(colors = heat.colors(15))

# The overlapping points make it difficult to see the distribution of Petal.Length
# so let's update the aesthetic to add transparency using alpha=%, in this case .1
# also another colorramp
ggplot(data=iris, aes(x=Species, y=Petal.Length, size=Sepal.Width * Sepal.Length,
                      alpha=0.1, color=Petal.Width)) +
  geom_point() + 
  scale_color_gradientn(colors = terrain.colors(15))

# Adding Jitter can further show the variations in data, by adding random noise 
# within a feature, in this case species.  Fixed values, Petal.Length, are not
# modified.  To jitter we replace geom_point() with geom_jitter()
ggplot(data=iris, aes(x=Species, y=Petal.Length, size=Sepal.Width * Sepal.Length,
                      color=Petal.Width)) +
  geom_jitter(alpha=0.1) + 
  scale_color_gradientn(colors = topo.colors(15))

# Geometries: https://ggplot2.tidyverse.org/reference/index.html#section-layer-geoms

# A linear trend matches best with the versicolor species, but not well with the other two species, so for 
# the overall trend we next use the loess method instead of lm
# for a list of named colors: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
ggplot(data=iris, aes(x=Petal.Width, y=Petal.Length)) + 
  geom_point(aes(col=Species)) + 
  geom_smooth(method=loess, se=FALSE, color="darkorchid4") +
  geom_smooth(method=lm, aes(col=Species)) 

# Coordinates & Scales
# c.f. https://ggplot2.tidyverse.org/reference/index.html#section-coordinate-systems
# c.f. https://ggplot2.tidyverse.org/reference/index.html#section-scales

# Statistics
# https://ggplot2.tidyverse.org/reference/index.html#section-layer-stats

# Themes
# https://ggplot2.tidyverse.org/reference/theme.html

#################
# Diverging bars using ggplot2
# Define the base theme
theme_set(theme_bw())  

# Data Preparation
data("mtcars")  # load data
mtcars$`car name` <- rownames(mtcars)  # create new column for car names
mtcars$mpg_z <- round((mtcars$mpg - mean(mtcars$mpg))/sd(mtcars$mpg), 2)  # compute normalized mpg 
mtcars$mpg_type <- ifelse(mtcars$mpg_z < 0, "below", "above")  # above / below avg flag
mtcars <- mtcars[order(mtcars$mpg_z), ]  # sort
mtcars$`car name` <- factor(mtcars$`car name`, levels = mtcars$`car name`)  # convert to factor to retain sorted order in plot.

# Diverging Barcharts
# scale_fill_manual allows you to manually set the labels and label colors
ggplot(mtcars, aes(x=`car name`, y=mpg_z, label=mpg_z)) + 
  geom_bar(stat='identity', aes(fill=mpg_type), width=.5)  +
  scale_fill_manual(name="Mileage", 
                    labels = c("Above Average", "Below Average"), 
                    values = c("above"="gold", "below"="navy")) + 
  labs(subtitle="Normalised mileage from 'mtcars'", 
       title= "Diverging Bars") + # add a title and subtitle
  coord_flip() # flip x-y axis


##################
## Diverging dot plot
## same data set using a dot plot

# Plot
ggplot(mtcars, aes(x=`car name`, y=mpg_z, label=mpg_z)) + 
  geom_point(stat='identity', aes(col=mpg_type), size=6)  +
  scale_color_manual(name="Mileage", 
                     labels = c("Above Average", "Below Average"), 
                     values = c("above"="#ffd700", "below"="#003366")) + 
  geom_text(color="white", size=2) +
  labs(title="Diverging Dot Plot", 
       subtitle="Normalized mileage from 'mtcars': Dotplot") + 
  ylim(-2.5, 2.5) +
  coord_flip()

# A large dataset
install.packages("nycflights13")
library(nycflights13)

# Helper packages - meet skimr
install.packages("skimr")
library(skimr)

summary(flights)
skimr::skim(flights)

factor(flights$carrier)
table(flights$carrier)

# Corrplot
corrplot::corrplot(cor(flights[complete.cases(flights),c("air_time", "distance",
                                           "arr_delay", "dep_delay", "day", 
                                           "dep_time", "month", "hour",
                                           "sched_dep_time", "sched_arr_time")]))


# Decision Tree - Basic Analysis
# We will use the rpart package to create a decision tree,
# so lets install rpart, and then call it as a library
# And do the same for the rpart.plot which contains the 
# titanic data and a better plotting tool
install.packages("rpart")
install.packages("rpart.plot")
install.packages("rattle")
install.packages("RColorBrewer")
library(rpart)
library(rattle)
library(rpart.plot)
library(RColorBrewer)

data("ptitanic")

# creating a decision tree
# note that ~. is a short cut for all columns
# the cp argument is a complexity parameter: 
# Any split that does not decrease the overall lack of fit 
# by a factor of cp is not attempted. 
decisionTreeBinary <- rpart(survived ~ . , data = ptitanic, cp=0.12)
fancyRpartPlot(decisionTreeBinary)

# Each node shows
# - the predicted class (died or survived),
# - the predicted probability of survival,
# - the percentage of observations in the node.


# Decision Tree Full Analysis
# We are also going to install some helper packages to do the decision tree analysis
install.packages("caret")
install.packages('e1071', dependencies=TRUE)
install.packages('tidyverse')

library(caret)
library(tidyverse)


# In Decision Trees we split data into train and test sets, 
# we use training data to develop the model, and then we verify
# the model with new or test data.  The titanic package
# already provides a train and test data set.
# Here we create on the training data by creating a new variable
# decisionTreeBinary which uses rpart to model survivorship (our class)
# variable, based on all of the available data ~ .  
# using the titanic_train data
# cp = is the complexity factor, it controls how many branches our 
# decision tree will have.  It will ignore any split that does not decrease
# the overall lack of fit by the factor indicated.


data("ptitanic")

summary(ptitanic)

# Remove rows that contain NAs

ptitanic <- ptitanic %>% filter(!is.na(age))


# Since we are going to randomly select, we are setting a seed so that we get similar results
set.seed(3033)

# We are going to train on 80% of our data and test on 20%, so we will split the data
inTrain <- createDataPartition(y=ptitanic$survived, p=0.8, list=F)
training <- ptitanic[inTrain,] 
testing <- ptitanic[-inTrain,]

decisionTree <- rpart(survived ~ . , data = training, cp=0.12)

# We can graph the model
# For each element on the graph we see three numbers
# Top is the survivorship rate the % survived at this level
# Bottom Left = number of observations
# Bottom Right = % of observations
# At each split (in this case a binary split), left = True, right = False
# At the first split, males are evaluated further on the left, females on the right

fancyRpartPlot(decisionTree)

# Deciding cp with trainControl and train

myControl <- trainControl(method ="repeatedcv", 
                          number = 10,
                          repeats = 3,
                          savePredictions = "final",
                          search = "random",
                          verboseIter = FALSE)

model <- train(survived ~. , data = training,
               method = "rpart",
               trControl =  myControl,
               tuneLength = 5)

decisionTree2 <- rpart(survived ~ . , data = training, cp=0.005847953)
fancyRpartPlot(decisionTree2)

# Now lets see our how model works with new data
test_pred <- predict(decisionTree2, newdata = testing, type='class')
confusionMatrix(test_pred, testing$survived)