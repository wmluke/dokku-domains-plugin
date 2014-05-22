#!/bin/bash

. test/assert.sh

STUBS=test/stubs
PATH="$STUBS:./:$PATH"
DOKKU_ROOT="test/fixtures/dokku"
dokku="PATH=$PATH DOKKU_ROOT=$DOKKU_ROOT commands"

cp "test/fixtures/dokku/rad-app/nginx.conf.org" "test/fixtures/dokku/rad-app/nginx.conf"
cp "test/fixtures/dokku/secure-app/nginx.conf.org" "test/fixtures/dokku/secure-app/nginx.conf"

# `domains` requires an app name
assert "$dokku domains" "You must specify an app name"
assert_raises "$dokku domains" 1

# `domains` requires an existing app
assert "$dokku domains foo" "App foo does not exist"
assert_raises "$dokku domains" 1

# `domains:set` requires an app name
assert "$dokku domains:set" "You must specify an app name"
assert_raises "$dokku domains:set" 1

# `domains:set` requires an existing app
assert "$dokku domains:set foo" "App foo does not exist"
assert_raises "$dokku domains:set foo" 1

# `domains:set` requires at least one domain
assert "$dokku domains:set rad-app" "Usage: dokku domains:set APP DOMAIN1 [DOMAIN2 ...]\nMust specify a DOMAIN."
assert_raises "$dokku domains:set rad-app" 1

# `domains:set` should modify nginx.conf, call pluginhook, and reload nginx
assert "$dokku domains:set rad-app radapp.com www.radapp.com" "[stub: pluginhook nginx-pre-reload rad-app]\n[stub: sudo /etc/init.d/nginx reload]"
expected=$(< "test/expected/rad-app-nginx.conf")
assert "cat test/fixtures/dokku/rad-app/nginx.conf" "$expected"

# `domains` should read the set domains
assert "$dokku domains rad-app" "radapp.com www.radapp.com"

assert "$dokku domains:set secure-app vault.it www.vault.it " "[stub: pluginhook nginx-pre-reload secure-app]\n[stub: sudo /etc/init.d/nginx reload]"
expected=$(< "test/expected/secure-app-nginx.conf")
assert "cat test/fixtures/dokku/secure-app/nginx.conf" "$expected"

assert "$dokku domains secure-app" "vault.it www.vault.it"

# end of test suite
assert_end examples

echo "" > test/fixtures/dokku/rad-app/DOMAINS
echo "" > test/fixtures/dokku/secure-app/DOMAINS
rm "test/fixtures/dokku/rad-app/nginx.conf"
rm "test/fixtures/dokku/secure-app/nginx.conf"
