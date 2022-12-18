data <- readr::read_csv("~/projects/data/ttris-dataset-with-iss-collated-20190708120045.csv")
injury.test.data <- data[sample(1:nrow(data), 100), c("age", "moi", names(data)[grep("inj[1-9]$", names(data))])]
injury.test.data$age <- cut(injury.test.data$age, breaks = seq(18, 120, 40))
usethis::use_data(injury.test.data, overwrite = TRUE)
