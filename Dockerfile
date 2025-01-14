# Specify parent image. Please select a fixed tag here.
ARG BASE_IMAGE=registry.git.rwth-aachen.de/jupyter/profiles/rwth-courses:latest
FROM ${BASE_IMAGE}

# Add juxl extension (learning analytics)
RUN jupyter labextension install \
    @juxl/juxl-extension@^3.1.1 \
    @juxl/logging@^3.1.1 

# Copy juxl settings for the extension
COPY --chown=1000 juxl.jupyterlab-settings /srv/conda/envs/notebook/share/jupyter/lab/settings/overrides.json

# Add jupyterlab feedback extension (llm)
ADD jupyterlab_feedback-0.6.2-py3-none-any.whl .
RUN pip install jupyterlab_feedback-0.6.2-py3-none-any.whl
