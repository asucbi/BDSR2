# BDSR2

Repository for Behavioral Data Science in R II course.

## Quarto Project Structure

This course is structured as a quarto project and all labs, lectures, and homeworks are created as `.qmd` files. The folders `lectures/`, `labs/`, `hw-projects/`, `final-project/` store all `.qmd` files in the corresponding folder and use a `_metadata.yml` file to control their proper formatting.

The project is configured so all `.qmd` run from the project's root directory. This means data and images are accessed with paths `/data` and `/imgs` respectively (no need for relative path `../` business). The exception are some files pointed to in the YAML, but this is configured and should now work.

### Supporting Folders

- `data/`: Folder for all data files
- `docs/`: Folder for github.io site (all outputs are configured to go here)
- `proc/`: Folder for preprocessing files related to setup that are not part of the labs (e.g. to create or preprocess data files)
- `imgs/`: Folder to store all images for lectures/labs/homeworks
- `quizzes/`: Store any `.qmd` files needed for quizzes. We may want to use subdirectories per unit here, not sure.

## Viewing pages

Hosted by github pages. E.g. https://asucbi.github.io/BDSR2/labs/lab-m01.html

## Tech notes and issues

- See template starter document for lectures, labs, and homeworks formatting examples and themes.
	+ Templates are unfinished---we can update them futher as we learn new quarto features.
- Rstudio render preview seems to be broken when using a non-default output directory.
- For some reason I had to put the revealjs YAML in the actual files and not in the `_metadata.yml`.
- There are some hidden files that are important (.nojekyll)
- We may want to discuss themes, etc.
- Image and revealjs files are duplicated, which is a bit inefficient (e.g. they end up in both `/imgs` and `/docs/imgs`). 

## Requirements

- Quarto v1.3+
- Chromium (installed as quarto tool): `quarto install chromium`
- Packages
	+ [`rosdata`](https://github.com/avehtari/ROS-Examples/tree/master)