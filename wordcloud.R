# Library
library(tidytext)
library(dplyr)
library(wordcloud)
library(stringr)

# Tidy the dataset
raw_text <- read_delim("speech.txt", "/n", col_names = "text", trim_ws = TRUE)

# Build term-document matrix
text_tibble <- raw_text %>% 
  unnest_tokens(word, text) %>% 
  anti_join(stop_words) %>% 
  mutate(word = str_replace_all(word, "\\d+", "")) %>%
  filter(word != "") %>% 
  group_by(word) %>% 
  summarise(frequency = n())

# Build wordcloud
wordcloud(words = text_tibble$word, freq = text_tibble$frequency, max.words = 100, random.order = FALSE, rot.per = 0.35,
          colors = c("red", "blue"))
