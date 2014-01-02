# dokku-domains-plugin

[![Build Status](https://travis-ci.org/wmluke/dokku-domains-plugin.png?branch=master)](https://travis-ci.org/wmluke/dokku-domains-plugin)
[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/wmluke/dokku-domains-plugin/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

[Dokku](https://github.com/progrium/dokku) plugin to create nginx vhost with multiple domains.

## Installation

```bash
git clone https://github.com/wmluke/dokku-domains-plugin.git /var/lib/dokku/plugins/domains-plugin
dokku plugins-install
```

## Commands

```bash
$ dokku help
    domains <app>                                   display the domains for an app
    domains:set <app> DOMAIN1 [DOMAIN2 ...]         set one or more domains
```

## Simple usage

Your need to have app running with the same name!

Create vhost with multiple domains:

```bash
$ dokku domains:set myawesomeapp.com www.myawesomeapp.com            # Server side
$ ssh dokku@server domains:set myawesomeapp.com www.myawesomeapp.com # Client side
```

## License
MIT
