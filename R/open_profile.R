# ------------------------------------------------------------------------------

#' Open Profile Function
#'
#' Open a saved profile and apply its configuration.
#'
#' @param name A string indicating the name of the profile to open.
#' @export
#'
open_profile <- function(name) {

  # Assertions
  assertthat::assert_that(assertthat::is.string(name))

  # Remove the current profile
  clear_current_profile()

  # Find the config directory
  cdir <- get_config_dir()

  # Build the profile directory
  pdir <- file.path(cdir, glue("RStudio.{name}"))

  # Check the profile directory exists
  if (dir.exists(pdir) == FALSE) {
    cli::cli_abort("Could not find profile: {name}")
  }

  # Try to copy the profile to the config directory
  status <-
    file.copy(
      from = dir(pdir, full.names = TRUE),
      to = file.path(cdir, "RStudio"),
      overwrite = TRUE,
      recursive = TRUE
    )

  # Check if file copy failed
  if (any(status == FALSE)) {
    cli::cli_abort("Could not copy files to: {pdir}")
  }

  # Find the new profile's editor theme
  prefs <- jsonlite::fromJSON(file.path(cdir, "RStudio", "rstudio-prefs.json"))
  theme <- prefs$editor_theme

  # Check if editor theme is not explicitly set
  if (is.null(theme)) theme <- "Textmate (default)"

  # Apply the new profile's editor theme
  rstudioapi::applyTheme(theme)

  cli::cli_alert_success("Opened profile: {name}")
}

# ------------------------------------------------------------------------------

#' Open Profile Addin
#'
#' Open a saved profile and apply its configuration (with an RStudio prompt).
#'
#' @export
#'
open_profile_addin <- function() {

  # Prompt user input for profile name
  name <- rstudioapi::showPrompt(
    title = "Open Profile",
    message = "What is the name of the profile you want to open?"
  )

  # Check if user cancelled prompt
  if (is.null(name)) return()

  open_profile(name)
}
