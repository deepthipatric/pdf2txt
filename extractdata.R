# packages
install.packages(c("pdftools", "magick", "tesseract"))
library(pdftools)
library(magick)
library(tesseract)

# inout pdf folder
input_folder_path <- "C:/Users/Deepthi Patric/Desktop/brian/pdfs/"

#  output image folder
output_image_folder_path <- "C:/Users/Deepthi Patric/Desktop/brian/output_images/"

output_text_folder_path <- "C:/Users/Deepthi Patric/Desktop/brian/output_texts/"

# force output folders if they don't exist
if (!dir.exists(output_image_folder_path)) {
  dir.create(output_image_folder_path)
}

if (!dir.exists(output_text_folder_path)) {
  dir.create(output_text_folder_path)
}

# convert pdf to images for all pages, enhance , and save output images
convert_pdf_to_images <- function(pdf_path, output_folder) {
  # Get the total number of pages in the PDF
  num_pages <- pdf_info(pdf_path)$pages
  
  #  a list to store output image paths
  output_image_paths <- character(num_pages)
  
  # loop to go through each page and convert to an image
  for (page in 1:num_pages) {
    # Read the current page of the PDF and convert it to an image
    pdf_image <- image_read_pdf(pdf_path, pages = page)
    
    # improve image quality
    pdf_image <- image_modulate(pdf_image, brightness = 1.5, saturation = 1.0)
    
    # extract the file name (excluding extension) from the input pdf file(s)
    file_name <- tools::file_path_sans_ext(basename(pdf_path))
    
    # output image file path in png extension & page number
    output_image_path <- file.path(output_folder, paste0(file_name, "_page", page, ".png"))
    
    # output image to a path
    image_write(pdf_image, path = output_image_path)
    
    #  output image path in the list
    output_image_paths[page] <- output_image_path
  }
  
  return(output_image_paths)
}

# perform OCR on a single image
perform_ocr <- function(input_image_path, output_text_folder) {
  text <- ocr(image_read(input_image_path), engine = tesseract("eng"))
  
  # output text file path with the same base filename and page number
  output_text_file <- file.path(output_text_folder, paste0(tools::file_path_sans_ext(basename(input_image_path)), "_output.txt"))
  
  # Write the extracted text to a text file
  writeLines(text, con = output_text_file)
  
  cat("OCR completed for", input_image_path, "\n")
}

# get  list of PDF files in the input folder
pdf_files <- list.files(path = input_folder_path, pattern = "\\.pdf$", full.names = TRUE)

# loop through each pdf file, convert to images for all pages, and perform OCR for each page
for (pdf_file in pdf_files) {
  # Convert PDF to images and get the list of output image paths
  output_image_paths <- convert_pdf_to_images(pdf_file, output_image_folder_path)
  
  # iterate through each output image and perform OCR
  for (output_image_path in output_image_paths) {
    # Perform OCR on the current image and save the extracted text
    perform_ocr(output_image_path, output_text_folder_path)
  }
}
