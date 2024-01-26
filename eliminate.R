# Install and load necessary packages
if (!requireNamespace("textTinyR", quietly = TRUE)) {
  install.packages("textTinyR")
}
if (!requireNamespace("tidytext", quietly = TRUE)) {
  install.packages("tidytext")
}
if (!requireNamespace("magrittr", quietly = TRUE)) {
  install.packages("magrittr")
}
library(textTinyR)
library(tidytext)
library(magrittr)

# Specify the input folder containing .txt files
input_folder <- "C:/Users/Deepthi Patric/Desktop/brian/cleaned_st"

# Create the output folder if it doesn't exist
output_folder <- "C:/Users/Deepthi Patric/Desktop/brian/output_eliminated"
if (!dir.exists(output_folder)) dir.create(output_folder)

# Define the words to eliminate
words_to_eliminate <- c("Agreement", "Addition", "Similarity", "in addition", "not only...but also", 
                        "moreover", "furthermore", "as well as", "and", "so", "yet", "furthermore", 
                        "in addition", "also", "besides", "further", "same way", "and in like manner", 
                        "and in the same")

# Create a regular expression pattern for the words and special characters
pattern <- paste0("\\b(?:", paste(words_to_eliminate, collapse = "|"), ")\\b|[[:punct:]]")

# Get a list of all .txt files in the input folder
txt_files <- list.files(input_folder, pattern = "\\.txt$", full.names = TRUE)

# Initialize a variable to store combined cleaned text
combined_cleaned_text <- character()

# Loop through each file
for (file in txt_files) {
  # Read the text document
  text <- readLines(file, warn = FALSE)
  
  # Remove the specified words and special characters
  cleaned_text <- gsub(pattern, "", text, ignore.case = TRUE)
  
  # Append cleaned text to the variable
  combined_cleaned_text <- c(combined_cleaned_text, cleaned_text)
  
  # Extract the original file name without extension
  original_filename <- tools::file_path_sans_ext(basename(file))
  
  # Create the output file path
  output_file <- file.path(output_folder, paste0(original_filename, "_eliminated.txt"))
  
  # Write the cleaned text to the output file
  writeLines(cleaned_text, output_file)
}

# Combine cleaned text into a single document
combined_text <- paste(combined_cleaned_text, collapse = " ")
# Tokenize words from the combined text using tidytext
tokens <- tibble(text = combined_text) %>%
  unnest_tokens(word, text)

# Print the result
print(tokens)
