rm(list = ls())
library(magrittr)
library(ggplot2)
search()

# All data frames 

# original Chicago data
chicago_df <- read.csv('/Users/kerstinwolf/DS Projects/GitHub/US_City_Report_Generator_Project/data/city_weather_data/chicago_data.csv', header = TRUE)

a_df2 <- read.csv('/Users/kerstinwolf/DS Projects/GitHub/US_City_Report_Generator_Project/data/weather_station_location.csv', header = TRUE)

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
  dplyr::select(datetime, temp = Temperature_F, dewpoint = DewPoint_F, humidity = Humidity_Percentage, wind = Wind, windspeed = WindSpeed_mph, windgust = WindGust_mph, pressure = Pressure_in, precip = Precipitation_in, condition = Condition, loc = Location, station = Station)

df_loc <- a_df2 %>%
  dplyr::select(station = Station, lat = Lat, long = Long) %>%
  dplyr::slice(grep(as.character(df$station[1]), station))

grep(df$station[1], df_loc$station)

# dataframe max and min temp of each day
df_temp <- df %>%
  dplyr::select(datetime, temp) %>%
  dplyr::group_by(date = as.Date(datetime)) %>%
  dplyr::summarize(min_temp = min(temp),
                   max_temp = max(temp))
  
#####################

# All tables





####################

# everything graphs

# temp graph
df_temp %>%
  ggplot() +
  geom_line(aes(x = date, y = max_temp, color = 'red', group = 2)) +
  geom_line(aes(x = date, y = min_temp, color = 'blue', group = 1)) +
  labs(x = 'Date', y = 'Temperature (F)', color = '') +
  ggtitle('Minimum and Maximum Temperatures in July 2021') +
  theme_bw() +
  theme(legend.margin = margin(0, 0, 0, 0),
        legend.key.size = unit(0.5, 'cm')) +
  scale_color_manual(values = c('red' = 'red', 'blue' = 'blue'), labels = c('Maximum Temperature', 'Minimum Temperature'))







