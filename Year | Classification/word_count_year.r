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
# Define themes and corresponding words
themes <- list(
  'Human Interest' = c('sympathy', 'motivation', 'problems', 'concerns', 'achievements', 'curiosity', 'feelings', 'compassion', 'result', 'consequence', 'upshot', 'outcome', 'out-turn', 'sequel', 'reaction', 'repercussions', 'reverberations', 'ramifications', 'endresult', 'termination', 'culmination', 'denouement', 'corollary', 'concomitant', 'aftermath', 'footprint', 'product', 'by-product', 'sequelae', 'pay-off', 'issue', 'success', 'empathy', 'commiseration', 'pity', 'tenderness', 'condolence', 'fellow feeling', 'rapport', 'affinity', 'Incentive', 'inspiration', 'drive', 'impetus', 'encouragement', 'stimulus', 'inducement', 'reason', 'purpose', 'cause', 'issues', 'difficulties', 'challenges', 'obstacles', 'hurdles', 'predicaments', 'dilemmas', 'setbacks', 'adversities', 'Worries', 'anxieties', 'cares', 'preoccupations', 'interests', 'attentions', 'considerations', 'regards', 'attentiveness', 'solicitousness', 'accomplishments', 'successes', 'triumphs', 'attainments', 'victories', 'feats', 'performances', 'realizations', 'fulfillments', 'completions', 'inquisitiveness', 'interest', 'inquiring', 'investigation', 'nosiness', 'questioning', 'wonder', 'fascination', 'eagerness', 'scrutiny', 'emotions', 'sentiments', 'sensations', 'reactions', 'moods', 'passions', 'attitudes', 'responses', 'sensitivities', 'affections', 'outturn', 'end result', 'emotional appeal', 'passionate appeal', 'dramatic appeal', 'psychological appeal', 'communication appeal', 'effusive attraction', 'emotional approach', 'emotional attraction', 'emotional chemistry', 'emotional charm', 'emotional blackmail', 'emotional abuse', 'emotionality', 'Hardship tale', 'hard-luck story', 'sob story', 'sad story', 'sorry tale', 'tale of woe', 'maudlin plea', 'Heartbreaker', 'pathos', 'tearjerker', 'Maudlin plea', 'sentimentalism', 'Pathos', 'heartbreaker', 'schmaltz', 'Schmaltz', 'Sentimentalism', 'Tale of woe', 'hardship tale'),
  
  'Attribute of Responsibility' = c('limitation of liability', 'allocating responsibilities', 'attributing liability', 'attribution of liability', 'chalk up', 'establish liability', 'held accountable', 'identify that responsible', 'imposition of liability', 'place responsibility', 'assign responsibility', 'attributing responsibility', 'given responsibility', 'place the responsibility', 'allocate responsibilities', 'allocate responsibility', 'allocation of liability', 'assign responsibilities', 'attribution of responsibility', 'impose vicarious liability', 'assigning liability', 'assigning responsibility', 'attach liability', 'put the blame', 'allocation of responsibility', 'assignment', 'liability', 'responsibility', 'responsible', 'channeling', 'stewardship', 'shared', 'collective', 'combining', 'joint', 'synergetic', 'synergic', 'synergistic', 'common', 'communal', 'mutual', 'cooperative', 'reciprocal', 'public', 'combined', 'collaborative', 'pooled', 'allocation', 'distribution', 'dividing', 'partaking', 'participating', 'partition', 'accord', 'administer', 'allot', 'apportion', 'assign', 'bestow', 'deal', 'dispense', 'divvy', 'partake', 'prorate', 'quota', 'development', 'advancement', 'evolution', 'expansion', 'improvement', 'increase', 'progress', 'growth', 'happening', 'incident', 'advance', 'rise', 'gain', 'amelioration', 'outcome', 'arise', 'befall', 'breed', 'chance', 'commence', 'originate', 'transpire', 'circumstance', 'conclusion', 'denouement', 'event', 'eventuality', 'materialization', 'occurrence', 'phenomenon', 'upshot', 'adept', 'effective', 'productive', 'capable', 'competent', 'economical', 'powerful', 'proficient', 'efficacious', 'effectual', 'competence', 'adeptness', 'capability', 'economy', 'effectiveness', 'power', 'productivity', 'proficiency', 'efficacy', 'productiveness', 'ability', 'effectualness', 'conservation', 'preservation', 'sustainability', 'environmentalism', 'ecological', 'biodiversity', 'habitat', 'restoration', 'regeneration', 'reclamation', 'reforestation', 'afforestation', 'ecosystem', 'biome', 'biosphere', 'naturalism', 'greening', 'landscaping', 'renewal', 'revitalization', 'remediation', 'rejuvenation', 'resuscitation', 'reinvigoration', 'replenishment', 'reconditioning', 'pressing', 'crucial', 'imperative', 'vital', 'urgent', 'compelling', 'acute', 'exigent', 'critical', 'rushed', 'immediate', 'current', 'present-day', 'contemporary', 'now', 'instant', 'timely', 'prompt', 'instantaneous', 'activism', 'advocacy', 'engagement', 'participation', 'mobilization', 'involvement', 'empowerment', 'volunteerism', 'service', 'outreach', 'eco-distress', 'climate-anxiety', 'eco-trauma', 'eco-angst', 'climate change distress', 'ecological grief', 'ecophobia', 'emergency', 'climate change', 'global warming', 'greenhouse', 'eco-responsibility', 'environmental sustainability', 'environmental', 'economic', 'social', 'resilient', 'green', 'eco-friendly', 'living', 'practices', 'management', 'governance', 'innovation', 'infrastructure', 'energy', 'agriculture', 'forestry', 'fisheries', 'tourism', 'waste management', 'water management', 'urban planning', 'transportation', 'manufacturing', 'construction', 'mining', 'supply', 'adaptation', 'mitigation', 'resilience', 'justice', 'equity', 'action', 'awareness', 'education', 'literacy', 'leadership', 'citizenship', 'solidarity', 'collaboration', 'transformation', 'transition', 'revolution'),
  
  'Morality' = c('tragedy', 'commons', 'exploitation', 'overexploitation', 'resource depletion', 'resource degradation', 'resource mismanagement', 'resource misuse', 'resource abuse', 'resource overuse', 'resource overexploitation', 'resource misappropriation', 'rights', 'entitlements', 'privileges', 'prerogatives', 'claims', 'liberties', 'freedoms', 'immunities', 'protections', 'concessions', 'ethics', 'morality', 'moral principles', 'moral values', 'moral standards', 'moral conduct', 'moral behavior', 'moral responsibility', 'moral duty', 'moral obligation', 'moral integrity', 'equity', 'fairness', 'justice', 'impartiality', 'equality', 'balance', 'parity', 'proportion', 'proportionate', 'proportionality', 'equal treatment', 'spirit', 'soul', 'essence', 'heart', 'core', 'life force', 'vitality', 'energy', 'animation', 'inspiration', 'motivation', 'humanitarian', 'compassionate', 'benevolent', 'altruistic', 'philanthropic', 'charitable', 'kind-hearted', 'generous', 'caring', 'empathetic', 'sympathetic', 'right', 'correct', 'proper', 'just', 'lawful', 'legitimate', 'authorized', 'permitted', 'sanctioned', 'endorsed', 'approved', 'wrong', 'incorrect', 'improper', 'unjust', 'unlawful', 'unauthorized', 'unpermitted', 'unsanctioned', 'unendorsed', 'unapproved', 'inappropriate', 'health', 'well-being', 'wellness', 'fitness', 'robustness', 'soundness', 'wholeness', 'resilience', 'strength', 'vigor', 'happiness', 'contentment', 'satisfaction', 'fulfillment', 'prosperity', 'success', 'flourishing', 'thriving', 'care', 'concern', 'attention', 'protection', 'support', 'nurturing', 'tending', 'looking after', 'guardianship', 'custody', 'maintenance', 'deprived community', 'disadvantaged community', 'marginalized community', 'underprivileged community', 'impoverished community', 'low-income community', 'struggling community', 'vulnerable community', 'at-risk community', 'underserved community', 'neglected community', 'inequalities', 'disparities', 'discrepancies', 'differences', 'gaps', 'imbalances', 'asymmetries', 'unevenness', 'uneven distribution', 'unequal treatment', 'holistic approach', 'comprehensive approach', 'integrated approach', 'whole-system approach', 'systemic approach', 'all-encompassing approach', 'inclusive approach', 'multi-dimensional', 'multi-faceted', 'interconnected approach', 'interdisciplinary approach', 'god', 'deity', 'divine being', 'creator', 'supreme being', 'ultimate reality', 'ultimate truth', 'ultimate power', 'ultimate consciousness', 'ultimate intelligence', 'ultimate force', 'evangelical', 'evangelistic', 'religious organizations', 'religious institutions', 'religious bodies', 'religious associations', 'religious societies', 'religious fellowships', 'religious communities', 'religious congregations', 'religious groups', 'religious movements', 'religious networks', 'religious traditions', 'religious practices', 'religious customs', 'religious rituals', 'religious ceremonies', 'religious observances', 'religious rites', 'religious symbols', 'religious artifacts', 'religious texts', 'religious teachings', 'faith', 'belief', 'trust', 'confidence', 'conviction', 'assurance', 'certainty', 'reliance', 'commitment', 'devotion', 'allegiance', 'believers', 'followers', 'adherents', 'disciples', 'supporters', 'devotees', 'members', 'participants', 'attendees', 'subscribers', 'cultural dimensions', 'cultural aspects', 'cultural elements', 'cultural features', 'cultural components', 'cultural characteristics', 'cultural traits', 'cultural practices', 'cultural customs', 'cultural traditions', 'cultural values'),
  
  'Economic' = c(  'promote economic growth', 'prosperousness', 'plenty', 'riches', 'richdom', 'growth', 'thriving', 'wealthiness', 'plenteousness', 'upturn', 'good fortune',
                   'efficient use of natural resources', 'resource efficiency', 'resource optimization', 'resource utilization', 'resource conservation', 'resource management',
                   'impact of the production cycle', 'production cycle influence', 'production cycle effect', 'production cycle impact', 'production cycle consequence',
                   'production cycle result', 'local economies ability to sustain themselves', 'local economic self-sustainability', 'local economic resilience',
                   'local economic self-reliance', 'local economic independence', 'local economic viability', 'increase in the productivity of local economic growth',
                   'local economic growth enhancement', 'local economic productivity boost', 'local economic growth improvement', 'local economic productivity increase',
                   'local economic growth augmentation', 'development', 'economic development', 'economic growth', 'economic expansion', 'economic upswing', 'productivity',
                   'efficiency', 'effectiveness', 'output', 'performance', 'efficiency', 'capacity', 'financial institution', 'moneylender', 'credit union', 'savings bank',
                   'investment bank', 'commerce', 'exchange', 'business', 'transaction', 'barter', 'means', 'funds', 'provisions', 'reserves', 'wealth', 'arbitration',
                   'asset', 'autarky', 'automation', 'balanced budget', 'gdp', 'gross domestic product', 'inflation', 'recession', 'fiscal policy', 'monetary policy',
                   'trade deficit', 'tariff', 'subsidy', 'investment', 'financial markets', 'business cycle', 'marginal revenue', 'marginal utility', 'means test',
                   'medium of exchange', 'mercantilism', 'appreciate', 'bankrupt', 'bankruptcy', 'budget', 'capital', 'cash', 'competition', 'consumer', 'consumer goods',
                   'cost', 'crash', 'credit', 'currency', 'debt', 'deficit', 'deposit', 'depression', 'finance', 'fiscal', 'fund', 'global', 'interest', 'invest', 'investment',
                   'loan', 'loss', 'joblessness', 'nonemployment', 'removal', 'dismissal', 'firing', 'severance', 'boot', 'suspension', 'fiscal policy', 'economic policy',
                   'financial policy', 'budgetary policy', 'revenue policy', 'expenditure policy', 'monetary management', 'monetary control', 'monetary regulation',
                   'monetary strategy', 'monetary framework', 'trade gap', 'trade imbalance', 'trade shortfall', 'duty', 'tax', 'levy', 'impost', 'charge', 'subsidy',
                   'grant', 'aid', 'assistance', 'support', 'subsidization', 'capital investment', 'financial investment', 'business investment', 'venture capital',
                   'equity investment', 'capital markets', 'money markets', 'stock markets', 'bond markets', 'commodity markets', 'economic cycle', 'trade cycle',
                   'boom-bust cycle', 'expansion-contraction cycle', 'upswing-downswing cycle', 'marginal income', 'marginal profit', 'marginal gain', 'marginal return',
                   'marginal yield', 'marginal satisfaction', 'marginal pleasure', 'marginal benefit', 'marginal value', 'marginal enjoyment', 'means test', 'eligibility test',
                   'qualification test', 'assessment test', 'screening test', 'suitability test', 'currency', 'money', 'tender', 'legal tender', 'circulating medium',
                   'mercantile policy', 'mercantile system', 'mercantile economy', 'mercantile trade', 'mercantile theory', 'admire', 'respect', 'value', 'esteem', 'cherish',
                   'insolvent', 'broke', 'penniless', 'destitute', 'impoverished', 'insolvency', 'bankruptcy proceedings', 'bankruptcy court', 'bankruptcy trustee',
                   'bankruptcy petition', 'financial plan', 'budgetary plan', 'fiscal plan', 'expenditure plan', 'revenue plan', 'financial resources', 'financial assets',
                   'financial capital', 'economic capital', 'economic resources', 'cash', 'competition', 'rivalry', 'contest', 'struggle', 'battle', 'fight', 'consumer',
                   'customer', 'client', 'patron', 'purchaser', 'buyer', 'consumer goods', 'consumer products', 'consumer items', 'consumer merchandise', 'consumer durables',
                   'consumer non-durables', 'cost', 'expense', 'outlay', 'expenditure', 'investment', 'price', 'crash', 'collapse', 'failure', 'breakdown', 'meltdown',
                   'implosion', 'credit', 'trust', 'confidence', 'faith', 'belief', 'reliance', 'currency', 'money', 'tender', 'legal tender', 'circulating medium', 'debt',
                   'obligation', 'liability', 'indebtedness', 'burden', 'responsibility', 'deficit', 'shortfall', 'lack', 'insufficiency', 'scarcity', 'inadequacy', 'deposit',
                   'deposit account', 'savings account', 'checking account', 'current account', 'demand deposit', 'depression', 'economic depression', 'economic downturn',
                   'economic recession', 'economic slump', 'economic slowdown', 'economy', 'economic system', 'economic structure', 'economic organization', 'economic arrangement',
                   'economic framework', 'finance', 'financial management', 'financial planning', 'financial strategy', 'financial control', 'financial analysis', 'fiscal',
                   'financial', 'economic', 'budgetary', 'revenue', 'expenditure', 'fund', 'financial fund', 'investment fund', 'mutual fund', 'pension fund', 'endowment fund',
                   'global', 'worldwide', 'international', 'globalized', 'globalizing', 'globalization', 'interest', 'interest rate', 'rate of interest', 'rate of return',
                   'return on investment', 'return on capital', 'invest', 'invest money', 'invest capital', 'invest funds', 'invest resources', 'invest assets', 'investment',
                   'investment strategy', 'investment plan', 'investment portfolio', 'investment opportunity', 'investment vehicle', 'loan', 'loan agreement', 'loan contract',
                   'loan facility', 'loan arrangement', 'loan commitment', 'loss', 'loss of income', 'loss of revenue', 'loss of profit', 'loss of capital', 'loss of assets'),
  
  'Conflict' = c(
    'dispute', 'controversy', 'disputation', 'debate', 'disagreement', 'difference', 'contestation', 'dissension', 'dissention', 'antagonism', 'hostility', 
    'falling-out', 'clash', 'shouting match', 'exchange', 'war fracas', 'opposite', 'climate and environmental crises',
    'quarrel', 'bickering', 'brawl',
    'squabble', 'bickering', 'brawl',
    'difference of opinion', 'dissension', 'difference of opinion',
    'difference of opinion', 'dissension', 'difference of opinion',
    'disagreement', 'dissension', 'disagreement',
    'antagonism', 'antagonism', 'antagonism',
    'hostility', 'hostility', 'hostility',
    'falling-out', 'falling-out', 'falling-out',
    'disputation', 'dispute', 'controversy', 'disagreement',
    'clash', 'conflict', 'clash',
    'shouting match', 'conflict', 'shouting match',
    'exchange', 'conflict', 'exchange',
    'war fracas', 'conflict', 'war fracas',
    'opposite', 'conflict', 'opposite',
    'climate and environmental crises', 'conflict', 'climate and environmental crises'
  )
)

file_path <- "C:/Users/wolves/Desktop/Years data/Classification _ years/M&G/2010/token2010mg.txt"

text <- tolower(readLines(file_path, warn = FALSE))

# Call the function with the text and themes
theme_word_counts <- count_occurrences(text, themes)

output_file_path <- "C:/Users/wolves/Desktop/Years data/Classification _ years/M&G/2010/counttest12010mg.tsv"

for (theme_name in names(theme_word_counts)) {
  theme_data <- theme_word_counts[[theme_name]]
  write.table(theme_data, file = output_file_path, append = TRUE, sep = "\t", col.names = !file.exists(output_file_path), row.names = FALSE)
}

cat("Results saved to", output_file_path, "\n")
