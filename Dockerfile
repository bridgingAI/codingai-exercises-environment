FROM jupyter/base-notebook:latest

# Встановлюємо JupyterLab
RUN pip install jupyterlab==3.6.5

# Копіюємо файл overrides.json
COPY --chown=1000 overrides.json /srv/conda/envs/notebook/share/jupyter/lab/settings/overrides.json

# Копіюємо jupyter_config.py
COPY jupyter_config.py /etc/jupyter/jupyter_notebook_config.py

# Додаємо та встановлюємо jupyterlab_feedback
ADD jupyterlab_feedback-0.6.2-py3-none-any.whl /tmp/
RUN pip install /tmp/jupyterlab_feedback-0.6.2-py3-none-any.whl

# Встановлюємо додаткові розширення з extensions-pip.txt
COPY extensions-pip.txt /tmp/extensions-pip.txt
RUN pip install -r /tmp/extensions-pip.txt

# Виконуємо додаткові налаштування з postBuild
COPY postBuild /tmp/postBuild
RUN bash /tmp/postBuild

# Перевіряємо встановлені розширення
RUN jupyter labextension list
