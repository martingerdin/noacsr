#' Functions starting with kobo_ are a set of functions to interact with the datacollection tool kobotoolbox.
#' Lists all kobo projects/assets available for a user.
#' @importFrom magrittr %>%
#' @importFrom dplyr select
#' @importFrom httr GET
#' @importFrom jsonlite fromJSON
#' @param url URL to kobotoolbox, for example https://kf.kobo.prod.in.noacs.io
#' @param username Username for kobotoolbox
#' @param password Password for kobotoolbox
#' @return projects A dataframe containing a list of projects available to the user, their uids and number of submissions.
#' @export
kobo_get_project_list <- function(url, username, password) {
  response <- httr::GET(paste0(url, "/assets.json"), authenticate(username, password))
  projects <- jsonlite::fromJSON(rawToChar(response$content))$results %>% 
    dplyr::select(url, owner__username, uid, name, has_deployment, deployment__active, deployment__submission_count)
  return(projects)
}
