rm(list = ls())
library(rmarkdwon)
library(leaflet)

setwd('/Users/kerstinwolf/DS Projects/GitHub/US_City_Report_Generator_Project/code')

report_renderer <- function(file_path, file_path2, file_name, report_title){
  a_file_path <- paste0(file_path, file_name)
  output_name <- paste0(stringr::str_split(file_name, pattern = 'data.csv')[[1]][1], 'weather_report.pdf')
  rmarkdown::render('US_City_Report_Template.Rmd',
                    params = list(file_path = a_file_path, file_path2 = file_path2, report_title = report_title),
                    output_file = output_name,
                    output_dir = ('/Users/kerstinwolf/DS Projects/GitHub/US_City_Report_Generator_Project/reports'))
}

file_path <- '/Users/kerstinwolf/DS Projects/GitHub/US_City_Report_Generator_Project/data/city_weather_data/'
files <- list.files(file_path)
#print(files)

file_path2 <- '/Users/kerstinwolf/DS Projects/GitHub/US_City_Report_Generator_Project/data/weather_station_location.csv'

report_return <- lapply(seq_along(files), function(x){
  a_file <- files[x]
  a_df <- read.csv(file = paste0(file_path, a_file))
  a_title <- paste0('Weather Report for ', a_df$Location[1])
  report_renderer(file_path = file_path,
                  file_path2 = file_path2,
                  file_name = a_file,
                  report_title = a_title)
})

# add cover page
# add image to cover page
# add headers and footers
# possibly adjust page number
# add more content
# add station param and put it where my name currently is
# maybe still credit myself somewhere - maybe the header or footer?
# figure out what new fancyhdr and titling packages are
# add bit so that warnings and errors don't print in the reports
# double check coords are correct


