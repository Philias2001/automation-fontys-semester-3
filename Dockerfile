FROM ubuntu:20.04

RUN apt-get -y update && apt-get -y install sudo nano openssh-server ufw

ENTRYPOINT service ssh start && service ufw start && bash

# COPY ./sudoers /etc/sudoers
COPY ./.not_logged_in_yet /etc/profile.d/check_first_login.sh

RUN ufw allow ssh

RUN adduser serveradmin
RUN usermod -aG sudo serveradmin
RUN echo 'serveradmin:Ubuntu' | chpasswd

# RUN echo "#!/bin/bash\n\$@" > /usr/bin/sudo
# RUN chmod +x /usr/bin/sudo

# RUN chown root:root /usr/bin/sudo && chmod 4755 /usr/bin/sudo
# RUN sudo mount -n -o remount,suid /

# USER serveradmin
WORKDIR /home/serveradmin

RUN ln -s / ubuntu
RUN chmod +x ./

RUN touch ./.not_logged_in_yet
RUN chown serveradmin .not_logged_in_yet
RUN chmod u+rw .not_logged_in_yet

RUN chmod 640 /etc/shadow