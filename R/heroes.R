#' fetch heroes information
#'
#' @importFrom jsonlite fromJSON
#' @export

hots_heroes <- function() {
  jsonlite::fromJSON(build_url("heroes"))
}
