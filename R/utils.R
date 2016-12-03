BASE_URL <- "https://api.hotslogs.com/Public"

endpoints <- list(
  heroes = "Data/Heroes",
  maps = "Data/Maps",
  events = "Events",
  players = "Players"
)

regions <- list(
  US = 1,
  EU = 2,
  KR = 3,
  CN = 5
)

leagues <- c("Master", "Diamond", "Platinum", "Gold", "Silver", "Bronze")

build_url <- function(endpoint) {
  file.path(BASE_URL, endpoints[[endpoint]])
}

transform_bt <- function(battletag) {
  gsub("#", "_", battletag)
}

transform_region <- function(region) {
  if (!region %in% names(regions)) stop(sprintf("invalid region, pick one in %s", toString(names(regions))))
  regions[[region]]
}
