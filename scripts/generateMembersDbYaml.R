# Run this every time members.csv changes.
# Converts csv to yaml db for use on website

library(readr)
library(yaml)

# Read CSV
data <- read_csv("db/members.csv")

# Remove list names
yaml <- as.yaml(data, column.major=FALSE)

# Replace na.character and na.real with ~
yaml <- gsub(".na.character", "~", yaml)
yaml <- gsub(".na.real", "~", yaml)

# Save the YAML string to a file
write(yaml, file = "db/members.yaml")
