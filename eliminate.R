# Specify the input folder containing .txt files
input_folder <- "C:/Users/Deepthi Patric/Desktop/brian/cleaned_st"

# Create the output folder if it doesn't exist
output_folder <- "C:/Users/Deepthi Patric/Desktop/brian/output_eliminated"
if (!dir.exists(output_folder)) dir.create(output_folder)

# Define the words to eliminate
words_to_eliminate <- c("in addition", "not only...but also", 
                        "moreover", "furthermore", "as well as", "and", "so", "yet", "furthermore", 
                        "in addition", "also", "besides", "further", "same way", "and in like manner", 
                        "and in the same")

# Create a regular expression pattern for the words and special characters
pattern <- paste0("\\b(?:", paste(words_to_eliminate, collapse = "|"), ")\\b|[[:punct:]]")

# Get a list of all .txt files in the input folder
txt_files <- list.files(input_folder, pattern = "\\.txt$", full.names = TRUE)

# Loop through each file
for (file in txt_files) {
  # Read the text document
  text <- readLines(file, warn = FALSE)
  
  # Remove the specified words and special characters
  cleaned_text <- gsub(pattern, "", text, ignore.case = TRUE)
  
  # Extract the original file name without extension
  original_filename <- tools::file_path_sans_ext(basename(file))
  
  # Create the output file path
  output_file <- file.path(output_folder, paste0(original_filename, "_eliminated.txt"))
  
  # Write the cleaned text to the output file
  writeLines(cleaned_text, output_file)
}
