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
  if (status == 1) {
    cli::cli_abort("Could not clear the current profile")
  }

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
      cli::cli_abort(
        c('Could not find the config directory. Use Sys.setenv() to set the ',
        '"RSTUDIO_CONFIG_HOME" or "APPDATA" properties.')
      )
    }
  }

  # On unix, set to the default config directory
  if (cdir == "" && .Platform$OS.type == "unix") {
    cdir <- "~/.config/"
  }

  cdir
}

# -------------------------------------------------------------------------

# Restart RStudio
restart_rstudio <- function() {
  # Check if the user is not in RStudio
  if (!rstudioapi::isAvailable()) {
    return(FALSE)
  }

  # Check if the session is not interactive
  if (!rlang::is_interactive()) {
    return(FALSE)
  }

  # Check if no project is open in RStudio
  if (is.null(rstudioapi::getActiveProject())) {
    cli::cli_alert_info("Please restart RStudio to apply profile.")
    return(FALSE)
  }

  # Prompt the user to confirm restart
  if (!rstudioapi::showQuestion("Restart", "Restart RStudio?")) {
    return(FALSE)
  }

  rstudioapi::openProject()
}
