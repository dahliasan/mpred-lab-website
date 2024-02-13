library(readr)
library(yaml)
library(tidyr)
library(dplyr)

# Read CSV
data <- read_csv("db/members.csv")

# Remove list names
yaml <- as.yaml(data, column.major=FALSE)

# Save the YAML string to a file
write(yaml, file = "db/members.yaml")
