strat_samp <- function(data,
                       samp_size,
                       ...) {
  require(dplyr)
  ### sample function 
  samp_one <- function(x) {
    sample(1:length(x),length(x))
  }
  
  ### function
  ds <- data %>%   
    group_by(...) %>%
    mutate(N_strat = n(),
           los = samp_one(N_strat)) %>%
    group_by() %>%
    mutate(N = n(),
           n_samp = round(N_strat/N*samp_size),
           filter = los <= n_samp) %>%
    filter(filter) %>%
    select(-(N_strat:filter)) %>%
    arrange(...)
  return(ds)
}