# ------------------------------------------------------------------------------
#' List Profiles Addin
#'
#' Print the names of all RStudio Profiles
#'
#' @export
listProfiles <- function() {

  profiles <- list_profiles()
  if (length(profiles) == 0) { profiles <- "(none)" }

  cat(paste(c("Profiles: ", profiles), collapse = "\n  "), "\n", sep = "")

}

# ------------------------------------------------------------------------------
#' List Profiles Function
#'
#' Find the names of all RStudio profiles and return as a character vector.
#'
#' @return A character vector of RStudio profiles names.
#' @export
list_profiles <- function() {

  cdir <- get_config_dir()

  x <- base::dir(cdir, "^RStudio.")

  profiles <- base::gsub("^RStudio\\.", "", x)

  profiles
}
