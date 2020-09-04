library(read.gt3x)
library(SummarizedActigraphy)
library(AGread)
library(dplyr)

source(here::here("code/helper_functions.R"))

gt3x_file = dl("24459680")

act_df = read.gt3x(gt3x_file, verbose = TRUE,
                   asDataFrame = TRUE, imputeZeroes = TRUE)
at = attributes(act_df)
at$header$`Download Date`
at$light_data = NULL
tail(act_df)
last_time = act_df$time[ nrow(act_df)]

bad_time = last_time > at$header$`Download Date`
bad_time = bad_time | (last_time > at$header$`Stop Date`)

act_df$time2 = at$start_time +
  lubridate::as.period(
    1:nrow(act_df)/at$sample_rate,
    unit = "secs")

last_time2 = act_df$time2[ nrow(act_df)]
last_time2 == at$header$`Download Date`
last_time2 == at$header$`Stop Date`

act_df_fixed= SummarizedActigraphy::fix_zeros(act_df)

csv_file =  dl("24459683", ".csv.gz")

df = read_acc_csv(csv_file)
hdr = df$hdr
df = df$data
colnames(df) = sub("Accelerometer ", "", colnames(df))

at$header$`Stop Date`

dim(act_df)
dim(df)
tail(df)
tail(act_df)

act_df2 = act_df[1:nrow(df), ]
stopifnot(all(df[, c("X", "Y", "Z")] == act_df2[, c("X", "Y", "Z")]))

fj = full_join(act_df)


