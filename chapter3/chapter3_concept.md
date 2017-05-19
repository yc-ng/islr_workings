Chapter 3 Exercises
================

-   [Question 1](#question-1)
-   [Question 2 (in progress)](#question-2-in-progress)
-   [Question 3](#question-3)
-   [Question 4 (in progress)](#question-4-in-progress)

Question 1
----------

**Describe the null hypotheses to which the p-values given in Table 3.4 correspond. Explain what conclusions you can draw based on these p-values. Your explanation should be phrased in terms of `sales`, `TV`, `radio`, and `newspaper`, rather than in terms of the coefficients of the linear model.**

We display **Table 3.4** below for ease of reference:

|           | Coefficient | Std. error | t-statistic | p-value     |
|-----------|-------------|------------|-------------|-------------|
| Intercept | 2.939       | 0.3119     | 9.42        | &lt; 0.0001 |
| TV        | 0.046       | 0.0014     | 32.81       | &lt; 0.0001 |
| radio     | 0.189       | 0.0086     | 21.89       | &lt; 0.0001 |
| newspaper | −0.001      | 0.0059     | −0.18       | 0.8599      |

Conclusions are derived at an alpha level of **.05**.

For `TV`:
Null hypothesis: For a given amount spent on `radio` and `newspaper`, there is **no** relationship between `sales` and `TV`.
Conclusion: We **reject** the null hypothesis, and infer that there is a relationship between `sales` and `TV` for a given amount spent on `radio` and `newspaper`.

For `radio`:
Null hypothesis: For a given amount spent on `TV` and `newspaper`, there is **no** relationship between `sales` and `radio`.
Conclusion: We **reject** the null hypothesis, and infer that there is a relationship between `sales` and `radio` for a given amount spent on `TV` and `newspaper`.

For `newspaper`:
Null hypothesis: For a given amount spent on `TV` and `radio`, there is **no** relationship between `sales` and `newspaper`.
Conclusion: We **do not reject** the null hypothesis, and infer that there is no relationship between `sales` and `newspaper` for a given amount spent on `TV` and `radio`.

Question 2 (in progress)
------------------------

**Carefully explain the differences between the KNN classifier and KNN regression methods.**

-   The KNN classifier is used for classification problems where the response variable is qualitative/categorical.
-   The KNN regression method is used for regression problems where the response variable is quantitative.

-   The KNN classifier selects a response variable based on the response class with the highest conditional probability within <sub>0</sub>.
-   The KNN regression method evaluates a response variable based on the average of the training responses in N<sub>0</sub>.

Question 3
----------

**Suppose we have a data set with five predictors, X<sub>1</sub> = GPA, X<sub>2</sub> = IQ, X<sub>3</sub> = Gender (1 for Female and 0 for Male), X<sub>4</sub> = Interaction between GPA and IQ, and X<sub>5</sub> = Interaction between GPA and Gender. The response is starting salary after graduation (in thousands of dollars). Suppose we use least squares to fit the model, and get ˆβ<sub>0</sub> = 50, ˆβ<sub>1</sub> = 20, ˆβ<sub>2</sub> = 0.07, ˆβ<sub>3</sub> = 35, ˆβ<sub>4</sub> = 0.01, ˆβ<sub>5</sub> = −10.**

1.  **Which answer is correct, and why?**
    1.  For a fixed value of IQ and GPA, males earn more on average than females.
    2.  For a fixed value of IQ and GPA, females earn more on average than males.
    3.  **For a fixed value of IQ and GPA, males earn more on average than females provided that the GPA is high enough.**
    4.  For a fixed value of IQ and GPA, females earn more on average than males provided that the GPA is high enough.

2.  Predict the salary of a female with IQ of 110 and a GPA of 4.0.
3.  True or false: Since the coefficient for the GPA/IQ interaction term is very small, there is very little evidence of an interaction effect. Justify your answer.

3a.
![](ch3_ex_3a_eqn.png)
<!-- $$ \text{Salary} = 50 + 20 \times \text{GPA} + 0.07 \times \text{IQ} + 35 \times \text{Gender} + 0.01 \times (\text{IQ}\times\text{GPA}) - 10\times(\text{Gender}\times\text{GPA}) $$ --> For a fixed value of IQ and GPA, the coefficient for Gender will be (35 - 10 × GPA), which means that it will become negative when the value of GPA is greater than 3.5. Since Gender is coded as 1 for Female, a negative coefficient at high GPA means that females will earn less than males (i.e. males will earn more than females) on average when the GPA is high enough.

3b.
![](ch3_ex_3b_eqn.png)
<!-- $$ \hat{y} = 50 + 20(4.0) + 0.07(110) + 35(1) + 0.01(110 \times 4.0) - 10(1 \times 4.0) = 137.1 $$ --> The predicted salary would be **$137,100** since Y is expressed in thousands of dollars.

3c.
**False**. Whether an interaction effect is statistically significant is not dependent on the magnitude of the coefficient, but on **how far the coefficient is from 0 in terms of its standard error**. If the standard error of the coefficient is small, then we can infer that the interaction effect is present.
We can conduct a hypothesis test, with the null hypothesis that there is no relationship between the interaction effect and the response variable. We can divide the coefficient by its standard error to obtain a *t-statistic*, which yields a *p-value* based on the number of degrees of freedom. If the standard error is small enough, the t-statistic will be large and the p-value will be small enough for us to reject the null hypothesis.

Question 4 (in progress)
------------------------

**I collect a set of data (n = 100 observations) containing a single predictor and a quantitative response. I then fit a linear regression model to the data, as well as a separate cubic regression, i.e. Y = β<sub>0</sub> + β<sub>1</sub>X + β<sub>2</sub>X<sup>2</sup> + β<sub>3</sub>X<sup>3</sup> + ϵ.**

<!-- $$ Y = \beta_0 + \beta_1X + \beta_2X^{2} + \beta_3X^{3} + \epsilon $$ -->
1.  Suppose that the true relationship between X and Y is linear, i.e. Y = β<sub>0</sub> + β<sub>1</sub>X + ϵ. Consider the training residual sum of squares (RSS) for the linear regression, and also the training RSS for the cubic regression. Would we expect one to be lower than the other, would we expect them to be the same, or is there not enough information to tell? Justify your answer.

The cubic regression may exhibit a lower training RSS. Even if the true relationship between X and Y is linear, the data points may not fall close to a straight line due to the irreducible error ϵ. Therefore, the linear regression model may not fit the points as closely as a more flexible method like the cubic regression model.
