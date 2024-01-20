FROM python:alpine3.17
RUN apk --no-cache add xorriso redis jq unzip git
WORKDIR /app
COPY requirements.txt /app
# COPY *.py /app
ENV TZ=America/Sao_Paulo
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
# RUN pip install --upgrade --no-cache-dir git+https://github.com/vmware/vsphere-automation-sdk-python.git
ENTRYPOINT ["python"]