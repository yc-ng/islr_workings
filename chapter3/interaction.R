library(MASS)
library(ISLR)
library(dplyr)
data("Auto")

# remove name
auto_noname <- Auto[, -9]
# Base model
auto_multiple_lm <- lm(mpg ~ ., data = auto_noname)
summary(auto_multiple_lm)

# 1 interaction term
auto_multiple_lm %>% 
    update(~ . + weight:displacement) %>%
    summary()


    # `[[`("coefficients") %>% 
    # `[`(, 4) %>% 
    # signif(3)


# Problem -----------------------------------------------------------------

# Task: 
# 1) permutate possible interaction terms for inclusion - done.

# test vector
x <- c("displacement", "weight", "year", "origin")

generate_interactive_terms <- function(x){
    # (character) -> character
    
    n <- length(x)
    # empty vector for accumulation
    interaction_terms <- character(0)
    
    # takes each term in x and pairs it with every term after itself
    # insert each pair in the vector
    for(i in seq.int(x)){
        j = i + 1
        while(j <= n){
            term <- paste(x[i], x[j], sep = ":")
            interaction_terms <- append(interaction_terms, term)
            j <- j + 1
        }
    }
    return(interaction_terms)
}

# 2) for each interaction term, generate a new linear model - done.

generate_summary <- function(term, model){
    # (character, lm) -> summary.lm

    # paste term with formula string
    # coerce into formula and update model
    # generate summary
    paste("~ . +", term) %>% 
        as.formula() %>% 
        update(model, .) %>% 
        summary() %>% 
        return()
}

# 3) extract p-values of predictors - done.
# 4) extract RSE, multiple R2 and adjusted R2, insert into vector - done.

function(lm_summary){
    # lm_summary - summary.lm object
    # returns a numeric vector
    
    # retrieve coefficients, extract 4th column (p-values)
    # exclude 1st element (p-value for y-intercept)
    lm_summary$coefficients[, 4][-1] %>% 
        append(c(RSE = lm_summary$sigma, 
                 rsq = lm_summary$r.squared, 
                 adj_rsq = lm_summary$adj.r.squared)) %>% 
        signif(4) %>% 
        return()
}

# compile values for every linear model in a table
