
library(httr)
library(xml2)

orcid_id <- "0000-0002-7823-7185" # Replace with the author's ORCID ID
api_url <- paste0("https://pub.orcid.org/v3.0/", orcid_id, "/works")

response <- GET(api_url, add_headers(Accept = "application/xml"))
content <- content(response, "text", encoding = "UTF-8")
xml <- read_xml(content)

work_nodes <- xml_find_all(xml, ".//work:work-summary")
titles_text <- sapply(work_nodes, function(x) xml_text(xml_find_first(x, ".//work:title")))
years_text <- sapply(work_nodes, function(x) xml_text(xml_find_first(x, ".//common:publication-date/common:year")))
journals_text <- sapply(work_nodes, function(x) xml_text(xml_find_first(x, ".//work:journal-title")))
urls_text <- sapply(work_nodes, function(x) xml_text(xml_find_first(x, ".//common:url")))
types_text <- sapply(work_nodes, function(x) xml_text(xml_find_first(x, ".//work:type")))
publications <- tibble(Title = titles_text, Year = years_text, Type = types_text, Journal = journals_text, Url = urls_text)



# CrossRef  ---------------------------------------------------------------

library(httr)
library(jsonlite)

api_url <- paste0("https://api.crossref.org/works?sort=published&filter=orcid:", orcid_id)

response <- GET(api_url)
content <- content(response, "text", encoding = "UTF-8")
json_data <- fromJSON(content)

items <- json_data$`message`$items %>%  tibble()
items$title

titles_text <- sapply(items, function(x) x$title[[1]])
years_text <- sapply(items, function(x) x$`published-print`$`date-parts`[[1]][1])
authors_text <- sapply(items, function(x) paste(sapply(x$author, function(y) paste(y$given, y$family)), collapse = ", "))
journals_text <- sapply(items, function(x) x$`container-title`[[1]])
doi_urls_text <- sapply(items, function(x) paste0("https://doi.org/", x$DOI))

publications <- data.frame(Title = titles_text, Year = years_text, Authors = authors_text, Journal = journals_text, DOI_URL = doi_urls_text)


