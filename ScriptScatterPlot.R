# Load necessary libraries
library(tidyverse)  # Collection of data manipulation and visualization packages
library(lubridate)  # Package for working with date and time objects
library(modelr)     # Tools for modeling and visualization
library(splines)    # Package for spline functions and interpolation
library(knitr)      # Package for creating dynamic reports
library(ggrepel)    # Package for geom_text_repel() function
theme_set(theme_bw())  # Set a black-and-white theme for plots

options(digits=4)                 # Set the number of digits to display in numeric outputs
options(dplyr.summarise.inform=F) # Suppress dplyr summarise() messages

rm(list = ls())   # Clear the environment to start with a clean slate
cat("\014")       # Clear the console output

# Read data from a CSV file named "prot.csv" into a data frame called 'df'
df <- read_csv2("prot.csv", show_col_types = FALSE)

## La question est de savoir quel produit donne le plus de prot pour une quantité fixe de calories
# (The question is to know which product provides the most protein for a fixed amount of calories.)

# Create a scatter plot using ggplot2
scatter_plot1 <- df %>% 
  ggplot() +
  geom_point(aes(x = kcal, y = perc_prot, color = perc_prot)) +    # Add points to the plot with kcal on x-axis and perc_prot on y-axis
  geom_text_repel(aes(x = kcal, y = perc_prot, label = name), force = 6) +  # Add text labels using geom_text_repel
  scale_x_continuous(n.breaks = 10) +
  scale_y_continuous(n.breaks = 10) +
  scale_color_gradient(low = 'red',high = "green") +
  theme(legend.position = "none") +    
  labs(y = "protein[%] for 100 kcal", x = "kcal", title = "For 100g")       # Add labels to the axes and title to the plot

scatter_plot2 <- df %>% 
  ggplot() +
  geom_point(aes(x = perc_prot, y = kcal, color = kcal)) +    # Add points to the plot with kcal on x-axis and perc_prot on y-axis
  geom_text_repel(aes(x = perc_prot, y = kcal, label = name), force = 6) +  # Add text labels using geom_text_repel
  scale_x_continuous(n.breaks = 10) +
  scale_y_continuous(n.breaks = 10) +
  scale_color_gradient(low = 'green',high = "red") +
  theme(legend.position = "none") +    
  labs(x = "protein[%] for 100 kcal", y = "kcal", title = "For 100g")       # Add labels to the axes and title to the plot

scatter_plot1 <- df %>%
  ggplot() +
  geom_point(aes(y = perc_prot, x = reorder(name, perc_prot, FUN = median) )) +
  geom_text_repel(aes(x = name, y = perc_prot, label = name), force = 6)  + # Add text labels using geom_text_repel
# Add points to the plot with kcal on x-axis and perc_prot on y-axis
  scale_color_gradient(low = 'red',high = "green") +
  scale_y_continuous(n.breaks = 10) +
  theme(legend.position = "none") +
  labs(y = "protein[%] for 100 kcal", x = "name", title = "For 100g")       # Add labels to the axes and title to the plot



scatter_plot1
scatter_plot2  # Display the scatter plot

# Save the plot in the working directory as a PNG file
ggsave(filename = "scatter_plot1.png", plot = scatter_plot1, width = 10, height = 10, dpi = 600)
ggsave(filename = "scatter_plot2.png", plot = scatter_plot2, width = 10, height = 10, dpi = 600)

# Save the scatter plot as a PNG file with specified dimensions and resolution (width=10, height=10, dpi=600)

df %>% arrange(desc(perc_prot)) %>% kable()


### Interpretation : 
# Axis, 
# the more you go to the right, the more protein dense the food is 
# the more you go up, the more the more calories dense the food is 

# therefore : 
# bottom right are the food with the most protein per calorie, that are low in calorie for 100g
# top right are the food with the most protein per calorie, that are high in calorie for 100g
# bottom left are the food with the least protein per calorie, that are low in calorie for 100g
# top left are the food with the least protein per calorie, that are high in calorie for 100g


# Example dataset
food_data <- data.frame(
  Food_Type = c("Chicken", "Beef", "Fish", "Tofu", "Eggs"),
  Protein_Percentage = c(25, 20, 30, 15, 12)
)

# Load necessary packages
library(ggplot2)

# Order the dataset by Protein_Percentage
food_data <- food_data[order(food_data$Protein_Percentage), ]

# Create the line graph
ggplot(data = food_data, aes(x = Food_Type, y = Protein_Percentage)) +
  geom_point() +
  labs(title = "Protein Percentage in Different Types of Food",
       x = "Food Type",
       y = "Protein Percentage")
