# Install and load required packages
install.packages("tesseract")
install.packages("magick")
library(tesseract)
library(magick)

# Function to perform OCR on a single image
perform_ocr <- function(input_image_path, output_text_path) {
  text <- ocr(image_read(input_image_path), engine = tesseract("eng"))
  writeLines(text, con = output_text_path)
}

# Path to the folder containing PNG images
input_folder <- "C:/Users/Deepthi Patric/Desktop/brian/output_images"

# Create an output folder for text files
output_folder <- "C:/Users/Deepthi Patric/Desktop/brian/output_texts"
dir.create(output_folder, showWarnings = FALSE)

# Get a list of PNG files in the input folder
png_files <- list.files(input_folder, pattern = "\\.png$", full.names = TRUE)

# Iterate over each PNG file and perform OCR
for (png_file in png_files) {
  # Generate the output text file path with the same base filename
  output_text_file <- file.path(output_folder, paste0(tools::file_path_sans_ext(basename(png_file)), "_output.txt"))
  
  # Perform OCR and save the extracted text to a text file
  perform_ocr(png_file, output_text_file)
  
  cat("OCR completed for", png_file, "\n")
}
