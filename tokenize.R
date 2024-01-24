# Install and load the tokenizers package
if (!requireNamespace("tokenizers", quietly = TRUE)) {
  install.packages("tokenizers")
}
library(tokenizers)

# Directory containing your text files
input_directory <- './folder_containing_eliminated_joining_words'

# Output file for tokenized words
output_file_path <- './output_for_single_tokenized_file.txt'

# Function to tokenize words from a text file
tokenize_file <- function(file_path) {
  text <- tolower(readLines(file_path, warn = FALSE))
  tokens <- unlist(tokenize_words(text))
  return(tokens)
}

# List to store all tokenized words
all_tokens <- c()

# Loop through each text file in the directory
files <- list.files(input_directory, pattern = "\\.txt$", full.names = TRUE)
for (file_path in files) {
  tokens <- tokenize_file(file_path)
  all_tokens <- c(all_tokens, tokens)
}

# Write tokenized words to the output file
writeLines(paste(all_tokens, collapse = " "), output_file_path)

cat(paste("Tokenized words written to", output_file_path, "\n"))
