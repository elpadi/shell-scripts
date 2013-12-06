#!/bin/zsh

mysqldump -urss -prss rss | gzip > "$DROPBOX_DIR/Environment/rss/rss.sql.gz"
