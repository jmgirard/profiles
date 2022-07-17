# ------------------------------------------------------------------------------
#' Load Profile Addin
#'
#' Ask user for the name of an RStudio profile to load and then apply it.
#'
#' @export
loadProfile <- function() {

  # Prompt user input for profile name
  name <- rstudioapi::showPrompt(
    title = "Load Profile",
    message = "What is the name of the profile you want to load?"
  )

  # Check if user cancelled prompt
  if (is.null(name)) return()

  load_profile(name)
}

# ------------------------------------------------------------------------------
#' Load Profile Function
#'
#' Apply the RStudio profile with the specified name.
#'
#' @param name A string indicating the name of the profile to load.
#' @export
load_profile <- function(name) {

  # Assertions
  assertthat::assert_that(assertthat::is.string(name))

  # Remove the current profile
  clear_current_profile()

  # Find the config directory
  cdir <- get_config_dir()

  # Try to copy the profile to the config directory
  status <-
    file.copy(
      from = dir(
        file.path(cdir, paste0("RStudio.", name)),
        full.names = TRUE
      ),
      to = file.path(cdir, "RStudio"),
      overwrite = TRUE,
      recursive = TRUE
    )

  # Check if file copy failed
  if (any(status == FALSE)) stop("Error loading profile")

  # Find the loaded profile's preferences
  prefs <- rjson::fromJSON(
    file = file.path(cdir, "RStudio", "rstudio-prefs.json")
  )

  # Apply the loaded profile's editor theme
  rstudioapi::applyTheme(prefs$editor_theme)

  message(paste0("Loaded profile: ", name))
}
