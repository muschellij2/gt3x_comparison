sub_thing = function(hdr, string) {
  x = hdr[grepl(string, hdr)]
  x = gsub(string, "", x)
  x = trimws(x)
}


dl = function(file_id, ext = ".gt3x.gz") {
  url = paste0("https://ndownloader.figshare.com/files/", file_id)
  destfile = tempfile(fileext = ext)
  curl::curl_download(url, destfile = destfile, quiet = FALSE)
  destfile
}

read_acc_csv = function(file, ...) {
  hdr = readr::read_lines(file, n_max = 10)
  suppressWarnings({
    df = readr::read_csv(
    file, skip = 10,
    col_types = readr::cols(
      .default = readr::col_double(),
      Date = readr::col_character(),
      Time = readr::col_time(format = "")
    ), ...)
  })
  readr::stop_for_problems(df)
  
  st = sub_thing(hdr, "Start Time")
  sd = sub_thing(hdr, "Start Date")
  srate = as.numeric(sub(".*at (\\d*) Hz.*", "\\1", hdr[1]))
  start_date = lubridate::mdy_hms(paste0(sd, " ", st))
  
  df$time = seq(0, nrow(df) - 1)/srate
  df$time = start_date + df$time
  class(df) = "data.frame"
  colnames(df) = trimws(sub("Accelerometer", "", colnames(df)))
  
  stopifnot(!anyNA(df$time))
  list(
    header = hdr,
    data = df
  )
}
