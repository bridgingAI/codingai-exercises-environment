FROM jupyter/base-notebook:latest

RUN pip install jupyterlab==3.6.5

# Add juxl extension (learning analytics)
# Встановлюємо розширення через pip
RUN pip install juxl-extension juxl-logging

COPY --chown=1000 juxl.jupyterlab-settings /srv/conda/envs/notebook/share/jupyter/lab/settings/overrides.json
RUN echo "c.NotebookApp.allow_origin = 'https://juxlauth-codingai.elearn.rwth-aachen.de'" >> /etc/jupyter/jupyter_notebook_config.py

# Add jupyterlab feedback extension (llm)
ADD jupyterlab_feedback-0.6.2-py3-none-any.whl .
RUN pip install jupyterlab_feedback-0.6.2-py3-none-any.whl


# Перевіряємо встановлені розширення
RUN jupyter labextension list

