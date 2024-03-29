test_that("extract_injury_data returns a data.frame with one column when other.columns is NULL", {
  expect_true(ncol(extract_injury_data(injury.test.data, c("einj1", "einj2", "ctinj1"))) == 1)
})

test_that("extract_injury_data correctly returns a data.frame with three columns when two other columns are named", {
    extracted.injuries <- extract_injury_data(injury.test.data, c("einj1", "ctinj1"), other.columns = c("age", "moi"))
    expect_true(ncol(extracted.injuries) == 3)
    expect_true(identical(colnames(extracted.injuries), c("injury_description", "age", "moi")))
})

