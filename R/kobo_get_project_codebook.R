#' Functions starting with kobo_ are a set of functions to interact with the datacollection tool kobotoolbox.
#' Get the XLSForm/Codebook for a kobo project. 
#' @importFrom magrittr %>%
#' @importFrom dplyr select
#' @importFrom httr GET
#' @importFrom readxl read_xlsx
#' @importFrom purrr map
#' @param url URL to kobotoolbox, for example https://kf.kobo.prod.in.noacs.io
#' @param uid The uid for with the project, get it from kobo_get_project_list function
#' @param username Username for kobotoolbox
#' @param password Password for kobotoolbox
#' @return data A list with a tibble for each sheet in the XLSForm.
#' @export
kobo_get_project_codebook <- function(url, uid, username, password) {
  response <- httr::GET(paste0(url, "/api/v2/assets/", uid, "/deployment/?format=xls"), authenticate(username, password))
  raw_xlsx <- response$content
  filename <- tempfile(fileext = ".xlsx")
  writeBin(raw_xlsx, filename)
  readxl::read_xlsx(filename)
  codebook <- filename %>% 
    readxl::excel_sheets() %>% 
    set_names() %>% 
    purrr::map(read_excel, path = filename)
  unlink(filename)
  return(codebook)
}
