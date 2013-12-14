#!/bin/zsh

zcat "$DROPBOX_DIR/Environment/rss/rss.sql.gz" | mysql -urss -prss rss
