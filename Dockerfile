FROM jupyter/base-notebook:latest

# Встановлюємо nvm для керування версіями Node.js
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

# Завантажуємо nvm
ENV NVM_DIR=/root/.nvm
ENV NODE_VERSION=16.20.1

# Встановлюємо конкретну версію Node.js (наприклад, 16.20.1)
RUN . $NVM_DIR/nvm.sh && nvm install $NODE_VERSION && nvm use $NODE_VERSION

# Встановлюємо npm через nvm
RUN . $NVM_DIR/nvm.sh && npm install -g npm@latest

# Встановлюємо JupyterLab
RUN pip install jupyterlab==3.6.5

# Інсталюємо розширення через JupyterLab extension manager
RUN jupyter labextension install @juxl/juxl-extension@^3.1.1 @juxl/logging@^3.1.1

# Копіюємо файл overrides.json
COPY --chown=1000 overrides.json /srv/conda/envs/notebook/share/jupyter/lab/settings/overrides.json

# Копіюємо jupyter_config.py
COPY jupyter_config.py /etc/jupyter/jupyter_notebook_config.py

# Додаємо та встановлюємо jupyterlab_feedback
ADD jupyterlab_feedback-0.6.2-py3-none-any.whl /tmp/
RUN pip install /tmp/jupyterlab_feedback-0.6.2-py3-none-any.whl

# Виконуємо додаткові налаштування з postBuild
COPY postBuild /tmp/postBuild
RUN bash /tmp/postBuild

# Перевіряємо встановлені розширення
RUN jupyter labextension show
