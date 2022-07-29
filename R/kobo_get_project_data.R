#' Functions starting with kobo_ are a set of functions to interact with the datacollection tool kobotoolbox.
#' Get data for a kobo project. 
#' @importFrom magrittr %>%
#' @importFrom dplyr select
#' @importFrom httr GET
#' @importFrom jsonlite fromJSON
#' @param url URL to kobotoolbox, for example https://kf.kobo.prod.in.noacs.io
#' @param uid The uid for with the project, get it from kobo_get_project_list function
#' @param username Username for kobotoolbox
#' @param password Password for kobotoolbox
#' @return data A list with project data, note that some projects may return nestled lists within the result depending on the project configuration.
#' @export
kobo_get_project_data <- function(url, uid, username, password) {
  response <- httr::GET(paste0(url, "/api/v2/assets/", uid, "/data"), authenticate(username, password))
  data <- jsonlite::fromJSON(rawToChar(response$content))$results
  return(data)
}
