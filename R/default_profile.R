# ------------------------------------------------------------------------------
#' Default Profile Addin
#'
#' Ask user to confirm reverting to the default RStudio profile.
#'
#' @export
defaultProfile <- function() {

  # Prompt user to confirm the reversion
  confirm <- rstudioapi::showQuestion(
    title = "Default Profile",
    message = "This will revert to the default RStudio profile and your current profile will be lost (unless you save it first by creating a profile with it). Are you sure you want to continue?",
  )

  # Check if user cancelled prompt
  if (confirm == FALSE) return()

  default_profile()
}

# ------------------------------------------------------------------------------
#' Default Profile Function
#'
#' Revert to the default RStudio profile.
#'
#' @export
default_profile <- function() {

  # Clear the current profile
  clear_current_profile()

  # Apply the default editor theme
  rstudioapi::applyTheme("Textmate (default)")

  message("Reverted to default profile")
}
