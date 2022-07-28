(function() {
    ## I wrap these tests in an anonumous function to allow objects to
    ## be reused across tests without polluting the global namespace
    starting.working.directory <- getwd()
    temp.file <- sub("./", "", tempfile(pattern = "project", tmpdir = "."), fixed = TRUE)
    create(temp.file, open.manuscript = FALSE)

    test_that("create creates correct directories and files correctly", {
        files <- c("manuscript.Rmd", "main.R", ".git", paste0(temp.file, ".Rproj"))
        for (file in files) expect_true(file.exists(file))
        dirs <- c("documents", "functions")
        for (dir in dirs) expect_true(dir.exists(dir))
    })

    test_that("create changes working directory correctly", {
        expect_true(getwd() == paste0(starting.working.directory, "/", temp.file))
    })

    test_that("create correctly throws error when trying to create project in a project dir", {
        expect_error(create(temp.file), regexp = "Sorry")
    })

    ## Clean up
    setwd("..")
    unlink(temp.file, recursive = TRUE)
})()
