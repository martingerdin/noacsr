#' Hijack function
#'
#' Creates a new function based on another function but changes one or
#' more default values. Stolen
#' from https://trinkerrstuff.wordpress.com/2014/08/19/hijacking-r-functions-changing-default-arguments-3/
#' @param FUN Function. The function to hijack. No default.
#' @param ... The arguments to change.
#' @export
hijack_function <- function (FUN, ...) {
    .FUN <- FUN
    args <- list(...)
    invisible(lapply(seq_along(args), function(i) {
        formals(.FUN)[[names(args)[i]]] <<- args[[i]]
    }))
    return (.FUN)
}
