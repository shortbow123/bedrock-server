FROM fedora:28

LABEL version="1.8.0.24"

ENV NAME Bedrock-Server
ENV arc=bedrock-server-1.8.0.24.zip
ENV dlarc=https://minecraft.azureedge.net/bin-linux/${arc}

WORKDIR /opt/minecraft

RUN ["dnf", "-y", "upgrade"]
RUN ["dnf", "-y", "install", "unzip", "libstdc++"]
RUN ["dnf", "clean", "all"]
RUN ["rm", "-rf", "/var/cache/dnf"]

ADD ${dlarc} ${arc}
RUN unzip -n ${arc}

VOLUME ["/opt/minecraft/permissions.json"]
VOLUME ["/opt/minecraft/server.properties"]
VOLUME ["/opt/minecraft/whitelist.json"]
VOLUME ["/opt/minecraft/worlds"]

ADD ./startup.sh /opt/minecraft/
RUN ["chmod", "+x", "/opt/minecraft/startup.sh"]

EXPOSE 19132/udp
EXPOSE 19132/tcp

ENTRYPOINT ["/opt/minecraft/startup.sh", "/bin/bash"]