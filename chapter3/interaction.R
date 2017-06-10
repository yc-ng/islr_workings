library(MASS, warn.conflicts = FALSE)
library(ISLR, warn.conflicts = FALSE)
library(dplyr, warn.conflicts = FALSE)

# 1) permutate possible interaction terms -----------

generate_interaction_terms <- function(pred){
    # (character) -> character
    
    n <- length(pred)
    interaction_terms <- character(0)
    
    # takes each term in x and pairs it with every term after itself
    # insert each pair in the vector
    for(i in 1:n){
        j <- i + 1
        while(j <= n){
            term <- paste(pred[i], pred[j], sep = ":")
            interaction_terms <- append(interaction_terms, term)
            j <- j + 1
        }
    }
    return(interaction_terms)
}

# 2) for each interaction term, generate a new linear model ------

generate_summary <- function(int_term, model){
    # (character(1), lm) -> summary.lm

    # paste term with formula string
    # coerce into formula and update model
    # generate summary
    paste("~ . +", int_term) %>% 
        as.formula() %>% 
        update(model, .) %>% 
        summary() %>% 
        return()
}

# 3) extract p-values, RSE, multiple R2, adjusted R2 of model -----------------------

get_values <- function(lm_summary){
    # (summary.lm) -> numeric
    
    # retrieve coefficients, extract 4th column (p-values)
    # exclude 1st element (p-value for y-intercept)
    p_values <- lm_summary$coefficients[-1, 4]
    p_values %>% 
        append(c(RSE = lm_summary$sigma, 
                 rsq = lm_summary$r.squared, 
                 adj_rsq = lm_summary$adj.r.squared)) %>% 
        signif(4) %>% 
        return()
}

# compile p values and model fit metrics for every linear model in a matrix -----------

build_values_matrix <- function(pred, model){
    # (character, lm) -> matrix
    
    # generate possible interaction terms
    interaction_terms <- generate_interaction_terms(pred)
    
    # separate terms into list elements
    # generate lm summary for each term (list element)
    # retrieve p values and model fit criteria for each lm summary
    values_list <- interaction_terms %>% 
        as.list() %>% 
        lapply(FUN = generate_summary, model = model) %>% 
        lapply(FUN = get_values)
    
    # convert list of numeric vectors of (p values, model fit) into a matrix
    values_matrix <- values_list %>% 
        unlist() %>% 
        matrix(nrow = length(interaction_terms), byrow = TRUE)
    
    # row and column labels for matrix
    column_names <- names(values_list[[1]])
    column_names[length(column_names) - 3] <- "interaction"
    
    rownames(values_matrix) <- interaction_terms
    colnames(values_matrix) <- column_names
    return(values_matrix)
}

# # generate interaction terms    
# terms <-  generate_interaction_terms(x)
# # generate linear model summary for each interaction term
# terms_list <- as.list(terms) %>% 
#     lapply(FUN = generate_summary, model = auto_multiple_lm)
# # extract vector of p values from each linear model summary
# pval_list <- lapply(terms_list, FUN = get_p_values)
# # flattens list of p values into a matrix
# values_matrix <- unlist(pval_list) %>% 
#     matrix(nrow = length(terms), byrow = TRUE) 
# # define names
# column_names <- names(pval_list[[1]])
# column_names[length(column_names) - 3] <- "interaction"
# 
# rownames(values_matrix) <- terms
# colnames(values_matrix) <- column_names

# data("Auto")
# 
# # remove name
# auto_noname <- Auto[, -9]
# # Base model
# auto_multiple_lm <- lm(mpg ~ ., data = auto_noname)
# summary(auto_multiple_lm)
# 
# # 1 interaction term
# auto_multiple_lm %>% 
#     update(~ . + weight:displacement) %>%
#     summary()
# 
# 
#     # `[[`("coefficients") %>% 
#     # `[`(, 4) %>% 
#     # signif(3)
# 
# # test vector
# x <- c("displacement", "weight", "year", "origin")