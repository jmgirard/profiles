# ------------------------------------------------------------------------------

#' List Profiles Function
#'
#' List the current user's saved profiles.
#'
#' @return A character vector of RStudio profiles names.
#' @export
list_profiles <- function() {

  # Find config directory
  cdir <- get_config_dir()

  # Find all profiles in config directory
  x <- dir(cdir, "^RStudio\\.")

  # Remove the prefix from profile names
  profiles <- gsub("^RStudio\\.", "", x)

  profiles
}

# ------------------------------------------------------------------------------

#' List Profiles Addin
#'
#' List the current user's saved profiles.
#'
#' @export
list_profiles_addin <- function() {

  # Look up profiles
  profiles <- list_profiles()

  # Check if there are no profiles
  if (length(profiles) == 0) { profiles <- "(none)" }

  # Print the profiles to console
  cat(paste(c("Profiles: ", profiles), collapse = "\n  "), "\n", sep = "")

}
