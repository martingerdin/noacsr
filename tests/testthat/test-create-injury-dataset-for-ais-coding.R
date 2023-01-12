test_that("create_injury_dataset_for_ais_coding generates correct data", {
    expect_snapshot(
        create_injury_dataset_for_ais_coding(
            data = list("test1" = injury.test.data,
                        "test2" = injury.test.data),
            injury.columns = list("test1" = c("einj1", "ctinj1"),
                                  "test2" = c("einj2", "ctinj2")))
    )
})

test_that("create_injury_dataset_for_ais_coding removes already coded injuries correctly", {
    expect_false(identical(nrow(create_injury_dataset_for_ais_coding(injury.test.data,
                                                                     c("einj1", "ctinj1"))),
                           nrow(create_injury_dataset_for_ais_coding(injury.test.data,
                                                                     c("einj1", "ctinj1"),
                                                                     remove.coded = FALSE))))
})

test_that("create_injury_dataset_for_ais_coding throws error lists are not named", {
    expect_error(
        create_injury_dataset_for_ais_coding(
            data = list(injury.test.data,
                        injury.test.data),
            injury.columns = list("test1" = c("einj1", "ctinj1"),
                                  "test3" = c("einj1", "ctinj1")))
    )
    expect_error(
        create_injury_dataset_for_ais_coding(
            data = list("test1" = injury.test.data,
                        "test2" = injury.test.data),
            injury.columns = list(c("einj1", "ctinj1"),
                                  c("einj1", "ctinj1")))
    )
})

test_that("create_injury_dataset_for_ais_coding throws error when names are different", {
    expect_error(
        create_injury_dataset_for_ais_coding(
            data = list("test1" = injury.test.data,
                        "test2" = injury.test.data),
            injury.columns = list("test1" = c("einj1", "ctinj1"),
                                  "test3" = c("einj2", "ctinj2"))),
    regexp = "The names of")
})

test_that("create_injury_dataset_for_ais_coding throws error when injury.columns are longer than data", {
    expect_error(
        create_injury_dataset_for_ais_coding(
            data = list("test1" = injury.test.data),
            injury.columns = list("test1" = c("einj1", "ctinj1"),
                                  "test3" = c("einj1", "ctinj1"))))
})
