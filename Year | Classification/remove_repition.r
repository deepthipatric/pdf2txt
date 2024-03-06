# Original list of words
human_interest_words <- c('dispute', 'controversy', 'disputation', 'debate', 'disagreement', 'difference', 'contestation', 'dissension', 'dissention', 'antagonism', 'hostility', 'falling-out', 'clash', 'shouting match', 'exchange', 'war fracas', 'opposite', 'climate and environmental crises','quarrel', 'bickering', 'brawl','squabble', 'bickering', 'brawl','difference of opinion', 'dissension', 'difference of opinion','difference of opinion', 'dissension', 'difference of opinion','disagreement', 'dissension', 'disagreement','antagonism', 'antagonism', 'antagonism','hostility', 'hostility', 'hostility','falling-out', 'falling-out', 'falling-out','disputation', 'dispute', 'controversy', 'disagreement','clash', 'conflict', 'clash', 'conflict','exchange', 'conflict', 'exchange','war fracas', 'conflict', 'war fracas','opposite', 'conflict', 'opposite','climate and environmental crises', 'conflict', 'climate and environmental crises')

# Remove repetitions
unique_human_interest_words <- unique(human_interest_words)

cat(paste("'", unique_human_interest_words, "'", collapse = ", "))
