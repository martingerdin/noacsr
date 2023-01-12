#' Create an injury dataset for coding using the Abbrevaited Injury Scale (AIS)
#'
#' Takes a dataset that contains injury data as input and creates a
#' new dataset for AIS coding.
#' @param data A data.frame or a named list of data.frames. The
#'     dataset(s) containing the injury data. If more than one it is
#'     assumed that these should be merged for the purpose of AIS
#'     coding. No default.
#' @param injury.columns Character or a named list of character
#'     vectors. Should include the names of the columns with injury
#'     descriptions. If data is a list and injury.columns is not a
#'     list then the names of the columns with the injury data are
#'     assumed to be the same across all datasets in data. If both
#'     data and injury.columns are lists then the names of
#'     injury.columns have to be the same as the names of data, but
#'     the order is not important. No default.
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
    pretty_msg <- function(...) prettify_text(emoji = "stop_sign", ...)
    data.list <- if(is.data.frame(data)) list(data) else data # See notes below
    injury.columns.list <- if(is.character(injury.columns)) list(injury.columns) else injury.columns
    if (length(data.list) > 1) assert_that(!is.null(names(data.list)))
    if (length(injury.columns.list) > 1) assert_that(!is.null(names(injury.columns.list)))
    assert_that(length(data.list) == length(injury.columns.list) | length(injury.columns.list) == 1,
                msg = pretty_msg("If you supply more than one data.frame to data you need to either ",
                                 "supply one vector of injury column names or the same number of ",
                                 "injury columns names as the number of data.frames"))
    assert_that(is.list(data.list) & all(sapply(data.list, is.data.frame)),
                msg = pretty_msg("The argument data has to be a data.frame or a named list ",
                                 "of data.frames"))
    assert_that(is.list(injury.columns.list) & all(sapply(injury.columns.list, is.character)),
                msg = pretty_msg("The argument injury.columns has to be a character vector or a ",
                                 "named list of character vectors"))
    assert_that(identical(sort(names(data.list)), sort(names(injury.columns.list))),
                msg = pretty_msg("The names of data and injury.columns have to match"))
    assert_that(is.character(other.columns) | is.null(other.columns),
                msg = pretty_msg("The argument other.columns has to be a character vector or NULL"))
    for (argument in c(only.unique, remove.coded, save.dataset))
        assert_that(is.logical(argument))

    ## Set up injury extraction arguments 
    entry.names <- sort(names(data.list))
    if (length(injury.columns.list) == 1)
        injury.columns.list <- rep(injury.columns.list, 3)
    arguments.list <- lapply(seq_along(data.list), function(index) {
        list(data = data.list[[index]],
             injury.columns = injury.columns.list[[index]],
             other.columns = other.columns)
    })
    
    ## Extract injury data
    injury.data <- do.call(rbind, lapply(arguments.list, function(arguments) {
        do.call(extract_injury_data, arguments)
    }))
    
    ## Remove duplicates if only.unique is true
    if (only.unique) 
        injury.data <- injury.data %>% dplyr::filter(duplicated(injury_description) == FALSE)
    
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

    ## Remove rownames
    rownames(injury.data) <- NULL
    
    ## Save and return dataset
    if (save.dataset) {
        readr::write_csv(injury.data, paste0(file, ".csv"), na = "")
        return (invisible(injury.data))
    } else {
        return (injury.data)
    }
}

## Notes
## if (x) y else z was used instead of ifelse because of how ifelse return values, see ?ifelse
