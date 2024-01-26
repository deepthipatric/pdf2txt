# Install and load required packages
install.packages(c("pdftools", "magick", "tesseract"))
library(pdftools)
library(magick)
library(tesseract)

# Set the path to the input PDF folder
input_folder_path <- "C:/Users/Deepthi Patric/Desktop/brian/pdfs/"

# Set the path to the output image folder
output_image_folder_path <- "C:/Users/Deepthi Patric/Desktop/brian/output_images/"

# Set the path to the output text folder
output_text_folder_path <- "C:/Users/Deepthi Patric/Desktop/brian/output_texts/"

# Create the output folders if they don't exist
if (!dir.exists(output_image_folder_path)) {
  dir.create(output_image_folder_path)
}

if (!dir.exists(output_text_folder_path)) {
  dir.create(output_text_folder_path)
}

# Function to convert PDF to images for all pages, enhance quality, and save output images
convert_pdf_to_images <- function(pdf_path, output_folder) {
  # Get the total number of pages in the PDF
  num_pages <- pdf_info(pdf_path)$pages
  
  # Initialize a list to store output image paths
  output_image_paths <- character(num_pages)
  
  # Loop through each page and convert to an image
  for (page in 1:num_pages) {
    # Read the current page of the PDF and convert it to an image
    pdf_image <- image_read_pdf(pdf_path, pages = page)
    
    # Enhance image quality (adjust parameters as needed)
    pdf_image <- image_modulate(pdf_image, brightness = 1.5, saturation = 1.0)
    
    # Extract the file name (excluding extension) from the input PDF file
    file_name <- tools::file_path_sans_ext(basename(pdf_path))
    
    # Construct the output image file path with PNG extension and page number
    output_image_path <- file.path(output_folder, paste0(file_name, "_page", page, ".png"))
    
    # Write the enhanced image to the specified path
    image_write(pdf_image, path = output_image_path)
    
    # Store the output image path in the list
    output_image_paths[page] <- output_image_path
  }
  
  return(output_image_paths)
}

# Function to perform OCR on a single image
perform_ocr <- function(input_image_path, output_text_folder) {
  text <- ocr(image_read(input_image_path), engine = tesseract("eng"))
  
  # Generate the output text file path with the same base filename and page number
  output_text_file <- file.path(output_text_folder, paste0(tools::file_path_sans_ext(basename(input_image_path)), "_output.txt"))
  
  # Write the extracted text to a text file
  writeLines(text, con = output_text_file)
  
  cat("OCR completed for", input_image_path, "\n")
}

# Get a list of PDF files in the input folder
pdf_files <- list.files(path = input_folder_path, pattern = "\\.pdf$", full.names = TRUE)

# Loop through each PDF file, convert to images for all pages, and perform OCR for each page
for (pdf_file in pdf_files) {
  # Convert PDF to images and get the list of output image paths
  output_image_paths <- convert_pdf_to_images(pdf_file, output_image_folder_path)
  
  # Iterate through each output image and perform OCR
  for (output_image_path in output_image_paths) {
    # Perform OCR on the current image and save the extracted text
    perform_ocr(output_image_path, output_text_folder_path)
  }
}
