#' Extract injury data
#'
#' Extract injury data from a dataset as a single vector
#' @inheritParams create_injury_dataset_for_ais_coding
#' @param data A data.frame. The dataset(s) containing the injury
#'     data. No default.
#' @param injury.columns Character. The names of the columns with
#'     injury descriptions. No default.
#' @export
extract_injury_data <- function(data, injury.columns, other.columns = NULL) {
    ## Check arguments
    assert_that(is.data.frame(data))
    assert_that(is.character(injury.columns))
    assert_that(is.character(other.columns) | is.null(other.columns),
                msg = "other.columns has to be a character vector or NULL")

    ## Extract injury data and combine each column with other.columns, if there are any
    injury.data <- do.call(rbind, lapply(data[, injury.columns], function(column) cbind(column, data[, other.columns]))) 

    ## Name column with injury descriptions
    colnames(injury.data)[1] <- "injury_description"

    ## Return injury data
    return (injury.data)
}
