# Chapter 2 Ex - Q8 -------------------------------------------------------

# This exercise relates to the College data set, which can be found in the file
# College.csv . It contains a number of variables for 777 different universities
# and colleges in the US.

# (a) Use the read.csv() function to read the data into R. Call the loaded
# data college . Make sure that you have the directory set to the correct
# location for the data.
college <- read.csv("../data/College.csv")

# (b) Look at the data using the fix() function. You should notice that the
# first column is just the name of each university. We don't really want R to
# treat this as data. However, it may be handy to have these names for later.
# Try the following commands:
rownames(college)=college [,1]
fix(college)

# You should see that there is now a row.names column with the name of each
# university recorded. This means that R has given each row a name corresponding
# to the appropriate university. R will not try to perform calculations on the
# row names. However, we still need to eliminate the first column in the data
# where the names are stored. Try
college=college [,-1]
fix(college)

# Now you should see that the first data column is Private . Note that another
# column labeled row.names now appears before the Private column. However, this
# is not a data column but rather the name that R is giving to each row.

# (c) i. Use the summary() function to produce a numerical summary of the
# variables in the data set.
summary(college)

# ii. Use the pairs() function to produce a scatterplot matrix of the first ten
# columns or variables of the data. Recall that you can reference the first ten
# columns of a matrix A using A[,1:10] .
pairs(college[,1:10])

# iii. Use the plot() function to produce side-by-side boxplots of Outstate
# versus Private.
plot(college$Private, college$Outstate, 
     xlab = "Private", ylab = "Out-of-State Tuition")

# iv. Create a new qualitative variable, called Elite , by binning the Top10perc
# variable. We are going to divide universities into two groups based on whether
# or not the proportion of students coming from the top 10% of their high school
# classes exceeds 50%.

# Elite=rep("No",nrow(college))
# Elite[college$Top10perc >50]=" Yes"
# Elite=as.factor(Elite)
# college=data.frame(college ,Elite)

college$Elite <- factor(ifelse(college$Top10perc > 50, "Yes", "No"), 
                        levels = c("Yes", "No"))

# Use the summary() function to see how many elite universities there are. Now 
# use the plot() function to produce side-by-side boxplots of Outstate versus
# Elite .

summary(college$Elite)
plot(college$Elite, college$Outstate, 
     xlab = "Elite", ylab = "Out-of-State Tuition")

# v. Use the hist() function to produce some histograms with differing numbers
# of bins for a few of the quantitative variables. You may find the command
# par(mfrow=c(2,2)) useful: it will divide the print window into four regions so
# that four plots can be made simultaneously. Modifying the arguments to this
# function will divide the screen in other ways.

attach(college)
par(mfrow = c(2,2))
hist(S.F.Ratio)
hist(Top25perc)
hist(Room.Board)
hist(Expend)
detach(college)

# vi. Continue exploring the data, and provide a brief summary
# of what you discover.


# Chapter 2 Ex - Q9 -------------------------------------------------------

# 9. This exercise involves the Auto data set studied in the lab. Make sure that
# the missing values have been removed from the data.
Auto <- read.csv("Auto.csv",header = TRUE, na.strings ="?")
auto_complete <- na.omit(Auto)

# (a) Which of the predictors are quantitative, and which are qualitative?
summary(auto_complete)

# quantitative: mpg, displacement, horsepower, weight, acceleration
# qualitative: cylinder, origin, year

# (b) What is the range of each quantitative predictor? You can answer this
# using the range() function.
quants <- c("mpg", "displacement", "horsepower", "weight", "acceleration")
t(sapply(auto_complete[,quants], range))

# (c) What is the mean and standard deviation of each quantitative predictor?
sapply(auto_complete[,quants], mean)
sapply(auto_complete[,quants], sd)

# (d) Now remove the 10th through 85th observations. What is the range, mean,
# and standard deviation of each predictor in the subset of the data that
# remains?
auto_partial <- auto_complete[-(10:85),]
sapply(auto_partial[,quants], mean)
sapply(auto_partial[,quants], sd)

# (e) Using the full data set, investigate the predictors graphically, using
# scatterplots or other tools of your choice. Create some plots highlighting the
# relationships among the predictors. Comment on your findings.
plot(Auto[,quants], pch = 1, cex = 0.6)
plot(Auto, pch = 16, cex = 0.7)

# (f) Suppose that we wish to predict gas mileage ( mpg ) on the basis
# of the other variables. Do your plots suggest that any of the
# other variables might be useful in predicting mpg ? Justify your
# answer.

# displacement, horsepower, weight might be useful for predicting mpg as the 
# graphical plots suggests that there might be a strong curvilinear relationship
# between each of these variables and mpg - most of the points fall within a
# narrow region on the plot(s).

# cylinders, year and origin may also be possible predictors for mpg but the
# relationship between mpg and these qualitative variables are much weaker.


# Chapter 2 Ex - Q10 ------------------------------------------------------

# This exercise involves the Boston housing data set.

# (a) To begin, load in the Boston data set. The Boston data set is part of the
# MASS library in R.
library (MASS)

# Now the data set is contained in the object Boston.
View(Boston)
# Read about the data set:
?Boston

# How many rows are in this data set? How many columns? What do the rows and
# columns represent?
dim(Boston)
# 506 rows, 14 columns
# rows represent a single town in the Boston area.
# columns represent a single measurement for all the towns in the Boston area.

# Plot histograms for each variable in Boston
omar <- c(5, 4, 4, 2) + 0.1
par(mar = c(3, 2, 2, 1), mfrow = c(4, 4))
lapply(names(Boston), 
       FUN = function(v) hist(Boston[, v], main = paste("Histogram of", v)))

# reset graphical parameters
par(mar = omar, mfrow = c(1,1))

# (b) Make some pairwise scatterplots of the predictors (columns) in
# this data set. Describe your findings.
pairs(Boston, pch = 1, cex = 0.8)

# (c) Are any of the predictors associated with per capita crime rate?
# If so, explain the relationship.
attach(Boston)
plot(medv, crim)

# chas (negative) - towns bounding river are more visible, thus deterring crime rates

# nox (positive) - increased air pollution might correlate with lower levels of
# development/urbanisation which in turn correlates with higher crime rates

# rm (negative) - more rooms per dwelling might be a result of higher standards
# of living which also leads to lower crime rates

# rad (positive) - crime is harder to spot/report in towns not easily acessible
# from highways, and it is more difficult for law enforcement to monitor 
# towns further away from highways

# age (positive) - towns with more older (pre-1940) units may be underdeveloped
# relative to newer towns and thus suffer from lower standards of living

# lstat (positive) - lower (socioeconomic) status may be a factor for higher
# crime rates

# medv (negative) - lower value homes may be correlated with lower levels of
# development and standards of living, which in turn may be related to higher
# crime.

# (d) Do any of the suburbs of Boston appear to have particularly
# high crime rates? Tax rates? Pupil-teacher ratios? Comment on
# the range of each predictor.
t(sapply(Boston, fivenum))
t(sapply(Boston, range))
# 

# A very small number of suburbs have very high crime rates (over 60)
hist(crim)
range(crim)

# A very significant number of suburbs have very high tax rates (more thn 650)
truehist(tax)
range(tax)

# many suburbs have a pupil-teacher ratio of over 20
hist(ptratio)
range(ptratio)

# (e) How many of the suburbs in this data set bound the Charles
# river?
summary(factor(Boston$chas))
sum(Boston$chas == 1)
# 35

# (f) What is the median pupil-teacher ratio among the towns in this
# data set?
median(ptratio)
# 19.05

# (g) Which suburb of Boston has lowest median value of owner-occupied homes?
# What are the values of the other predictors for that suburb, and how do those
# values compare to the overall ranges for those predictors? Comment on your
# findings.
min(medv) #5
Boston[which.min(Boston$medv),]
# significant predictors for this suburb include
# rm: low
# age: maximum (all houses are pre-1940)
# rad: maximum (most inaccessible to highways)
# tax: high (high property-tax rate)
# lstat: high 

# (h) In this data set, how many of the suburbs average more than
# seven rooms per dwelling? More than eight rooms per dwelling?
# Comment on the suburbs that average more than eight rooms
# per dwelling.
sum(Boston$rm > 7) 
# 64
sum(Boston$rm > 8)
# 13

# suburbs that average more than eight rooms per dwelling
Boston[Boston$rm > 8, ]
