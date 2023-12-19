# Functions to fetch publications data

# From Google Scholar -----------------------------------------------------
library(scholar)
library(dplyr)
library(yaml)

hindell_id <- '8J8xm0kAAAAJ'
lea_id <- 'CEBV6KoAAAAJ'
younger_id <- 'U7aQd08AAAAJ'
bestley_id <- '9Nl9LvkAAAAJ'
scholar_ids <- c(lea_id, younger_id, bestley_id)

# Get the most recent 20 publications from all authors combined
publications <- scholar_ids %>% purrr::map(function(x) {
  get_publications(x) %>% 
    tibble() %>% mutate(author_id = x)
  
  }) %>% bind_rows() %>% tibble()

most_recent <- publications %>% 
  arrange(desc(year)) %>% 
  slice(1:15)

# Get most recent 5 publications from hindell

hindell_publications <- get_publications(hindell_id) %>% tibble() %>% 
  mutate(author_id = hindell_id)
hindell_most_recent <- hindell_publications %>% 
  arrange(desc(year)) %>% 
  slice(1:5)

# Add hindell to most recent
most_recent <- most_recent %>% bind_rows(hindell_most_recent)

# Add url & abstract to most recent
most_recent <- most_recent %>% 
  rowwise() %>% 
  mutate(url = paste0("https://scholar.google.com.au/citations?view_op=view_citation&hl=en&user=", author_id, "&citation_for_view=",author_id,":", pubid))

# convert the dataframe to a YAML string
yaml_string <- as.yaml(most_recent, column.major = FALSE)

# save the YAML string to a file
write(yaml_string, file = "db/publications.yaml")
