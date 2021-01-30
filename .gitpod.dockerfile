FROM gitpod/workspace-postgres

RUN sudo apt-get update \
 && sudo apt-get install -y \
    psql \
 && sudo rm -rf /var/lib/apt/lists/*

 ENV PATH="$PATH:/usr/lib/postgresql/12/bin"
 