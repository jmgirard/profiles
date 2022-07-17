# ------------------------------------------------------------------------------
clear_current_profile <- function() {

  status <- file.remove(
    dir(
      file.path(Sys.getenv("APPDATA"), "RStudio"),
      full.names = TRUE,
      recursive = TRUE
    )
  )

  status
}

# ------------------------------------------------------------------------------
get_config_dir <- function() {

  cdir <- Sys.getenv("RSTUDIO_CONFIG_HOME")

  if (cdir == "" && .Platform$OS.type == "windows") {
    cdir <- Sys.getenv("APPDATA")
  }

  if (cdir == "" && .Platform$OS.type == "unix") {
    cdir <- "~/.config/"
  }

  cdir
}
