
library(ggplot2)

# Create data frame with values per year
data <- data.frame(
  Attribute = c("Human Interest", "Responsibility", "Morality", "Economic", "Conflict"),
  Sunday_Times = c(95, 778, 248, 737, 39),
  Mail_and_Guardian = c(100, 564, 84, 261, 6)
)


library(reshape2)
data_long <- melt(data, id.vars = "Attribute")


ggplot(data_long, aes(x = Attribute, y = value, fill = variable)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.5) + # Adjust width of bars

#adjust heading as needed

  labs(title = "Comparison of Attributes 2010- Sunday Times vs. Mail and Guardian ",
       x = "Attribute",
       y = "Count") +
  scale_fill_manual(values = c("Sunday_Times" = "black", "Mail_and_Guardian" = "grey50"), # Adjust fill colors
                    labels = c("Sunday Times", "Mail and Guardian")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 0, hjust = 1, vjust = 0.5), # Horizontal text below
        axis.text.y = element_text(size = 10), # Adjust font size
        legend.position = "bottom") # Move legend to bottom
