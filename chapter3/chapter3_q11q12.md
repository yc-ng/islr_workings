Chapter 3 Exercises - Questions 11, 12
================

-   [Question 11](#question-11)
    -   [Part 11a](#part-11a)
    -   [Part 11b](#part-11b)
    -   [Part 11c](#part-11c)
    -   [Part 11d (in progress)](#part-11d-in-progress)
    -   [Part 11e](#part-11e)
    -   [Part 11f](#part-11f)
-   [Question 12](#question-12)
    -   [Part 12a](#part-12a)
    -   [Part 12b](#part-12b)
    -   [Part 12c (Needs review)](#part-12c-needs-review)

Question 11
-----------

*In this problem we will investigate the t-statistic for the null hypothesis H<sub>0</sub> : β = 0 in simple linear regression without an intercept. To begin, we generate a predictor x and a response y as follows.*

``` r
set.seed(1)
x <- rnorm(100)
y <- 2 * x + rnorm(100)
```

### Part 11a

*Perform a simple linear regression of y onto x , without an intercept. Report the coefficient estimate ˆβ, the standard error of this coefficient estimate, and the t-statistic and p-value associated with the null hypothesis H<sub>0</sub>: β = 0. Comment on these results. (You can perform regression without an intercept using the command `lm(y ~ x + 0)`.)*

``` r
nointercept_yx_lm <- lm(y ~ x + 0)
summary(nointercept_yx_lm)$coefficients
```

    ##   Estimate Std. Error  t value     Pr(>|t|)
    ## x 1.993876  0.1064767 18.72593 2.642197e-34

The estimated coefficient ˆβ is very close to the true value of β (which is 2). The standard error for ˆβ is also very small relative to the estimated value, which creates a very large t-statistic and very small p-value.
The likelihood of obtaining this estimate of β, assuming the null hypothesis is true, would be this p-value, and so we can infer that this is unlikely and thus reject the null hypothesis. Therefore we conclude that there is some relationship between X and Y.

### Part 11b

*Now perform a simple linear regression of x onto y without an intercept, and report the coefficient estimate, its standard error, and the corresponding t-statistic and p-values associated with the null hypothesis H<sub>0</sub>: β = 0. Comment on these results.*

``` r
nointercept_xy_lm <- lm(x ~ y + 0)
summary(nointercept_xy_lm)$coefficients
```

    ##    Estimate Std. Error  t value     Pr(>|t|)
    ## y 0.3911145 0.02088625 18.72593 2.642197e-34

The t-statistic and p-value are in fact the same as those obtained in (a). Based on the small p-value, we can also reject the null hypothesis that β = 0, and likewise conclude that there is some relationship between Y and X.

### Part 11c

*What is the relationship between the results obtained in (a) and (b)?*

The estimated coefficient obtained in (b) is approximately the reciprocal of the estimated coefficient in (a), because the linear model used in (b) is the inverse of the model in (a).

### Part 11d (in progress)

For the regression of Y onto X without an intercept, the t-statistic for H<sub>0</sub>: β = 0 takes the form ˆβ/SE(ˆβ), where ˆβ is given by (3.38), and where

![](equations/ch3_ex_11d_qn1.png) <!-- $$ \text{SE}(\hat{\beta}) =  \sqrt{\frac{\sum_{i=1}^{n} (y_i - x_i\hat{\beta})^2}{(n-1)\sum_{i'=1}^{n} x_{i'}^2}} $$ -->

(These formulas are slightly different from those given in Sections 3.1.1 and 3.1.2, since here we are performing regression without an intercept.) Show algebraically, and confirm numerically in R , that the t-statistic can be written as

### Part 11e

*Using the results from (d), argue that the t-statistic for the regression of `y` onto `x` is the same as the t-statistic for the regression of `x` onto `y`.*

The above expression for the t-statistic would yield the same value if we replaced x<sub>i</sub> with y<sub>i</sub> and y<sub>i</sub> with x<sub>i</sub> (when we perform regression of `x` onto `y`). Therefore the t-statistic would be the same for both regression models.

### Part 11f

*In `R`, show that when regression is performed with an intercept, the t-statistic for H<sub>0</sub>: β<sub>1</sub> = 0 is the same for the regression of `y` onto `x` as it is for the regression of `x` onto `y`.*

We generate a predictor `x1` and response `y1` as follows:

``` r
set.seed(2)
x1 <- rnorm(100)
y1 <- 2 * x1 + 3 + # example intercept is 3
    rnorm(100) # error term
```

The regression of `y` onto `x` yields the following t-statistic:

``` r
intercept_yx_lm <- lm(y1 ~ x1)
summary(intercept_yx_lm)$coefficients
```

    ##             Estimate Std. Error  t value     Pr(>|t|)
    ## (Intercept) 3.027769 0.09891863 30.60868 5.842604e-52
    ## x1          1.952897 0.08566001 22.79823 5.778822e-41

The regression of `x` onto `y` yields the following t-statistic:

``` r
intercept_xy_lm <- lm(x1 ~ y1)
summary(intercept_xy_lm)$coefficients
```

    ##               Estimate Std. Error   t value     Pr(>|t|)
    ## (Intercept) -1.3093167 0.07281857 -17.98053 8.443464e-33
    ## y1           0.4308278 0.01889742  22.79823 5.778822e-41

We can see from the above output that the t-statistic for β<sub>1</sub> is the same for both regression models.

Question 12
-----------

*This problem involves simple linear regression without an intercept.*

### Part 12a

*Recall that the coefficient estimate ˆβ for the linear regression of Y onto X without an intercept is given by (3.38). Under what circumstance is the coefficient estimate for the regression of X onto Y the same as the coefficient estimate for the regression of Y onto X?*

ˆβ for the linear regression of Y onto X is given by:

![](equations/ch3_ex_5_qn2.png)

If we were to perform regression of X onto Y: the coefficient estimate ˆβ<sub>y</sub> would be:

![](equations/ch3_ex_12a_answer1.png) <!-- \hat{\beta}_y = \frac{(\sum_{i'=1}^{n}y_{i'} x_{i'})}{(\sum_{i'=1}^{n}y_{i'}^2)} -->

The two coefficient estimates would be the the same if:

-   the true linear coefficient is close to 1 (since one coefficient is the reciprocal of the other)
-   the sum of squares for X and sum of squares for Y are the same

![](equations/ch3_ex_12a_answer2.png)

### Part 12b

*Generate an example in `R` with n = 100 observations in which the coefficient estimate for the regression of X onto Y is different from the coefficient estimate for the regression of Y onto X.*

``` r
set.seed(12)
x_12b <- rnorm(100)
y_12b <- x_12b + rnorm(100, mean = 0, sd = 1)  # Y = X + e
coefficients(lm(y_12b ~ x_12b))
```

    ## (Intercept)       x_12b 
    ##  0.01026637  1.01838800

``` r
coefficients(lm(x_12b ~ y_12b))
```

    ## (Intercept)       y_12b 
    ## -0.02194273  0.42960401

### Part 12c (Needs review)

*Generate an example in `R` with n = 100 observations in which the coefficient estimate for the regression of X onto Y is the same as the coefficient estimate for the regression of Y onto X.*

``` r
# construct x and y off a common set of random values so that the linear coefficient is close to 1
set.seed(123)
base <- rnorm(100)

# x contains some random noise
x_12c <- base + rnorm(100, mean = 0, sd = 0.01)
# sum of squares for x
SSx_12c <- sum(x_12c^2) 

# construct first 99 values of y
y_12c <- base[1:99] + rnorm(99, mean = 0, sd = 0.01)
# 100th value of y is determined such that the sums of squares would be equal,
# and based on whether the corresponding x value is positive/negative
if(x_12c[100] < 0){
    last_y <- -(sqrt(SSx_12c - sum(y_12c^2)))
} else {
    last_y <- sqrt(SSx_12c - sum(y_12c^2))
}
y_12c <- append(y_12c, last_y)

coefficients(lm(y_12c ~ x_12c))
```

    ## (Intercept)       x_12c 
    ## 0.001852879 0.999692890

``` r
coefficients(lm(x_12c ~ y_12c))
```

    ##  (Intercept)        y_12c 
    ## -0.001833896  1.000092705
