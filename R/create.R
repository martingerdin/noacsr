#' Create a NOACS project
#'
#' This functions creates a NOACS project by providing a structure to
#' your documents and code.
#' @param name Character. The name of your project. No default.
#' @export
create <- function(name) {
    assertthat::assert_that(is.character(name) & length(name) == 1)
    if (dir.exists(name))
        pretty_stop("Sorry, can't do that becasue a directory named ", name, " already exists.")
    files.in.wd <- list.files()
    if (any(sapply(c("manuscript.Rmd", "main.R", ".Rproj"), grepl, x = files.in.wd, fixed = TRUE)))
        pretty_stop("Sorry, can't do that because you seem to be in a project directory already.")
    message("Creating project directory, hang on...")
    dir.create(name)
    step_completed("Created project directory ", name)
    setwd(name)
    step_completed("Changed working directory to ", name, "/")
    git2r::init()
    step_completed("Initiated version control in ", name, "/")
    file.copy(system.file("manuscript.Rmd", package = "noacsr"), "manuscript.Rmd")
    step_completed("Created manuscript.Rmd file")
    file.copy(system.file("main.R", package = "noacsr"), "main.R")
    step_completed("Created main.R file")
    file.copy(system.file("default.Rproj", package = "noacsr"), paste0(name, ".Rproj"))
    file.copy(system.file(".gitignore.default", package = "noacsr"), ".gitignore")
    step_completed("Created default config files")
    dir.create("functions")
    dir.create("documents")
    dir.create("results")
    step_completed("Created default folders")
    pretty_message(emoji = "fireworks", " All done!")
    file.edit("manuscript.Rmd")
}

step_completed <- function(...) pretty_message(emoji = "check_mark_button", ...)
