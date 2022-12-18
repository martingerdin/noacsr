#' Extract injury data
#'
#' Extract injury data from a dataset as a single vector
#' @inheritParams create_injury_dataset_for_ais_coding
#' @export
extract_injury_data <- function(data, injury.columns, other.columns = NULL,
                                only.unique = TRUE) {
    ## Check arguments
    assert_that(is.data.frame(data))
    assert_that(is.character(injury.columns))
    assert_that(is.character(other.columns) | is.null(other.columns),
                msg = "other.columns has to be a character vector or NULL")
    assert_that(is.logical(only.unique))

    ## Extract injury data and combine each column with other.columns, if there are any
    injury.data <- do.call(rbind, lapply(data[, injury.columns], function(column) cbind(column, data[, other.columns]))) 

    ## Name column with injury descriptions
    colnames(injury.data)[1] <- "injury_description"

    ## Remove duplicates if only.unique is true
    if (only.unique) 
        injury.data <- injury.data %>% dplyr::filter(duplicated(injury_description) == FALSE)
  
    ## Return injury data
    return (injury.data)
}
