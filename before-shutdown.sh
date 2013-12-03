#!/bin/zsh

mysqldump -uroot -p rss | gzip > "$DROPBOX_DIR/Environment/rss/rss.sql.gz"
