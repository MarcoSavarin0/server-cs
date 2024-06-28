FROM ubuntu:latest

RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y \
    libc6:i386 \
    libstdc++6:i386 \
        wget \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/hlds
WORKDIR /opt/hlds
COPY ./steamLoopScript.sh /opt/hlds/steamLoopScript.sh
RUN chmod +x /opt/hlds/steamLoopScript.sh
RUN set -x \
    && wget http://media.steampowered.com/client/steamcmd_linux.tar.gz \
    && tar -xvzf steamcmd_linux.tar.gz \
    && rm steamcmd_linux.tar.gz \
    && ./steamLoopScript.sh



WORKDIR /opt/hlds/cstrike
RUN echo "hostname \"Servidor CS 1.6 Dockerizado\"" > server.cfg \
    && echo "sv_lan 0" >> server.cfg \
    && echo "sv_region 0" >> server.cfg \
    && echo "maxplayers 16" >> server.cfg \
    && echo "map de_dust2" >> server.cfg \
    && echo "log on" >> server.cfg \
    && echo "sv_voiceenable 1" >> server.cfg \
    && echo "rcon_password marquito123" >> server.cfg

EXPOSE 27015/tcp
EXPOSE 27015/udp
EXPOSE 27020/tcp

CMD ["./hlds_run", "-game", "cstrike", "+maxplayers", "16", "+map", "de_dust2", "+rcon_password", "tucontraseña", "-port", "27015", "-pingboost", "1"]
