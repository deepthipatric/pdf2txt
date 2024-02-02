# packages
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

# input folder for cleaned text
input_folder <- "./cleaned_text"

#output folder
output_folder <- "./output_eliminated"
if (!dir.exists(output_folder)) dir.create(output_folder)

# words to eliminate
words_to_eliminate <- c("Agreement", "Addition", "Similarity", "in addition", "not only...but also", 
                        "moreover", "furthermore", "as well as", "and", "so", "yet", "furthermore", 
                        "in addition", "also", "besides", "further", "same way", "and in like manner", 
                        "and in the same")

# words and regular characters
pattern <- paste0("\\b(?:", paste(words_to_eliminate, collapse = "|"), ")\\b|[[:punct:]]")

# list of all .txt files in  input folder
txt_files <- list.files(input_folder, pattern = "\\.txt$", full.names = TRUE)

# combined cleaned text
combined_cleaned_text <- character()

# loop each file in folder
for (file in txt_files) {
  # read txt document 
  text <- readLines(file, warn = FALSE)
  
  # remove words and sp char
  cleaned_text <- gsub(pattern, "", text, ignore.case = TRUE)
  
  #append
  combined_cleaned_text <- c(combined_cleaned_text, cleaned_text)
  
  # extract withouut extension
  original_filename <- tools::file_path_sans_ext(basename(file))
  
  # output file path 
  output_file <- file.path(output_folder, paste0(original_filename, "_eliminated.txt"))
  
  # cleaned text
  writeLines(cleaned_text, output_file)
}

# combine to single txt file
combined_text <- paste(combined_cleaned_text, collapse = " ")
# Tokenize words from the combined text using tidytext
tokens <- tibble(text = combined_text) %>%
  unnest_tokens(word, text)

# print result
print(tokens)
