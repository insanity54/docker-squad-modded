############################################################
# Dockerfile that builds a Squad Gameserver
############################################################
FROM cm2network/steamcmd

# Run Steamcmd and install Squad
RUN ./home/steam/steamcmd/steamcmd.sh +login anonymous \
        +force_install_dir /home/steam/squad-dedicated \
        +app_update 403240 validate \
        +quit


# Run Steamcmd and install mods
# 1313956617 - Karkand (https://steamcommunity.com/sharedfiles/filedetails/?id=1313956617)
RUN ./home/steam/steamcmd/steamcmd.sh +login anonymous \
  +force_install_dir /home/steam/squad-dedicated \
  +workshop_download_item 393380 1313956617 +quit

# 205163003 - Helicopter Test (https://steamcommunity.com/sharedfiles/filedetails/?id=1205163003)
RUN ./home/steam/steamcmd/steamcmd.sh +login anonymous \
  +force_install_dir /home/steam/squad-dedicated \
  +workshop_download_item 393380 1205163003 +quit


ENV PORT=7787 QUERYPORT=27165 RCONPORT=21114 RCONPASSWORD=hackme RCONIP=0.0.0.0 FIXEDMAXPLAYERS=80 RANDOM=NONE

VOLUME /home/steam/squad-dedicated

# Set Entrypoint; Technically 2 steps: 1. Update server, 2. Start server
ENTRYPOINT ./home/steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/steam/squad-dedicated +app_update 403240 +quit && \
        ./home/steam/squad-dedicated/SquadServer.sh Port=$PORT QueryPort=$QUERYPORT RCONPORT=$RCONPORT RCONPASSWORD=$RCONPASSWORD RCONIP=$RCONIP FIXEDMAXPLAYERS=$FIXEDMAXPLAYERS RANDOM=$RANDOM
