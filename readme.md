# dokku-domains-plugin

[![Build Status](https://travis-ci.org/wmluke/dokku-domains-plugin.png?branch=master)](https://travis-ci.org/wmluke/dokku-domains-plugin)
[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/wmluke/dokku-domains-plugin/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

[Dokku](https://github.com/progrium/dokku) plugin to create nginx vhost with multiple domains.

## Installation

```bash
git clone https://github.com/wmluke/dokku-domains-plugin.git /var/lib/dokku/plugins/domains-plugin
```

## Commands

```bash
$ dokku help
    domains <app>                                   display the domains for an app
    domains:set <app> DOMAIN1 [DOMAIN2 ...]         set one or more domains
```

## Simple usage

Create vhost with a second domain:

```bash
$ dokku domains:set <app> myawesomeapp.com            # Server side
$ ssh dokku@server domains:set <app> myawesomeapp.com # Client side
```

Create vhost with multiple additional domains:

```bash
$ dokku domains:set <app> myawesomeapp.com www.myawesomeapp.com            # Server side
$ ssh dokku@server domains:set <app> myawesomeapp.com www.myawesomeapp.com # Client side
```

Note: The original domain set by dokku nginx-vhosts plugin is kept active.

## License
MIT
