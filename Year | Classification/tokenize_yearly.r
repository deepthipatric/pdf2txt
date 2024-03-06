#tokenizes each word in the combined text file
if (!requireNamespace("tokenizers", quietly = TRUE)) {
  install.packages("tokenizers")
}
library(tokenizers)

input_file <- 'C:/Users/wolves/Desktop/Years data/Classification _ years/M&G/2015/1_2015.txt'
output_file_path <- 'C:/Users/wolves/Desktop/Years data/Classification _ years/M&G/2015/token2013mg.txt'

tokenize_file <- function(file_path) {
  text <- tolower(readLines(file_path, warn = FALSE))
  tokens <- unlist(tokenize_words(text))
  return(tokens)
}

tokens <- tokenize_file(input_file)

writeLines(paste(tokens, collapse = " "), output_file_path)

cat(paste("Tokenized words written to", output_file_path, "\n"))
