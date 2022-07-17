# ------------------------------------------------------------------------------

#' Remove Profile Function
#'
#' Remove a saved profile.
#'
#' @param name A string indicating the name of the profile to remove.
#' @param force A flag indicating whether permissions should be changed (if
#'   possible) to allow the directory and its files to be removed.
#' @export
#'
remove_profile <- function(name, force = FALSE) {

  # Assertions
  assertthat::assert_that(assertthat::is.string(name))
  assertthat::assert_that(assertthat::is.flag(force))

  # Find config directory
  cdir <- get_config_dir()

  # Build profile directory
  pdir <- file.path(cdir, glue("RStudio.{name}"))

  # Check if profile directory exists
  if (!dir.exists(pdir)) {
    cli::cli_abort('Could not find profile: {name}')
  }

  # Try to remove the profile directory
  status <- unlink(pdir, recursive = TRUE, force = force, expand = FALSE)

  # Check if file copy failed
  if (status == 1) {
    cli::cli_abort("Failed to remove one or more files")
  }

  cli::cli_alert_success('Removed profile: {name}')
}

# ------------------------------------------------------------------------------

#' Remove Profile Addin
#'
#' Remove a saved profile (with an RStudio prompt).
#'
#' @export
#'
remove_profile_addin <- function() {

  # Prompt user input for profile name
  name <- rstudioapi::showPrompt(
    title = "Remove Profile",
    message = "What is the name of the profile you want to remove?"
  )

  # Check if user cancelled prompt
  if (is.null(name)) return()

  remove_profile(name)
}
