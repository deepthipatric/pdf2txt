# install and load the tokenizers package
if (!requireNamespace("tokenizers", quietly = TRUE)) {
  install.packages("tokenizers")
}
library(tokenizers)

# folder containing your text files
input_directory <- './output_eliminated'

# output file for tokenized words
output_file_path <- 'C:/Users/Deepthi Patric/Desktop/brian/token_words/token.txt'

# function to tokenize words from a text file
tokenize_file <- function(file_path) {
  text <- tolower(readLines(file_path, warn = FALSE))
  tokens <- unlist(tokenize_words(text))
  return(tokens)
}

# list to store all tokenized words
all_tokens <- c()

# loop through each text file in the directory
files <- list.files(input_directory, pattern = "\\.txt$", full.names = TRUE)
for (file_path in files) {
  tokens <- tokenize_file(file_path)
  all_tokens <- c(all_tokens, tokens)
}

# write tokenized words to the output file
writeLines(paste(all_tokens, collapse = " "), output_file_path)

cat(paste("Tokenized words written to", output_file_path, "\n"))
