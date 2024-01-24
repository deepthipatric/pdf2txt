
  # Read the text file
  file_path <- 'C:/Users/Deepthi Patric/Desktop/brian/token_words/token.txt'
text <- tolower(readLines(file_path, warn = FALSE))

# Define themes and corresponding words
themes <- list(
  'Human Interest' = c('sympathy', 'motivation', 'problems', 'concerns', 'achievements', 'curiosity', 'feelings', 'compassion', 'result', 'consequence', 'upshot', 'outcome', 'out-turn', 'sequel', 'reaction', 'repercussions', 'reverberations', 'ramifications', 'endresult', 'termination', 'culmination', 'denouement', 'corollary', 'concomitant', 'aftermath', 'footprint', 'product', 'by-product', 'sequelae', 'pay-off', 'issue', 'success'),
  'Attribute of Responsibility' = c('limitation of liability', 'allocating responsibilities', 'attributing liability', 'attribution of liability', 'chalk up', 'establish liability', 'held accountable', 'identify that responsible', 'imposition of liability', 'place responsibility', 'assign responsibility', 'attributing responsibility', 'given responsibility', 'place the responsibility', 'allocate responsibilities', 'allocate responsibility', 'allocation of liability', 'assign responsibilities', 'allocation of responsibility', 'assignment of liability', 'assignment of responsibility', 'be responsible', 'channelling of liability'),
  'Morality' = c('the tragedy of the commons', 'rights', 'ethics', 'equity', 'justice', 'spirit', 'humanitarian', 'right', 'wrong', 'health', 'well being', 'care', 'deprived community', 'inequalities', 'holistic approach', 'god', 'evangelical', 'religious organisations', 'religious traditions', 'faith', 'believers', 'cultural dimensions'),
  'Economic' = c('promote economic growth', 'efficient use of natural resources', 'impact of the production cycle', 'local economies’ ability to sustain themselves', 'increase in productivity of local economic growth', 'development', 'productivity', 'bank', 'trading', 'resources'),
  'Conflict' = c('dispute', 'quarrel', 'squabble', 'disagreement', 'difference of opinion', 'dissension', 'antagonism', 'violence they experience', 'blood', 'hostility', 'falling-out', 'disputation', 'contention', 'clash', 'shouting match', 'exchange war', 'fracas', 'opposite', 'climate and environmental crises')
)

# Function to count occurrences of words for each theme
count_occurrences <- function(text, theme_words) {
  word_counts <- list()
  for (theme_name in names(theme_words)) {
    theme_words_list <- theme_words[[theme_name]]
    theme_counts <- sapply(theme_words_list, function(word) sum(gregexpr(paste0("\\b", word, "\\b"), text, ignore.case = TRUE)[[1]] > 0))
    theme_data <- data.frame(Word = theme_words_list, Count = theme_counts, Theme = theme_name)
    word_counts[[theme_name]] <- theme_data
  }
  return(word_counts)
}

# Count occurrences
theme_word_counts <- count_occurrences(text, themes)

# Save the results in a tab-separated values (TSV) file
output_file_path <- 'C:/Users/Deepthi Patric/Desktop/brian/token_words/file.tsv'
for (theme_name in names(theme_word_counts)) {
  theme_data <- theme_word_counts[[theme_name]]
  write.table(theme_data, file = output_file_path, append = TRUE, sep = "\t", col.names = !file.exists(output_file_path), row.names = FALSE)
}

cat("Results saved to", output_file_path, "\n")
