# ------------------------------------------------------------------------------

# Clear current profile
#
# Remove all files associated with the current profile.
#
clear_current_profile <- function() {

  # Try to remove the current profile
  status <- unlink(
    dir(
      file.path(get_config_dir(), "RStudio"),
      full.names = TRUE,
      recursive = TRUE
    ),
    force = TRUE,
    expand = FALSE
  )

  # Check if file remove failed
  if (status == 1) stop("Could not clear the current profile")

  status
}

# ------------------------------------------------------------------------------

# Get config directory
#
# Find the current user's config directory based on the operating system.
#
get_config_dir <- function() {

  # Check if user customized the user config directory
  cdir <- Sys.getenv("RSTUDIO_CONFIG_HOME")

  # On windows, check for the appdata directory
  if (cdir == "" && .Platform$OS.type == "windows") {
    cdir <- Sys.getenv("APPDATA")

    # Check if config directory is still missing
    if (cdir == "") {
      stop(glue(
        'Could not find the config directory. Use Sys.setenv() to set the ',
        '"RSTUDIO_CONFIG_HOME" or "APPDATA" properties.'
      ))
    }
  }

  # On unix, set to the default config directory
  if (cdir == "" && .Platform$OS.type == "unix") {
    cdir <- "~/.config/"
  }

  cdir
}
