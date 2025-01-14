FROM jupyter/base-notebook:latest

# Встановлюємо конкретну версію JupyterLab, сумісну з розширеннями
RUN pip install jupyterlab==3.6.5

# Копіюємо файл налаштувань
COPY --chown=1000 juxl.jupyterlab-settings /srv/conda/envs/notebook/share/jupyter/lab/settings/overrides.json

# Налаштовуємо доступ до Jupyter Notebook
RUN echo "c.NotebookApp.allow_origin = 'https://juxlauth-codingai.elearn.rwth-aachen.de'" >> /etc/jupyter/jupyter_notebook_config.py

# Додаємо та встановлюємо jupyterlab_feedback
ADD jupyterlab_feedback-0.6.2-py3-none-any.whl /tmp/
RUN pip install /tmp/jupyterlab_feedback-0.6.2-py3-none-any.whl

# Перевіряємо встановлені розширення
RUN jupyter labextension list
