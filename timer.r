
# Timer

library(tictoc)
library(tidyverse)
library(tweedie)

tic.clearlog()

# Lets create a function for storing the results (from lesson 9)
printTicTocLog <-
  function() {
    tic.log() %>%
      unlist %>%
      tibble(logvals = .) %>%
      separate(logvals,
               sep = ":",
               into = c("Script", "log")) %>%
      mutate(log = str_trim(log)) %>%
      separate(log,
               sep = " ",
               into = c("Seconds"),
               extra = "drop")
  }


# Testing the first script
tic("Script 1")
source("scripts/1.r")
toc(log = TRUE)


# Testing the second script
tic("Script 2")
source("scripts/2.r")
toc(log = TRUE)


# Testing the third script
tic("Script 3")
source("scripts/3.r")
toc(log = TRUE)


# Table
printTicTocLog() %>%
  knitr::kable()


# The slowest script was script 1, and the fastest was script 3. 
# Script 2 is faster than script 1, because script 1 runs simulations sequentially, while script 2 runs it concurrently
# Script 3 is faster than script 2. This might be because script 3 splits the M in the MTweedieTest function
# which is the largest part of that function (M is 1000).

