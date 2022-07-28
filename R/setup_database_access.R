#' Setup database access
#'
#' Internal function to setup database access by creating a .env file
#' for storage of database credentials.
#' @param silent Logical. If FALSE the function will print messages if
#'     database username and passwords are already found as
#'     environment variables.
setup_database_access <- function(silent = FALSE) {
    username <- ""
    password <- ""
    if (file.exists(".env")) {
        dotenv::load_dot_env()
        username <- Sys.getenv("DB_USERNAME")
        password <- Sys.getenv("DB_PASSWORD")
    }
    if (!is.empty(username) & !silent) {
        pretty_message(emoji = "red_exclamation_mark", "A database username already exists. Please edit the .env file directly if you want to change it.")
    } else {
        username <- request_confidential("Please enter your username for accessing the database:")
        write(paste0("DB_USERNAME=", username), ".env")
    } 
    if (!is.empty(password) & !silent) {
        pretty_message(emoji = "red_exclamation_mark", "A database passwoard already exists. Please edit the .env file directly if you want to change it.")
    } else {
        password <- request_confidential("Please enter your password for database access:")
        write(paste0("DB_PASSWORD=", password), ".env", append = TRUE)
    } 
}

is.empty <- function(x) x == ""
