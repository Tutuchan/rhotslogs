#' fetch events information
#'
#' @importFrom jsonlite fromJSON
#' @export

hots_events <- function(event_id = NULL) {
  url <- build_url("events")
  if (!is.null(event_id)) url <- file.path(url, event_id)

  jsonlite::fromJSON(url)
}
