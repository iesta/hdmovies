#!/bin/sh

# synch db
scp jm@shoyu.akamusic.com:~/hdmovies/db/hdmovies.sqlite3 db/

# sync assets
rsync -var jm@shoyu.akamusic.com:~/hdmovies/public/assets ./public/