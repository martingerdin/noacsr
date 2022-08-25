#' This function imports csv files from GitHub, it will rewrite the GitHub-base URL to the raw format.
#' @importFrom magrittr %>%
#' @importFrom stringr str_replace
#' @importFrom readr read_csv
#' @param ghurl URL to github csv file, for example https://github.com/titco/titco-I/blob/master/codebook-titco-I-v1.csv
#' @param delim The deliminator used in the csv file, either "," or ";"- Defaults to ","
#' @return data A tibble with the data from the csv file.
#' @export
import_csv_from_github <- function(ghurl, delim = ",") {
  # We replace the URL sections to get the raw-file.
  raw_ghurl <- ghurl %>% stringr::str_replace("github.com", replacement = "raw.githubusercontent.com") %>% stringr::str_replace("blob/", replacement = "")
  print(paste0("Reading csv file from: ", raw_ghurl))
  if (delim == ",") {
    # We use read_csv from the readr package as read.csv in base R cant handle very large files.
    data <- readr::read_csv(raw_ghurl)
  } else if (delim == ";") {
    data <- readr::read_csv2(raw_ghurl)
  } else {
    stop("Please specify a delimiter, either , or ;")
  }
  return(data)
}
