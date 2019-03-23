
FROM cm2network/steamcmd

WORKDIR /


# Run Steamcmd and install Squad
# Steam game id 403240 is Squad Dedicated Server
RUN /home/steam/steamcmd/steamcmd.sh +login anonymous \
        +force_install_dir /home/steam/squad-dedicated \
        +app_update 403240 validate \
        +quit

# Run Steamcmd and install mods
# Steam game ID 393380 is Squad
# 1313956617 - Karkand (https://steamcommunity.com/sharedfiles/filedetails/?id=1313956617)
RUN /home/steam/steamcmd/steamcmd.sh +login anonymous \
  +force_install_dir /home/steam/squad-dedicated \
  +workshop_download_item 393380 1313956617 +quit


# 205163003 - Helicopter Test (https://steamcommunity.com/sharedfiles/filedetails/?id=1205163003)
RUN /home/steam/steamcmd/steamcmd.sh +login anonymous \
  +force_install_dir /home/steam/squad-dedicated \
  +workshop_download_item 393380 1205163003 +quit


# Set default env variables
ENV PORT=7787 QUERYPORT=27165 RCONPORT=21114 RCONPASSWORD=hackmeharder RCONIP=0.0.0.0 FIXEDMAXPLAYERS=80 RANDOM=NONE


COPY --chown=steam ./Admins.cfg ./MapRotation.cfg ./Server.cfg /home/steam/squad-dedicated/Squad/ServerConfig/
RUN ls -la /home/steam/squad-dedicated/Squad/ServerConfig


ENTRYPOINT /home/steam/squad-dedicated/SquadServer.sh Port=$PORT QueryPort=$QUERYPORT RCONPORT=$RCONPORT RCONPASSWORD=$RCONPASSWORD RCONIP=$RCONIP FIXEDMAXPLAYERS=$FIXEDMAXPLAYERS RANDOM=$RANDOM
