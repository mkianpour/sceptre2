FROM python:3

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN pip3 install --no-deps awscli boto3 jq

COPY . .
CMD ["sceptre", "--version"]
