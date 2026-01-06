
rm(list=ls())
library(readxl)
library(tidyverse)
library(ggplot2)
library(dplyr)


# Set the working directory where data and figures will be stored

setwd("~/These-Elena/Elena/These_Elena/2024-2025/09_Opinion_Asa/2nd_Submission_JofAppEcology/Data_Aquaculture-production")

## 1. Download Excel file from Git hub

# Address of Oficialdegui et al., 2025 data (https://doi.org/10.1111/raq.70037)

address_data_aquaculture <- "https://raw.githubusercontent.com/IsmaSA/Aquaculture/master/Data/AquaInvadersFAO%20-%20RAW%20(1).xlsx"

download.file(
  url = address_data_aquaculture,
  destfile = "Aquaculture_Data.xlsx",
  mode = "wb",
  quiet = TRUE
)

Aquacultureprod <- read.xlsx("Aquaculture_Data.xlsx")



## 2. Crustacean production

Crustaceanprod <- Aquacultureprod %>%
  filter(Phylum == "Arthropoda") %>%
  select(all_of(paste0(1950:2021, "a")))


## Sum total productions per year

year_totals <- colSums(Crustaceanprod, na.rm = TRUE)

year_totals_df <- tibble(
  Year = names(year_totals),
  Total = as.numeric(year_totals)
)


## Plot production trends

year_totals_df %>%
  ggplot(aes(x=Year, y=Total)) +
  geom_point(shape=21, color="black", fill="#69b3a2", size=3) +
  theme(axis.text = element_text(angle = 90)) +
  ggtitle("Crustacean production worldwide")
