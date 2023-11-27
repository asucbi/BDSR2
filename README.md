# BDSR2

Repository for Behavioral Data Science in R II course

## Directory Structure

- `data/`: Folder for all data files
- `docs/`: Folder for github.io site (to be set up)
- `proc/`: Folder for preprocessing files related to setup that are not part of the labs (e.g. to create or preprocess data files)
- `imgs/`: Folder to store all images for lectures/labs/homeworks
- `lectures/`, `labs/`, `hw-projects`, `final-project`: Store all `.qmd` files in the corresponding folder (top-level, no subdirectories within these needed). Data and images can then be accessed easily and consistently with relative paths like `../data/` and `../imgs/`. Each directory contains a `_quarto.yml` file for consistent formatting and setting output directory to `docs/`.

## Tech notes

We will use Quarto and `.qmd` files throughout, mostly due to the much better presentation-building connections with revealjs. We can create a template starter document for lectures, labs, and homeworks. See templates for formatting examples and themes (we can discuss themes too).

## Requirements

- Quarto v1.3+