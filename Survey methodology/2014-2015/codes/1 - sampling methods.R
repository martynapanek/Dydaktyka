### stratified sampling with ddplyr


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


strat_samp(data=student2009subset,
           samp_size=50,
           ST04Q01) 

##### test on bigger dataset -----------------------

load("~/Documents/Projects/RProjects/PAZUR Workshop/Datasets/Raw/pisa2009subset.rdata")

student2009subset <- tbl_df(student2009subset)
student2009subset <- rbind(student2009subset,student2009subset,
                           student2009subset,student2009subset,
                           student2009subset,student2009subset,
                           student2009subset,student2009subset,
                           student2009subset,student2009subset)

w <- strat_samp(data=student2009subset,
           samp_size=1000,
           CNT,ST04Q01)


#### two stage ---------------------------------------------------------------

# args: data, strata, clusterid, psu_size, ssu_size, ...

pisa %>%
  group_by(SCHOOLID,SC02Q01,SC04Q01) %>%
  summarise(N_cluster = n()) %>%
  group_by(SC02Q01,SC04Q01) %>%
  mutate(N_strat = n(),
         los = samp_one(N_strat)) %>%
  group_by() %>%
  mutate(N = n(),
         n_samp = round(N_strat/N*samp_size),
         filter = los <= n_samp)




