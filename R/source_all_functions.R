#' Source all functions
#'
#' Sources all files from the functions directory so that they are available in main.R
#' @export
source_all_functions <- function() {
    if (!dir.exists("functions"))
        pretty_stop("There is no functions directory, something is wrong.")
    function.files <- list.files("functions", pattern = "\\.R$", full.names = TRUE)
    for (function.file in function.files) source(function.file)
}
