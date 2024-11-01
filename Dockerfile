FROM python:3.8-slim-buster

RUN mkdir -p /home/notebooks
WORKDIR /home/notebooks
COPY . .
RUN pip install numpy \
                pandas \
                scikit-learn \
                seaborn \
                jupyter \
                notebook
EXPOSE 8888

ENTRYPOINT ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
