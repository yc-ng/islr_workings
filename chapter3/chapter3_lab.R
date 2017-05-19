# Lab 3.6.1: Libraries --------------------------------------------------------

library(MASS)
library(ISLR)
data("Boston")

# Lab 3.6.2: Simple Linear Regression -------------------------------------------

# View(Boston)
# names(Boston)

# crim: per capita crime rate by town.
# zn: proportion of residential land zoned for lots over 25,000 sq.ft.
# indus: proportion of non-retail business acres per town.
# chas: Charles River dummy variable (= 1 if tract bounds river; 0 otherwise).
# nox: nitrogen oxides concentration (parts per 10 million).
# rm: average number of rooms per dwelling.
# age: proportion of owner-occupied units built prior to 1940.
# dis: weighted mean of distances to five Boston employment centres.
# rad: index of accessibility to radial highways.
# tax: full-value property-tax rate per \$10,000.
# ptratio: pupil-teacher ratio by town.
# black: 1000(Bk - 0.63)^2 where Bk is the proportion of blacks by town.
# lstat: lower status of the population (percent).
# medv: median value of owner-occupied homes in \$1000s.

# build linear model
lm_fit <- lm(medv~lstat, data = Boston)

# get model information
summary(lm_fit)

# get regression coefficients (2 ways)
coef(lm_fit)
print(lm_fit$coefficients)

# get confidence intervals of regression coefficients
confint(lm_fit)

# get confidence/prediction intervals for predicted medv values based on lstat
# at 5, 10, 15
predict(lm_fit, data.frame(lstat = c(5,10,15)), interval = "confidence")
predict(lm_fit, data.frame(lstat = c(5,10,15)), interval = "prediction")

# plot medv against lstat
plot(medv ~ lstat, data = Boston)
plot(medv ~ lstat, data = Boston, col = "red") # uses red hollow circles
plot(medv ~ lstat, data = Boston, pch = 20) # uses solid circles
plot(medv ~ lstat, data = Boston, pch = "+") # uses the '+' character

# plot(1:20, 1:20, pch = 1:20) to view pch visually

# fit least squares regression line
abline(lm_fit)
abline(lm_fit, lwd = 3)
abline(lm_fit, lwd = 3, col = "red")

# examine diagnostic plots (4 plots in total)
par(mfrow = c(2, 2))
plot(lm_fit)

par(mfrow = c(1, 2))
# examine residuals vs fitted values
plot(predict(lm_fit), residuals(lm_fit))
# examine studentized residuals vs fitted values
plot(predict(lm_fit), rstudent(lm_fit))

par(mfrow = c(1, 1))
# plot leverage statistics
plot(hatvalues(lm_fit))
# (mouseclick to) mark highest leverage index
identify(hatvalues(lm_fit))
# find index of largest element
largest <- which.max(hatvalues(lm_fit))
Boston$lstat[largest]


# Lab 3.6.3: Multiple Linear Regression ------------------------------------

# medv against lstat and age
lm_fit_2var <- lm(medv ~ lstat + age, data = Boston)
summary(lm_fit_2var)

# medv against all 13 variables
lm_fit_all <- lm(medv ~ ., data = Boston)
summary(lm_fit_all)

summary(lm_fit_all)$r.sq  # r-squared value
summary(lm_fit_all)$sigma # RSE (residual standard error)

# Variance inflation factors VIF
car::vif(lm_fit_all)

# remove age from other predictors and fit model
lm_fit_select <- lm(medv ~ . - age, data = Boston)
summary(lm_fit_select)

# update and refit model by removing indus
lm_fit_select1 <- update(lm_fit_select, ~ .-indus)
summary(lm_fit_select1)


# Lab 3.6.4: Interaction Terms --------------------------------------------

# lstat:age is the interaction term
lm_lstat_x_age <- lm(medv ~ lstat * age, data = Boston)
summary(lm_lstat_x_age)

# Lab 3.6.5: Non-linear Transformations of the Predictors --------------------------------------------------------------

# include a predictor lstat^2 using I()
lm_fit_quadratic <- lm(medv ~ lstat + I(lstat^2), data = Boston)
summary(lm_fit_quadratic)

# conduct ANOVA to test the two models
anova(lm_fit, lm_fit_quadratic)
# null hyp: both models fit the data equally well
# alt hyp: full model fits the data better

# regression diagnostics for quadratic model
par(mfrow = c(2,2))
plot(lm_fit_quadratic)

# fifth-order poly model
lm_fit_fifth <- lm(medv ~ poly(lstat, 5), data = Boston)
summary(lm_fit_fifth)

# log transformation
summary(lm(medv ~ log(rm), data = Boston))


# Lab 3.6.6: Qualitative Predictors ---------------------------------------

data("Carseats")
names(Carseats)

# model with some interaction terms
lm_qualitative <- lm(Sales ~ . + Income:Advertising + Price:Age,
                     data = Carseats)
summary(lm_qualitative)

# view contrasts (dummy variables) for ShelveLoc
contrasts(Carseats$ShelveLoc)
# ShelveLocGood: 1 if "Good", 0 if "Bad" or "Medium"
# ShelveLocMedium: 1 if "Medium", 0 if "Bad" or "Good"