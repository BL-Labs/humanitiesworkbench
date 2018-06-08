# Distributed under the terms of the MIT Licence

FROM jupyter/scipy-notebook

LABEL maintainer="Ben O'Steen <bosteen@gmail.com>"

USER root

# Get nltk through the package manager due to its wrappers and whatnot
RUN apt-get update && \
    apt-get install -y --no-install-recommends python3-nltk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_USER

# install some viz and text tool libraries
# Versions are aligned with those from the wragge/glamworkbench where possible
# but note that the scipy-notebook will install a number of these with its own 
# version requirements.
RUN conda install --quiet --yes \
    'requests==2.18.4'  \
    'numpy==1.14.2'  \
    'plotly==2.5.1'  \
    'Pillow==5.1.0'  \
    'tinydb==3.8.1.post1'  \
    'robobrowser==0.5.3'  \
    'lxml==4.2.1'  \
    'wordcloud==1.4.1'  \
    'textblob==0.15.1'  \
    'ipyleaflet==0.8.1'  \
    'chardet' && \
    conda clean -tipsy &&  \
    npm cache clean --force && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Add RUN statements to install packages as the $NB_USER defined in the base images.

# Add a "USER root" statement followed by RUN statements to install system packages using apt-get,
# change file permissions, etc.

# If you do switch to root, always be sure to add a "USER $NB_USER" command at the end of the
# file to ensure the image runs as a unprivileged user by default.

USER $NB_UID
