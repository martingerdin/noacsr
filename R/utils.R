pretty_stop <- function(...) stop (prettify_text(emoji = "stop_sign", ...), call. = FALSE)

pretty_message <- function(...) message (prettify_text(...))

pretty_warning <- function(...) warning (prettify_text(...))

prettify_text <- function(..., emoji = NULL) {
    paste0(strwrap(paste0(ifelse(is.null(emoji), "", emoji::emoji(emoji)),
                   ifelse(is.null(emoji), "", " "),
                   ..., collapse = ""),
            prefix = "\n", initial = ""), collapse = "")
}

ask_question <- function(...) pretty_message(emoji = "white_question_mark", ...)

request_information <- function(...) pretty_message(emoji = "white_exclamation_mark", ...)

request_confidential <- function(...) askpass::askpass(prompt = paste0(...))

step_completed <- function(...) pretty_message(emoji = "check_mark_button", ...)


    
