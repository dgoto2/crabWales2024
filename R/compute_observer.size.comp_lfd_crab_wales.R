# reformat the observer size composition data of the Welsh stock of brown crab for elefan

# run input data processing script
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source("compute_observer.size.comp_crab_wales.R")

# read in data sets
size.dist_lobster_month <- readr::read_csv("observer.size.comp.data_crab_wales_month_ss_all.csv") |> 
  dplyr::glimpse()

# reformat for elefan
size.dist_crab_month2 <- size.dist_crab_month 
colnames(size.dist_crab_month2) <- c("year", "month", "fleet", "sex", "part", "nsample", seq(size.min, size.max-width, by = width), "date")
size.dist_crab_month_lfd <- size.dist_crab_month2 |>
  tidyr::gather(lnclass, catch, colnames(size.dist_crab_month2)[7]:colnames(size.dist_crab_month2[ncol(size.dist_crab_month2)-1]), factor_key=TRUE) |>
  dplyr::select(-fleet, -part) |>
  dplyr::mutate(year = as.numeric(year),
                month = as.numeric(month),
                sex = as.numeric(sex),
                nsample = as.numeric(nsample),
                catch = as.numeric(catch)) |>
  dplyr::arrange(year, month, date, sex, nsample) |>
  dplyr::filter(lnclass %in% c(8:18)) |> # select size classes used for elefan
  dplyr::glimpse()

# export output
readr::write_csv(size.dist_crab_month_lfd, file = "observer_crab_wales_month_lfd.csv") 
