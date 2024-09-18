# set base image
FROM python:3.10.10

# work dir
WORKDIR /opt/llm

# download dependencies and packages
COPY requirements.txt /tmp/requirements.txt

# build environment
ENV PYTHONPATH=/opt/llm

# locale
ENV LC_ALL=C.UTF-8

USER root

# apt-get
RUN set -evx \
            && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone \
            && sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
            && apt-get update \
            && apt-get install zip -y \
            && apt-get install curl -y \
            && apt-get install wget -y \
            && apt-get install net-tools -y \
            && apt-get install vim -y --allow-unauthenticated \
            && apt-get clean 
            
# pip install
RUN set -evx \
            && pip install -r /tmp/requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple/ --no-cache-dir

EXPOSE 23012
USER root

# set entrypoint
ENTRYPOINT [ "/opt/llm/start.sh" ]
