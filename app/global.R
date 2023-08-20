library(shiny)
library(shinyWidgets)
library(bslib)
library(httr2)
library(purrr)
library(glue)
library(aws.s3)
library(DT)

# create s3 connection
Sys.setenv(
  "AWS_ACCESS_KEY_ID" = Sys.getenv("personal_aws_access_key"),
  "AWS_SECRET_ACCESS_KEY" = Sys.getenv("personal_aws_secret_key"),
  "AWS_DEFAULT_REGION" = "us-west-1"
)

# personal bucket
yt_app_bucket <- Sys.getenv("s3ytfeedapp")

# Load S3 data
yt_data_wrangled <- aws.s3::s3readRDS(
  "yt_data_wrangled.rds", yt_app_bucket
)

yt_data_final <- aws.s3::s3readRDS(
  "yt_data_final.rds", yt_app_bucket
)

my_theme <- bs_theme(
  bootswatch = "darkly",
  heading_font = font_google("Lobster", wght = 400),
  base_font = font_collection(
    # font_google("Roboto Slab"),
    font_google("Merriweather")
  ),
  code_font = font_google("Inconsolata"),
  font_scale = 1
)