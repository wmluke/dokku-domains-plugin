#!/bin/bash

. test/assert.sh

STUBS=test/stubs
PATH="$STUBS:./:$PATH"
DOKKU_ROOT="test/fixtures/dokku"
post_install="PATH=$PATH DOKKU_ROOT=$DOKKU_ROOT post-deploy"

# `post-deploy` should prob not do much if the app doesn't have any domains
assert "$post_install empty-app" ""

# `post-deploy` should update nifty-app/nginx-domains.conf
assert "$post_install nifty-app" "[stub: dokku domains:set nifty-app nifty.com www.nifty.com]\n[stub: pluginhook nginx-pre-reload nifty-app]\n[stub: sudo /etc/init.d/nginx reload]"
expected=$(< "test/expected/nifty-app-nginx-domains.conf")
assert "cat test/fixtures/dokku/nifty-app/nginx-domains.conf" "$expected"

# end of test suite
assert_end examples

echo "" > test/fixtures/dokku/rad-app/DOMAINS
rm test/fixtures/dokku/nifty-app/nginx-domains.conf
