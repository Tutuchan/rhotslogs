#' fetch player information
#'
#' @param player_id a integer, the hotslogs player id
#' @param region a character among 'EU', 'US', 'CN', 'KR'
#' @param battletag a character, the Blizzard battletag of a player in "Name#1234" format
#' @importFrom jsonlite fromJSON
#' @export

hots_player <- function(player_id = NULL, region = NULL, battletag = NULL) {

  if (is.null(player_id)&is.null(region)&is.null(battletag))
    stop("either call by player id or region+battletag!")
  if (!is.null(player_id)&!(is.null(region)&is.null(battletag)))
    stop("either call by player id or region+battletag but not both!")

  if (is.null(region) + is.null(battletag) == 1)
    stop("missing region or battletag!")


  url <- build_url("players")
  url <- if (!is.null(player_id)) file.path(url, player_id) else
    file.path(url, transform_region(region), transform_bt(battletag))

  res <- jsonlite::fromJSON(url)

  structure(
    list(
      id = res$PlayerID,
      name = res$Name,
      rankings = res$LeaderboardRankings
    ),
    class = "hots_player"
  )
}

#' @export
print.hots_player <- function(x, ...) {
  cat(sprintf(">> <HOTS> %s\n", x$name))
  cat(sprintf(">> HotsLogs id: %s\n", x$id))
  cat(">> Rankings:\n")
  lapply(seq_along(x$rankings), function(i) {
    cat(
      sprintf(
        ">>   - %s: %s%s%s\n",
        prettify_game_mode(x$rankings$GameMode[i]),
        prettify_league(x$rankings$LeagueID[i]),
        prettify_rank(x$rankings$LeagueRank[i]),
        prettify_mmr(x$rankings$CurrentMMR[i])
      )
    )
  })
}

prettify_game_mode <- function(gm) {
  gsub('([[:upper:]])', ' \\1', gm)
}

prettify_league <- function(id) {
  if (!is.na(id)) leagues[as.numeric(id) + 1] else "No data"
}

prettify_rank <- function(rank) {
  if (!is.na(rank)) paste0(" (", as.numeric(rank), ")") else ""
}

prettify_mmr <- function(mmr) {
  if (!is.na(mmr)) paste0(" (MMR: ", mmr, ")") else ""
}
