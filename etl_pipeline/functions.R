check_request <- function(req) {

  if (req$status_code < 400) return(invisible(NULL))
  orig_out <-  httr::content(req, as = "text")
  out <- try({
    jsonlite::fromJSON(
      orig_out,
      flatten = TRUE)
  }, silent = TRUE)
  if (inherits(out, "try-error")) {
    msg <- orig_out
  } else {
    msg <- out$error$message
  }
  msg <- paste0(msg, "\n")
  stop("HTTP failure: ", req$status_code, "\n", msg, call. = FALSE)
}

video_GET <- function(
  path, query, ...) {

  api_key <- Sys.getenv("YOUTUBE_KEY")
  req <-
    request("https://www.googleapis.com") |>
    req_url_path_append("youtube/v3", path) |>
    req_url_query(!!!query) |>
    req_headers("x-goog-api-key" = api_key) |>
    req_user_agent("tuber (https://github.com/soodoku/tuber)") |>
    req_perform()
  res <- req |> resp_body_json()
  
  check_request(req)

  res
}

get_playlist_vids <- function(
  filter = NULL, part = "contentDetails",
  max_results = 50, video_id = NULL,
  page_token = NULL, simplify = TRUE, ...) {

  if (max_results < 0 || max_results > 50) {
    stop("max_results must be a value between 0 and 50.")
  }

  valid_filters <- c("item_id", "playlist_id")
  if (!(names(filter) %in% valid_filters)) {
    stop("filter can only take one of the following values: item_id, playlist_id.")
  }

  if (length(filter) != 1) {
    stop("filter must be a vector of length 1.")
  }

  translate_filter <- c(item_id = "id", playlist_id = "playlistId")
  filter_name <- translate_filter[names(filter)]
  names(filter) <- filter_name

  querylist <- list(
    part = part,
    maxResults = max(min(max_results, 50), 1),
    pageToken = page_token, videoId = video_id)
  
  querylist <- c(querylist, filter)

  res <- video_GET("playlistItems", querylist, ...)

  if (max_results > 50) {
    page_token <- res$nextPageToken
    while (is.character(page_token)) {
      a_res <- video_GET("playlistItems", list(
        part = part,
        playlistId = unname(filter["playlistId"]),
        maxResults = 50,
        pageToken = page_token
      ))
      res <- c(res, a_res)
      page_token <- a_res$nextPageToken
    }
  }

  if (simplify) {
    allResultsList <- unlist(res[which(names(res) == "items")], recursive = FALSE)
    allResultsList <- lapply(allResultsList, unlist)
    res <-
      do.call(
        rbind.fill,
        lapply(
          allResultsList,
          function(x) as.data.frame(t(x), stringsAsFactors = FALSE)
        )
      )
  }

  res
}

list_channel_vids <- function(
  channel_id = NULL, max_results = 50,
  page_token = NULL, hl = "en-US", ...) {

  if (!is.character(channel_id)) stop("Must specify a channel ID.")

  playlist_id <- gsub("^..", "UU", channel_id)

  # Get playlist videos
  videos <- get_playlist_vids(
    filter = c(playlist_id = playlist_id),
    max_results = max_results,
    page_token = page_token,
    hl = hl, ...)
  
  videos

}
