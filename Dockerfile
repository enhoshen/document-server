FROM nginx

ARG SSH_USR=root
ARG SSH_PWD=1234
ARG BASE=/usr/app

# http, ssh
EXPOSE 80 22

WORKDIR $BASE

# By using --link, COPY doesn't depend on previous docker image layer
COPY --link --chmod=700 nginx.conf entrypoint.sh ./ 

# openssh-server requires `apt update`, otherwise the build may be
# much faster without it
RUN set -x\
    && apt update \
    && apt install --no-install-recommends --no-install-suggests -y \
        openssh-server 

# Set up ssh server, daemon
RUN set -x \
    && echo "$SSH_USR:$SSH_PWD" >> ~/passwdfile  \
    && chpasswd -c SHA512 < ~/passwdfile  \
    && rm ~/passwdfile  \
    && sed -i "s/#Port.*/Port 22/" /etc/ssh/sshd_config  \
    && sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/" /etc/ssh/sshd_config  \
    && sed -i "s/#PasswordAuthentication.*/PasswordAuthentication yes/" /etc/ssh/sshd_config \
    && mkdir -p $BASE/log 

ENTRYPOINT ["./entrypoint.sh"]

CMD ["top", "-b"]
