test_that("create_injury_dataset_for_ais_coding removes already coded injuries correctly", {
    expect_false(identical(nrow(create_injury_dataset_for_ais_coding(injury.test.data,
                                                                     c("einj1", "ctinj1"))),
                           nrow(create_injury_dataset_for_ais_coding(injury.test.data,
                                                                     c("einj1", "ctinj1"),
                                                                     remove.coded = FALSE))))
})
