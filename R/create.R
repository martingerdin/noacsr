#' Create a NOACS project
#'
#' This functions creates a NOACS project by providing a structure to
#' your documents and code.
#' @param name Character. The name of your project. No default.
#' @param existing.project Logical. If TRUE it will check if a
#'     directory named `name` exists in the current working directory
#'     or if your current working directory is `name`, and if so
#'     create the project in that directory. If FALSE it will abort if
#'     a directory called `name` already exists. Defaults to TRUE.
#' @param open.manuscript Logical. If TRUE the file manuscript.Rmd
#'     created by this function is opened in your current
#'     editor. Defaults to TRUE.
#' @param setup.database.access Logical. If TRUE some additional steps
#'     are added to the create project process where the user is asked
#'     to setup database access.
#' @param verbose Logical. If TRUE the function reports back when
#'     important steps have been completed. Defaults to TRUE.
#' @export
create <- function(name,
                   existing.project = TRUE,
                   open.manuscript = rlang::is_interactive(),
                   setup.database.access = FALSE,
                   verbose = TRUE) {
    assertthat::assert_that(is.character(name) & length(name) == 1)
    for (argument in c(existing.project, open.manuscript, setup.database.access))
        assertthat::assert_that(is.logical(argument) & length(argument == 1))
    withr::local_options(list(verbose = verbose))
    ## Check if the project directory is in the current working
    ## directory and if it is, stop if existing.project is false
    project.dir.is.in.wd <- dir.exists(name)
    if (!existing.project & project.dir.is.in.wd)
        pretty_stop("Sorry, can't do that becasue a directory named ", name, " already exists.")
    ## Check if the current working directory is the project directory
    ## and if it is not, stop if existing directory is true
    project.dir.is.wd <- grepl(paste0(name, "$"), getwd())
    if (existing.project & !project.dir.is.in.wd & !project.dir.is.wd)
        pretty_stop("Sorry, can't find a project directory called ", name, ".")
    ## Check files in the current working directory and stop if it is
    ## already a noacs project
    files.in.wd <- list.files(all.files = TRUE)
    files.to.check <- c("manuscript.Rmd", "main.R", "bibliography.bib")
    if (any(sapply(files.to.check, grepl, x = files.in.wd, fixed = TRUE)))
        pretty_stop("Sorry, can't do that because you seem to be in a project directory already. This happens if you have any of the files ", paste0(files.to.check, collapse = ", "), " in your working directory.")
    if (!existing.project) {
        pretty_message("Creating project directory, hang on...")
        dir.create(name)
        step_completed("Created project directory ", name)
    }
    if (!project.dir.is.wd) {
        setwd(name)
        step_completed("Changed working directory to ", name, "/")
    }
    check_version_control(name)
    file.copy(system.file("manuscript.Rmd", package = "noacsr"), "manuscript.Rmd")
    step_completed("Created manuscript.Rmd file")
    file.copy(system.file("bibliography.bib", package = "noacsr"), "bibliography.bib")
    step_completed("Created bibliography.bib file")
    file.copy(system.file("vancouver.csl", package = "noacsr"), "vancouver.csl")
    step_completed("Created vancouver.csl file")
    file.copy(system.file("main.R", package = "noacsr"), "main.R")
    step_completed("Created main.R file")
    if (!file.exists(paste0(name, ".Rproj")))
        file.copy(system.file("default.Rproj", package = "noacsr"), paste0(name, ".Rproj"))
    file.copy(system.file(".gitignore.default", package = "noacsr"), ".gitignore", overwrite = TRUE)
    step_completed("Created default config files")
    dir.create("functions")
    file.copy(system.file("example_function.R", package = "noacsr"), "functions/example_function.R")
    dir.create("documents")
    dir.create("results")
    step_completed("Created default folders")
    if (setup.database.access) {
        pretty_message("Setting up database access...")
        setup_database_access()
    }
    pretty_message(emoji = "fireworks", " All done!")
    if (open.manuscript)
        file.edit("manuscript.Rmd")
}

## Wrapping this in a function to make it easier to test
check_version_control <- function(name) {
    already.git <- dir.exists(".git")
    if (already.git) {
        step_completed("The project directory is already under version control, skipping that.")
    } else {
        git2r::init()
        step_completed("Initiated version control in ", name, "/")
    }
}
