## Documents how the coded injury data was created and updated
coded.injury.data <- readr::read_csv("~/projects/data/coded-injury-data.csv")
usethis::use_data(coded.injury.data, internal = TRUE)
