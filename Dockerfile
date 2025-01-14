FROM jupyter/base-notebook:latest

# Встановлюємо конкретну версію JupyterLab, сумісну з розширеннями
RUN pip install jupyterlab==3.6.5

# Встановлюємо розширення через jupyter labextension
RUN jupyter labextension install \
    @juxl/juxl-extension@^3.1.1 \
    @juxl/logging@^3.1.1

COPY --chown=1000 juxl.jupyterlab-settings /srv/conda/envs/notebook/share/jupyter/lab/settings/overrides.json
RUN echo "c.NotebookApp.allow_origin = 'https://juxlauth-codingai.elearn.rwth-aachen.de'" >> /etc/jupyter/jupyter_notebook_config.py

# Add jupyterlab feedback extension (llm)
ADD jupyterlab_feedback-0.6.2-py3-none-any.whl .
RUN pip install jupyterlab_feedback-0.6.2-py3-none-any.whl

# Перевіряємо встановлені розширення
RUN jupyter labextension list

