# dokku-domains-plugin

[Dokku](https://github.com/progrium/dokku) plugin to add additional domains to the nginx vhost server_name directive.

## Installation

```bash
git clone https://github.com/neam/dokku-domains-plugin.git /var/lib/dokku/plugins/domains-plugin
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
