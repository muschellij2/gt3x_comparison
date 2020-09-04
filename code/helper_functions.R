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
  hdr = readLines(file, n = 10)
  st = sub_thing(hdr, "Start Time")
  sd = sub_thing(hdr, "Start Date")
  format = sub(".*date format (.*) at.*", "\\1", hdr[1])
  if (format == "") {
    warning("No format for date in the header, using mdy")
    format = "mdy"
  } else {
    format = tolower(format)
    format = c(sapply(strsplit(format, "/"), substr, 1,1))
    format = paste(format, collapse = "")
  }
  all_formats = c("ydm", "dym", "ymd", "myd", "dmy", "mdy")
  stopifnot(format %in% all_formats)
  lubridate_func = paste0(format, "_hms")
  lubridate_func = getFromNamespace(lubridate_func, "lubridate")
  start_date = do.call(lubridate_func, args = list(paste0(sd, " ", st)))
  srate = as.numeric(sub(".*at (\\d*) Hz.*", "\\1", hdr[1]))
  
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
