# Use an official JupyterLab base image
FROM jupyter/base-notebook:latest

# Add juxl extension (learning analytics)
RUN jupyter labextension install \
    @juxl/juxl-extension@latest-compatible-version \
    @juxl/logging@latest-compatible-version

# Copy juxl settings for the extension
COPY --chown=1000 juxl.jupyterlab-settings /srv/conda/envs/notebook/share/jupyter/lab/settings/overrides.json

# Add jupyterlab feedback extension (llm)
ADD jupyterlab_feedback-0.6.2-py3-none-any.whl .
RUN pip install jupyterlab_feedback-0.6.2-py3-none-any.whl
