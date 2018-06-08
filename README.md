# humanitiesworkbench

humanitiesworkbench is a community maintained Jupyter Docker Stack image aimed at providing a good working environment for most (digital) Humanities-type activities, explorations or visualisation notebooks.

Github: https://github.com/BL-Labs/humanitiesworkbench

(Grateful for any pull requests to fill coverage gaps for general Humanities-type explorations, work or visualisations.)

- NLTK (Natural Language ToolKit) and textblob
- ipyleaflet, plotly, shapely, wordcloud (viz tools to enhance what you get with scipy)
- Pillow (fork of PIL)
- numpy
- xlrd (Excel file opening/reading)
- robobrowser, requests (scraping, getting remote datasets)
- scipy base python libraries (matplotlib with inline notebook rendering, beautifulsoup, pandas, etc)

## Why this and not DHBox?

This is a container built to open, view and create notebooks that help people (notably Humanities researchers) work with their data without much fuss and without deviating too far from the existing jupyter docker stacks (https://github.com/jupyter/docker-stacks) and the feel and expectations based on the stacks there. 

DHBox is geared up to have everything you could possibly want, RStudio, Omeka, Notebooks, Wordpress, and so on and is a good choice for a longterm service if you are going to capitalise on those other services.