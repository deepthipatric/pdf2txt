
install.packages("pdftools")
install.packages("magick")
library(pdftools)
library(magick)

#  input PDF folder
input_folder_path <- "C:/Users/Deepthi Patric/Desktop/brian/pdfs/"

# output image folder
output_folder_path <- "C:/Users/Deepthi Patric/Desktop/brian/output_images/"

# output folder if it doesn't exist
if (!dir.exists(output_folder_path)) {
  dir.create(output_folder_path)
}

# list of PDF files in the input folder
pdf_files <- list.files(path = input_folder_path, pattern = "\\.pdf$", full.names = TRUE)

#  convert PDF to image and save output image
convert_pdf_to_image <- function(pdf_path, output_folder) {
  # Read the first page of the PDF and convert it to an image
  pdf_image <- image_read_pdf(pdf_path, pages = 1)
  
  # extract the file name from pdf inputs
  file_name <- tools::file_path_sans_ext(basename(pdf_path))
  
  # the output image file path with PNG extension
  output_image_path <- file.path(output_folder, paste0(file_name, ".png"))
  
  # image to the specified path
  image_write(pdf_image, path = output_image_path)
}

# Loop through each pdf file and convert to image
for (pdf_file in pdf_files) {
  convert_pdf_to_image(pdf_file, output_folder_path)
}
