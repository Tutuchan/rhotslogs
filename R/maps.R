#' fetch maps information
#'
#' @importFrom jsonlite fromJSON
#' @export

hots_maps <- function() {
  jsonlite::fromJSON(build_url("maps"))
}
