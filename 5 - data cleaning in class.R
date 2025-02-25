library(tidyverse)

raw <- read_csv('https://www.dropbox.com/scl/fi/ug8tbxsdd2qtsfqwnnox1/dollar_store.csv?rlkey=fu36g6uhfpx8u644d1rpsq11i&dl=1')
raw %>% glimpse()
df <- raw %>%  janitor::clean_names()

# Convert to number formats: price, star_rating, review_count, stock_status, unit_size
#   Goals:   (1) Don't lose information
#            (2) Missing where appropriate, but only where appropriate
df %>% 
  select(date_added, first_sold_day) %>% 
  mutate(date_added_c = dmy(date_added)) %>% 
  mutate(first_sold_c = mdy(first_sold_day))

str_c('hello', 'world', sep = ' ')

df %>%
  select(starts_with('first')) %>% 
  mutate(first_sold_ts = str_c(first_sold_day, first_sold_time)) %>% 
  mutate(try_this = mdy_hms(first_sold_ts))

# Create usable brand and product_name columns from the product_info column
#   Hints:  (1) Ensure missingness is appropriate. 
#           (2) If possible, exploit any repeated structure in the column
df %>% 
  select(price) %>% 
  mutate(price_c = parse_number(price))

df %>% 
  select(review_count) %>% 
  mutate(review_count_c = parse_number(review_count))
  arrange(review_count_c)
  
df %>% 
  select(product_info) %>% 
  separate_wider_delim(product_info, delim = ' - ', 
                       names = c('brand', 'product'),
                       too_many = 'merge') %>% 
  mutate(brand = str_remove(brand, 'Brand:')) %>% 
  mutate(product = str_remove(product, 'Product:'))




# Create usable brand and product_name columns from the product_info column
#   Hints:  (1) Ensure missingness is appropriate. 
#           (2) If possible, exploit any repeated structure in the column


# Convert date columns to date and/or date-time columns, then calculate how many
# days each product sat on the shelf before its first sale.


