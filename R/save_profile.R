# ------------------------------------------------------------------------------

#' Save Profile Function
#'
#' Save the current configuration as a profile.
#'
#' @param name A string indicating the name of the profile to create.
#' @param overwrite A logical indicating whether to overwrite files if the
#'   profile directory already exists.
#' @export
#'
save_profile <- function(name, overwrite = TRUE) {

  # Assertions
  assertthat::assert_that(assertthat::is.string(name))
  assertthat::assert_that(assertthat::is.flag(overwrite))

  # Find config directory
  cdir <- get_config_dir()

  # Build the profile directories
  olddir <- file.path(cdir, "RStudio")
  newdir <- file.path(cdir, glue("RStudio.{name}"))

  # Create new directory if needed
  if (!dir.exists(newdir)) {
    status <- dir.create(newdir)

    # Check if dir create failed
    if (any(status == FALSE)) {
      cli::cli_abort("Could not create folder: {newdir}")
    }
  }

  # Try to copy the old profile to the new profile directory
  status <- file.copy(
    from = dir(olddir, full.names = TRUE),
    to = newdir,
    overwrite = overwrite,
    recursive = TRUE
  )

  # Check if file copy failed
  if (any(status == FALSE)) {
    cli::cli_abort("Could not copy files to: {newdir}")
  }

  cli::cli_alert_success("Saved profile: {name}")
}

# ------------------------------------------------------------------------------

#' Save Profile Addin
#'
#' Save the current configuration as a profile (with an RStudio prompt).
#'
#' @export
#'
save_profile_addin <- function() {

  # Prompt user input for profile name
  name <- rstudioapi::showPrompt(
    title = "Save Profile",
    message = "What do you want to name this new profile?"
  )

  # Check if user cancelled prompt
  if (is.null(name)) return()

  save_profile(name)
}
