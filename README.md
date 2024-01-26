pdf2txt is a tool for analyzing scanned articles using R. It extracts words based on predefined themes for further analysis.
1. Extract Data (extract_data.r)
Overview

This script extracts data from scanned PDF files, particularly scanned newspaper articles. It utilizes Tesseract, pdftools, and magick libraries in R to perform the extraction.
Steps

    Converts the PDF to high-quality PNG files.
    Tesseract loops through each image in the folder to extract words to a TXT file with corresponding filenames.

2. Eliminate Words (eliminate.r)
Overview

This script eliminates a list of specified words (joining words in this context) and special characters from the TXT files generated in the extraction step.
Steps

    Removes predefined/specified words from the TXT files.
    Eliminates special characters.

3. Tokenize (tokenize.r)
Overview

This script reads through each file generated after eliminating words and tokenizes each word into a single TXT file.
Steps

    Reads through each file.
    Tokenizes words.
    Outputs tokenized words to a single TXT file.

4. Word Count (word_count.r)
Overview

This script, based on a list of words assigned to specific themes, processes the output from the tokenized TXT file. It compares the words with the predefined lists and provides a word count in tabular form according to the themes.
Example

    Theme 1:
        Flower: rose, hibiscus, dahlia, orchid
    Theme 2:
        Color: red, blue, grey

5. Two-way Frequency Calculation (two_way_frequency.r)

This script computes the two-way frequency of the dataset using the total count of each theme.
6. Comparison of Themes (comparison_of_themes.r)

This script compares each theme against the other. Each theme is computed against the other.
Usage

Explain how to run each script and any necessary dependencies.

bash

Rscript extract_data.r
Rscript eliminate.r
Rscript tokenize.r
Rscript word_count.r

