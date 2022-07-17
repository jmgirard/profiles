# ------------------------------------------------------------------------------

#' List Profiles Function
#'
#' List the current user's saved profiles.
#'
#' @param quiet A flag indicating whether to print profiles to console.
#' @return A character vector of RStudio profiles names.
#' @export
list_profiles <- function(quiet = FALSE) {

  # Assertions
  assertthat::assert_that(assertthat::is.flag(quiet))

  # Find config directory
  cdir <- get_config_dir()

  # Find all profiles in config directory
  x <- dir(cdir, "^RStudio\\.")

  # Remove the prefix from profile names
  profiles <- gsub("^RStudio\\.", "", x)

  if (quiet == FALSE) {
    # Check if there are no profiles
    if (length(profiles) == 0) { profiles <- "(none)" }

    # Print the profiles to console
    cli::cli_h3("Profiles")
    ul <- cli::cli_ul()
    cli::cli_li(profiles)
    cli::cli_end(ul)
    cat("\n")
  }

  profiles
}

# ------------------------------------------------------------------------------

#' List Profiles Addin
#'
#' List the current user's saved profiles.
#'
#' @export
list_profiles_addin <- function() {

  invisible(list_profiles(quiet = FALSE))

}
