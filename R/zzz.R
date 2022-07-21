.onAttach <- function(lib, pkg) {
    if (interactive()) 
        packageStartupMessage(paste0(
"                           ____  
 _ __   ___   __ _  ___ ___|  _ \\ 
| '_ \\ / _ \\ / _` |/ __/ __| |_) |
| | | | (_) | (_| | (__\\__ \\  _ < 
|_| |_|\\___/ \\__,_|\\___|___/_| \\_\\  version ", packageVersion("noacsr"), "\n\n",
"A Collection of Utility Functions for the NOACS Research Lab \n\n",
"Use 'create()' to get started and create a new project."

        ))
}
