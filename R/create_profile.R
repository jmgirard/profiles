# ------------------------------------------------------------------------------
#' Create Profile Addin
#'
#' Create a new RStudio profile from the current global options using the
#' user-specified name.
#'
#' @export
createProfile <- function() {

  # Prompt user input for profile name
  name <- rstudioapi::showPrompt(
    title = "Create Profile",
    message = "What do you want to name this new profile?"
  )

  # Check if user cancelled prompt
  if (is.null(name)) return()

  create_profile(name)
}

# ------------------------------------------------------------------------------
#' Create Profile Function
#'
#' Create a new RStudio profile from the current global options using the
#' specified name.
#'
#' @param name A string indicating the name of the profile to create.
#' @param overwrite A logical indicating whether to overwrite files if the
#'   profile directory already exists.
#' @export
create_profile <- function(name, overwrite = TRUE) {

  # Assertions
  assertthat::assert_that(assertthat::is.string(name))
  assertthat::assert_that(assertthat::is.flag(overwrite))

  # Find config directory
  cdir <- get_config_dir()

  # Build output directory
  outdir <- file.path(cdir, paste0("RStudio.", name))

  # Create output directory if needed
  if (!dir.exists(outdir)) dir.create(outdir)

  # Try to copy the current profile to the output directory
  status <- file.copy(
    from = dir(
      file.path(cdir, "RStudio"),
      full.names = TRUE
    ),
    to = outdir,
    overwrite = overwrite,
    recursive = TRUE
  )

  # Check if file copy failed
  if (any(status == FALSE)) stop("Error creating profile")

  message(paste0("Created profile: ", name))
}
