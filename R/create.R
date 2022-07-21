#' Create a NOACS project
#'
#' This functions creates a NOACS project by providing a structure to
#' your documents and code.
#' @param name Character. The name of your project. No default.
#' @export
create <- function(name) {
    assertthat::assert_that(is.character(name) & length(name) == 1)
    if (dir.exists(name))
        pretty_stop("Sorry, can't do that becasue a directory with named ", name, " already exists.")
    dir.create(name)
    setwd(name)
    git2r::init()
    file.copy(system.file("manuscript.Rmd", package = "noacsr"), "manuscript.Rmd")
    file.copy(system.file("main.R", package = "noacsr"), "main.R")
    file.copy(system.file("default.Rproj", package = "noacsr"), paste0(name, ".Rproj"))
    file.copy(system.file(".gitignore.default", package = "noacsr"), ".gitignore"))
    dir.create("functions")
    dir.create("documents")
    dir.create("results")
    
}
