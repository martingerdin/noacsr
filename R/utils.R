pretty_stop <- function(...) stop (prettify_text(...), call. = FALSE)

pretty_message <- function(...) message (prettify_text(...))

pretty_warning <- function(...) warning (prettify_text(...))

prettify_text <- function(...) strwrap(paste0(...))
    
