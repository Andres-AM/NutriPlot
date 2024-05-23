

# Load necessary libraries
library(tidyverse)  # Collection of data manipulation and visualization packages
library(lubridate)  # Package for working with date and time objects
library(modelr)     # Tools for modeling and visualization
library(splines)    # Package for spline functions and interpolation
library(knitr)      # Package for creating dynamic reports
library(ggrepel)    # Package for geom_text_repel() function
library(plotly)
library(crosstalk)
theme_set(theme_bw())  # Set a black-and-white theme for plots

options(digits=4)                 # Set the number of digits to display in numeric outputs
options(dplyr.summarise.inform=F) # Suppress dplyr summarise() messages

rm(list = ls())   # Clear the environment to start with a clean slate
