FROM nginx

ARG SSH_USR=root
ARG SSH_PWD=1234

# http
EXPOSE 80

# ssh
EXPOSE 22

WORKDIR /usr/app

COPY nginx.conf nginx.conf
COPY --chmod=700 entrypoint.sh entrypoint.sh

RUN set -x\
    && apt update \
    && apt install --no-install-recommends --no-install-suggests -y \
        openssh-server 

RUN set -x \
    && echo "$SSH_USR:$SSH_PWD" >> ~/passwdfile  \
    && chpasswd -c SHA512 < ~/passwdfile  \
    && rm ~/passwdfile  \
    && sed -i "s/#Port.*/Port 22/" /etc/ssh/sshd_config  \
    && sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/" /etc/ssh/sshd_config  \
    && sed -i "s/#PasswordAuthentication.*/PasswordAuthentication yes/" /etc/ssh/sshd_config

ENTRYPOINT ["./entrypoint.sh"]

CMD ["top", "-b"]
