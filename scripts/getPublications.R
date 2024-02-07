library(dplyr)
library(tidyr)
library(rcrossref)
library(rorcid)

# Set up ORCID token if not already done
# usethis::edit_r_environ()
# Sys.getenv("ORCID_TOKEN")

# convert yaml to df tibble
people <- yaml::read_yaml("db/members.yaml") |>
   purrr::map(function(x) {
      # Loop through each element of the list
      x <- lapply(x, function(y) {
         if (is.null(y)) {
            # Replace NULL with NA of type character
            y <- NA_character_
         }
         return(y)
      })
      
      x <- as_tibble(x)
      x$yearCompleted <- as.numeric(x$yearCompleted)
      return(x)
   }) |> 
   bind_rows()
  

# Extract orcid ID from orcidUrl
people <- people |> 
   mutate(orcid_id = stringr::str_split(orcidUrl, "/")) |> 
   rowwise() |> 
   mutate(orcid_id = orcid_id |> last())

# Get ORCID works
orcid_auth(client_id = Sys.getenv("ORCID_CLIENT_ID"), client_secret = Sys.getenv("ORCID_CLIENT_SECRET"), reauth = TRUE)

# Get works for each person
people_orcid <- people |> 
   filter(!is.na(orcid_id)) |>
   select(name, orcid_id) |> 
   group_by(name, orcid_id) |> 
   mutate(works = works(as.orcid(orcid_id)) |> as_tibble() |> list()) 


people_orcid <- people_orcid |> 
   unnest_wider(works) |> 
   select(name, 
          orcid_id, 
          type, 
          `external-ids.external-id`) |> 
   unnest_longer(c(`external-ids.external-id`, type)) |> 
   unnest_wider(`external-ids.external-id`) |> 
   unnest_longer(c(`external-id-type`, `external-id-value`)) |> 
   mutate(doi = `external-id-value`) |>
   filter(`external-id-type` == "doi") |> 
   select(name, 
          orcid_id, 
          type, 
          doi)

people_orcid <- people_orcid |> 
   distinct(doi)
   
   
people_cr <- cr_works(dois = people_orcid$doi, .progress='text') 
# save(people_cr, file = "db/crworks.RData")   
people_cr <- people_cr |> purrr::pluck("data")

people_final <- people_cr |> 
   select(title, doi, type, created, is.referenced.by.count, abstract, author, url, container.title) |> 
   janitor::clean_names() 

people_final <- people_final |> 
   mutate(authors = purrr::map(author, ~paste0(.x$given, " ", .x$family, collapse = ", "))) |> 
   unnest(authors) 

# Save as JSON
jsonlite::write_json(people_final, "db/publications.json", pretty = TRUE)

# Save as YAML



# create embeddings for abstract and research themes.

# pass abstract to openai api to categorise each publication into research themes:

# save as yaml db 





