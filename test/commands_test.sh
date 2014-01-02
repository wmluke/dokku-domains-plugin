#!/bin/bash

. test/assert.sh

STUBS=test/stubs
PATH="$STUBS:./:$PATH"
DOKKU_ROOT="test/fixtures/dokku"
dokku="PATH=$PATH DOKKU_ROOT=$DOKKU_ROOT commands"

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

# `domains:set` should create nginx-domains.conf, call pluginhook, and reload nginx
assert "$dokku domains:set rad-app radapp.com www.radapp.com" "[stub: pluginhook nginx-pre-reload rad-app]\n[stub: sudo /etc/init.d/nginx reload]"
expected=$(< "test/expected/nginx-domains.conf")
assert "cat test/fixtures/dokku/rad-app/nginx-domains.conf" "$expected"

# `domains` should read the set domains
assert "$dokku domains rad-app" "radapp.com www.radapp.com"

# end of test suite
assert_end examples

echo "" > test/fixtures/dokku/rad-app/DOMAINS
