# Distributed under the terms of the MIT Licence

FROM jupyter/base-notebook

# not basing it on scipy-notebook, as that increases the image size to 2GB from a few hundred MB

LABEL maintainer="Ben O'Steen <bosteen@gmail.com>"

USER root

# Get nltk through the package manager due to its wrappers and whatnot
# ffmpeg for matplotlib animations
# other tools included to round things out.
RUN apt-get update && \
    apt-get install -y --no-install-recommends  \
	python3-nltk  \
	unzip  \
	python-dev  \
	git  \
	nano  \
	ffmpeg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# To aid persistence and to simplify docker-compose steps which don't have access
# to $NB_USER env variable:
RUN rm -rf /home/$NB_USER/work && \
    mkdir /work && \
	fix-permissions /work && \
	ln -s /work /home/$NB_USER/work

USER $NB_USER

# install some viz and text tool libraries alongside the scipy python libraries
# Versions are aligned with those from the wragge/ozglam-workbench where possible
# but note that alignment with scipy-notebook is also preferred for these.
# base libraries drawn from https://github.com/jupyter/docker-stacks/blob/master/scipy-notebook/Dockerfile
# version requirements.
# NB Shapely (geometric toolkit, useful for GIS/map manipulations) is only at 1.5.13 on conda sadly
RUN conda install --quiet --yes \
	'conda-forge::blas=*=openblas' \
    'requests==2.18.4'  \
    'numpy==1.14.2'  \
    'plotly==2.5.1'  \
    'Pillow==5.1.0'  \
    'tinydb==3.8.1.post1'  \
    'robobrowser==0.5.3'  \
    'lxml==4.2.1'  \
	'shapely'  \
    'wordcloud==1.4.1'  \
    'textblob==0.15.1'  \
    'ipyleaflet==0.8.1'  \
    'chardet'  \
    'ipywidgets=7.2*' \
    'pandas=0.22*' \
    'numexpr=2.6*' \
    'matplotlib=2.1*' \
    'scipy=1.0*' \
    'seaborn=0.8*' \
    'scikit-learn=0.19*' \
    'scikit-image=0.13*' \
    'sympy=1.1*' \
    'cython=0.28*' \
    'patsy=0.5*' \
    'statsmodels=0.8*' \
    'cloudpickle=0.5*' \
    'dill=0.2*' \
    'numba=0.38*' \
    'bokeh=0.12*' \
    'sqlalchemy=1.2*' \
    'hdf5=1.10*' \
    'h5py=2.7*' \
    'vincent=0.4.*' \
    'beautifulsoup4=4.6.*' \
    'protobuf=3.*' \
    'xlrd'  && \
    conda remove --quiet --yes --force qt pyqt && \
    conda clean -tipsy &&  \
    # Activate ipywidgets and ipyleaflet extension in the environment that runs the notebook server
    jupyter nbextension enable --py widgetsnbextension --sys-prefix && \
	jupyter nbextension enable --py --sys-prefix ipyleaflet && \
    # Also activate ipywidgets extension for JupyterLab
    jupyter labextension install @jupyter-widgets/jupyterlab-manager@^0.35 && \
	jupyter labextension install jupyter-leaflet && \
    jupyter labextension install jupyterlab_bokeh@^0.5.0 && \
    npm cache clean --force && \
    rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Get data- or source-specific helper libraries
# Might have to fall back onto pip for some of these...
RUN pip install troveharvester

# Add RUN statements to install packages as the $NB_USER defined in the base images.

# Add a "USER root" statement followed by RUN statements to install system packages using apt-get,
# change file permissions, etc.

# If you do switch to root, always be sure to add a "USER $NB_USER" command at the end of the
# file to ensure the image runs as a unprivileged user by default.

USER $NB_UID
