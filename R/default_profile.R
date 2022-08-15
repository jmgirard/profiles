# ------------------------------------------------------------------------------

#' Default Profile Function
#'
#' Revert to the default profile configuration.
#'
#' @export
#'
default_profile <- function() {

  # Remove the current profile
  clear_current_profile()

  # # Apply the default editor theme
  # rstudioapi::applyTheme("Textmate (default)")

  restart_rstudio()
  cli::cli_alert_success("Reverted to default profile")
}

# ------------------------------------------------------------------------------

#' Default Profile Addin
#'
#' Revert to the default profile configuration (with an RStudio prompt).
#'
#' @export
#'
default_profile_addin <- function() {

  # Prompt user to confirm the reversion
  confirm <- rstudioapi::showQuestion(
    title = "Default Profile",
    message = glue(
      "This will revert to the default RStudio profile and your current ",
      "profile will be lost (unless you save it first by creating a profile ",
      "with it). Are you sure you want to continue?"
    )
  )

  # Check if user cancelled prompt
  if (confirm == FALSE) return()

  default_profile()
}
