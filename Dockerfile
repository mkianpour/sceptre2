#FROM python:3.8-slim
FROM python:3.8-alpine
WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN pip3 install --no-deps awscli boto3 

RUN apk add --update \
    curl tar\
    && rm -rf /var/cache/apk/*

# KUBECTL
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl

# KUSTOMIZE
RUN kustomize_package=kustomize_v3.3.0_linux_amd64.tar.gz; \
    curl -L -o $kustomize_package https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv3.3.0/$kustomize_package; \
    tar xzf $kustomize_package; \ 
    mv ./kustomize /usr/local/bin/kustomize

RUN rm -rf /var/lib/apt/lists/*
#COPY . .
CMD ["sceptre", "--version"]
