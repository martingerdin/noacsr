#' Create Function
#'
#' Creates a file in the directory `/functions` with some function
#' boilerplate to facilitate creating functions and write code that is
#' easier to understand and maintain.
#' @param title Character. What the function does, for example
#'     "Create function" of "Create sample characteristics table". No
#'     default.
#' @export
create_function <- function(title) {
    assertthat::assert_that(is.character(title) & length(title) == 1)
    assertthat::assert_that(dir.exists("functions"),
                            msg = "There is no directory named functions in which to create this function.")
    roxygen.title <- tools::toTitleCase(title)
    function.name <- snakecase::to_snake_case(title)
    boilerplate <- paste0("#' ", roxygen.title, "\n",
                          "#'\n",
                          "#' Write a short description of your function here \n",
                          "#' @param x Describe argument x here \n",
                          "#' @export \n",
                          function.name, " <- function(x) {\n",
                          "    ## Replace with the contents of your function\n",
                          "    y <- x + 1\n",
                          "    return (y)\n",
                          "}")
    function.file.name <- paste0("functions/", function.name, ".R")
    write(boilerplate, function.file.name)
    step_completed("Created function ", function.name, " in ", function.file.name, ".")
    file.edit(function.file.name)
}

