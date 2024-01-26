# Themes with words
themes <- list(
  'Human Interest' = c('sympathy', 'motivation', 'problems', 'concerns', 'achievements', 'curiosity', 'feelings', 'compassion', 'result', 'consequence', 'upshot', 'outcome', 'out-turn', 'sequel', 'reaction', 'repercussions', 'reverberations', 'ramifications', 'endresult', 'termination', 'culmination', 'denouement', 'corollary', 'concomitant', 'aftermath', 'footprint', 'product', 'by-product', 'sequelae', 'pay-off', 'issue', 'success'),
  'Attribute of Responsibility' = c('limitation of liability', 'allocating responsibilities', 'attributing liability', 'attribution of liability', 'chalk up', 'establish liability', 'held accountable', 'identify that responsible', 'imposition of liability', 'place responsibility', 'assign responsibility', 'attributing responsibility', 'given responsibility', 'place the responsibility', 'allocate responsibilities', 'allocate responsibility', 'allocation of liability', 'assign responsibilities', 'assignment of liability', 'assignment of responsibility', 'be responsible', 'channelling of liability'),
  'Morality' = c('the tragedy of the commons', 'rights', 'ethics', 'equity', 'justice', 'spirit', 'humanitarian', 'right', 'wrong', 'health', 'well being', 'care', 'deprived community', 'inequalities', 'holistic approach', 'god', 'evangelical', 'religious organisations', 'religious traditions', 'faith', 'believers', 'cultural dimensions'),
  'Economic' = c('promote economic growth', 'efficient use of natural resources', 'impact of the production cycle', 'local economies’ ability to sustain themselves', 'increase in productivity of local economic growth', 'development', 'productivity', 'bank', 'trading', 'resources'),
  'Conflict' = c('dispute', 'quarrel', 'squabble', 'disagreement', 'difference of opinion', 'dissension', 'antagonism', 'violence they experience', 'blood', 'hostility', 'falling-out', 'disputation', 'contention', 'clash', 'shouting match', 'exchange war', 'fracas', 'opposite', 'climate and environmental crises')
)

# Concatenate all words into a single vector
all_words <- unlist(themes)

# Extract unique words
unique_words <- unique(all_words)

# Print unique words
print(unique_words)
