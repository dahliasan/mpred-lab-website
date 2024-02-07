import chromadb
import json

chroma_client = chromadb.Client()

# Open the JSON file
with open('db/publications.json', 'r') as file:
    # Load the data from the file
    data = json.load(file)

# Now 'data' contains the data from the JSON file