pretty_stop <- function(...) stop (prettify_text(emoji = "stop_sign", ...), call. = FALSE)

pretty_message <- function(...) message (prettify_text(...))

pretty_warning <- function(...) warning (prettify_text(...))

prettify_text <- function(..., emoji = NULL) {
    strwrap(paste0(ifelse(is.null(emoji), "", emoji::emoji(emoji)),
                   ifelse(is.null(emoji), "", " "),
                   ...),
            prefix = "\n", initial = "")   
}

ask_question <- function(...) pretty_message(emoji = "white_question_mark", ...)

request_information <- function(...) pretty_message(emoji = "white_exclamation_mark", ...)

request_confidential <- function(...) askpass::askpass(prompt = request_information(...))




    
