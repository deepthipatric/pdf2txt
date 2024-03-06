#combines text files per year in the folder
setwd("C:/Users/wolves/Desktop/Years data/Classification _ years/M&G/2013/")
file_list <- list.files(pattern = "\\.txt$")  
combined_file <- file("combined2013mg.txt", "w")
for (file in file_list) {
  content <- readLines(file)
  writeLines(content, combined_file)
}
close(combined_file)
