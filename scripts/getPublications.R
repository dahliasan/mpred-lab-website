# Retrieve scholarly metadata from google scholar
# scholar method ----------------------------------------------------------
library(scholar)
library(dplyr)
scholar_id <- '8J8xm0kAAAAJ'
publications <- get_publications(scholar_id) %>% tibble()

publications
pubid <- publications$pubid[1]
get_article_scholar_url(scholar_id, pubid)




library(rcrossref)

id <- "0000-0002-7823-7185"
metadata <- rcrossref::cr_works(filter = c(orcid=orcid_id), limit = 1000, sort = "published")
metadata
pubs <- metadata %>% purrr::pluck("data")
pubs

library(rorcid)
# usethis::edit_r_environ()
# Sys.getenv("ORCID_TOKEN")
id <- "0000-0002-7823-7185"
orcid_auth(client_id = Sys.getenv("ORCID_CLIENT_ID"), client_secret = Sys.getenv("ORCID_CLIENT_SECRET"), reauth = TRUE)
orworks <- works(as.orcid(id))

fields <- c("title", 
            "is.referenced.by.count",
            "abstract",
            "author",
            "url")

res <- cr_works(dois = orworks$url.value[1:5], .progress='text')
crworks <- purrr::pluck(res, "data") %>% 
  select(title, is.referenced.by.count, abstract, author, url)


