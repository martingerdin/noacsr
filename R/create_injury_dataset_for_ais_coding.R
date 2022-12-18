#' Create an injury dataset for coding using the Abbrevaited Injury Scale (AIS)
#'
#' Takes a dataset that contains injury data as input and creates a
#' new dataset for AIS coding
#' @param data A data.frame. The dataset containing the injury
#'     data. No default.
#' @param injury.columns Character. The names of the columns with
#'     injury descriptions. No default.
#' @param other.columns Character or NULL. The names of other columns
#'     to be included in the output. Defaults to NULL.
#' @param only.unique Logical. If TRUE only unique injuries are kept
#'     in the dataset. Defaults to TRUE.
#' @param remove.coded Logical. If TRUE injuries that are already
#'     coded are removed from the dataset. Defaults to TRUE.
#' @param save.dataset Logical. If TRUE the created dataset is saved
#'     to disk as a .csv file and returned invisibly. Defaults to
#'     FALSE.
#' @param file Character. The path of the file containing the injury
#'     dataset to code. Only used if save.dataset = TRUE and defaults
#'     to "injury-dataset-for-ais-coding".
#' @export
create_injury_dataset_for_ais_coding <- function(data, injury.columns, 
                                                 other.columns = NULL,
                                                 only.unique = TRUE,
                                                 remove.coded = TRUE,
                                                 save.dataset = FALSE,
                                                 file = "injury-dataset-for-ais-coding") {
    ## Check arguments
    assert_that(is.data.frame(data))
    assert_that(is.character(injury.columns))
    assert_that(is.character(other.columns) | is.null(other.columns),
                msg = "other.columns has to be a character vector or NULL")
    for (argument in c(only.unique, remove.coded, save.dataset))
        assert_that(is.logical(argument))

    ## Extract injury data
    injury.data <- extract_injury_data(data, injury.columns, other.columns, only.unique)

    ## Append AIS columns
    injury.data$head_and_neck <- NA
    injury.data$face <- NA
    injury.data$chest <- NA
    injury.data$abdomen <- NA
    injury.data$extremity <- NA
    injury.data$external <- NA

    ## Remove already coded injuries
    if (remove.coded)
        injury.data <- injury.data[!(injury.data$injury_description %in% coded.injury.data$injury_description), ]

    ## Save and return dataset
    if (save.dataset) {
        readr::write_csv(injury.data, paste0(file, ".csv"), na = "")
        return (invisible(injury.data))
    } else {
        return (injury.data)
    }
}
