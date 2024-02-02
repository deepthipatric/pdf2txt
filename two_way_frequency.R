# the folder path
output_folder <- "./output_folder"

# dreate data frames. selected themes
mail_and_guardian <- data.frame(
  Theme = c("Human Interest", "Attribute of Responsibility", "Morality", "Economic", "Conflict"),
  Mail_Count = c(54, 0, 48, 75, 4)
)

sunday_times <- data.frame(
  Theme = c("Human Interest", "Attribute of Responsibility", "Morality", "Economic", "Conflict"),
  Sunday_Count = c(98, 4, 172, 89, 15)
)

# calculate total counts
total_mail <- sum(mail_and_guardian$Mail_Count)
total_sunday <- sum(sunday_times$Sunday_Count)

# calculate percentages
mail_and_guardian$Mail_Percentage <- paste0(round((mail_and_guardian$Mail_Count / total_mail) * 100, 2), "%")
sunday_times$Sunday_Percentage <- paste0(round((sunday_times$Sunday_Count / total_sunday) * 100, 2), "%")

#file paths for output
mail_output_file <- paste0(output_folder, "mail_and_guardian_output.tsv")
sunday_output_file <- paste0(output_folder, "sunday_times_output.tsv")

# Write Mail and Guardian output to file
cat("Theme\tCount\tPercentage\tData\n", file = mail_output_file)
cat(paste(mail_and_guardian$Theme, "\t", mail_and_guardian$Mail_Count, "\t", mail_and_guardian$Mail_Percentage, "\tMail and Guardian\n", sep = ""), file = mail_output_file)

# Write Sunday Times output to file
cat("Theme\tCount\tPercentage\tData\n", file = sunday_output_file)
cat(paste(sunday_times$Theme, "\t", sunday_times$Sunday_Count, "\t", sunday_times$Sunday_Percentage, "\tSunday Times\n", sep = ""), file = sunday_output_file)

# confirmation message
cat("Output files have been saved to the specified folder.\n")
