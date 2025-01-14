FROM jupyter/base-notebook:latest

# Add juxl extension (learning analytics)
RUN jupyter labextension install \
    @juxl/juxl-extension@^3.1.1 \
    @juxl/logging@^3.1.1 

COPY --chown=1000 juxl.jupyterlab-settings /srv/conda/envs/notebook/share/jupyter/lab/settings/overrides.json
RUN echo "c.NotebookApp.allow_origin = 'https://juxlauth-codingai.elearn.rwth-aachen.de'" >> /etc/jupyter/jupyter_notebook_config.py


# Add jupyterlab feedback extension (llm)
ADD jupyterlab_feedback-0.6.2-py3-none-any.whl .
RUN pip install jupyterlab_feedback-0.6.2-py3-none-any.whl
