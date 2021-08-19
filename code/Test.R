rm(list = ls())
library(magrittr)
search()

# All data framces 

# original Chicago dataa
chicago_df <- read.csv('/Users/kerstinwolf/DS Projects/GitHub/US_City_Report_Generator_Project/data/city_weather_data/chicago_data.csv', header = TRUE)

# clean up the data
df_clean <- chicago_df %>%
  dplyr::mutate(datetime = paste(Date, Time)) %>%
  dplyr::mutate(datetime = strptime(datetime, format = '%m/%d/%y %I:%M %p')) %>%
  dplyr::mutate(Temperature_F = gsub('°F', '', Temperature_F)) %>%
  dplyr::mutate(DewPoint_F = gsub('°F', '', DewPoint_F)) %>%
  dplyr::mutate(Humidity_Percentage = gsub('%', '', Humidity_Percentage)) %>%
  dplyr::mutate(WindSpeed_mph = gsub('mph', '', WindSpeed_mph)) %>%
  dplyr::mutate(WindGust_mph = gsub('mph', '', WindGust_mph)) %>%
  dplyr::mutate(Pressure_in = gsub('in', '', Pressure_in)) %>%
  dplyr::mutate(Precipitation_in = gsub('in', '', Precipitation_in))

# the clean data reorganized in a way so that I can easily work with it
df <- df_clean %>%
  dplyr::select(datetime, temp = Temperature_F, dewpoint = DewPoint_F, humidity = Humidity_Percentage, wind = Wind, windspeed = WindSpeed_mph, windgust = WindGust_mph, pressure = Pressure_in, precip = Precipitation_in, condition = Condition, loc = Location, Station)

#####################

# All tables





####################

# everything graphs









