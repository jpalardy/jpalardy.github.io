---
layout: post
title: "From iptables to UFW: 5 things to note"
category: posts
---

When I migrated a [droplet](https://www.digitalocean.com/) from Ubuntu 14.04 to
16.04, the [tutorials](https://www.digitalocean.com/community/tutorials) clearly implied
that I should [use UFW](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-16-04).

UFW, the [Uncomplicated Firewall](https://en.wikipedia.org/wiki/Uncomplicated_Firewall), lives up to its name.
From what I read, it does everything I need, in a much simpler way than iptables.

What surprised me was everything those tutorials did NOT say...


## No configuration files?

Tutorials will encourage you to open some ports:

{% highlight bash %}
$ sudo ufw allow 22
$ sudo ufw allow 80
$ sudo ufw allow 443   # you know, the usual...
{% endhighlight %}

and turn on UFW:

{% highlight bash %}
$ sudo ufw enable
{% endhighlight %}

How does that even work?

It turns out that every command reaches into UFW's configuration files,
under `/etc/ufw/*.rules`, and adjusts them accordingly. You wouldn't normally edit
those files manually.


## Yes, your config will survive a reboot.

Once you enable UFW (above), and you understand that the config files were
written for you, it's not overly surprising to see why your firewall will come
back up after a reboot.

In fact, this is a refreshing change from [the bad old days](https://www.google.com/search?q=iptables+load+on+reboot).


## Check your rules ... before it's too late.

_After_ you enable UFW, if you haven't locked yourself out, you can review its rules:

{% highlight bash %}
$ sudo ufw status numbered

Status: active

     To                         Action      From
     --                         ------      ----
[ 1] 22                         ALLOW IN    Anywhere
[ 2] 80                         ALLOW IN    Anywhere
[ 3] 443                        ALLOW IN    Anywhere
[ 4] 22 (v6)                    ALLOW IN    Anywhere (v6)
[ 5] 80 (v6)                    ALLOW IN    Anywhere (v6)
[ 6] 443 (v6)                   ALLOW IN    Anywhere (v6)
{% endhighlight %}

But what about _before_ turning everything on?

I had to go look for it -- this [feature](https://bugs.launchpad.net/ufw/+bug/987784) was added later on:

{% highlight bash %}
$ sudo ufw show added
Added user rules (see 'ufw status' for running firewall):
ufw allow 22
ufw allow 80
ufw allow 443
{% endhighlight %}


## New rules are applied live.

If you change the rules:

{% highlight bash %}
$ sudo ufw delete 3     # close down port 443, see above
{% endhighlight %}

it's going to be applied _now_. You won't have to restart UFW. As always, the
configuration files will also be updated.


## Application provide their own UFW profiles

If you install NGINX, it will drop a file in `/etc/ufw/applications.d`:

{% highlight txt %}
[Nginx HTTP]
title=Web Server (Nginx, HTTP)
description=Small, but very powerful and efficient web server
ports=80/tcp

[Nginx HTTPS]
title=Web Server (Nginx, HTTPS)
description=Small, but very powerful and efficient web server
ports=443/tcp

[Nginx Full]
title=Web Server (Nginx, HTTP + HTTPS)
description=Small, but very powerful and efficient web server
ports=80,443/tcp
{% endhighlight %}

and you can see the inventory of profiles:

{% highlight bash %}
$ sudo ufw app list
Available applications:
  Nginx Full
  Nginx HTTP
  Nginx HTTPS
  OpenSSH
{% endhighlight %}

You can use a profile to configure UFW:

{% highlight bash %}
$ sudo ufw allow "Nginx Full"
{% endhighlight %}

There are 2 advantages to this:

- you don't have to clone-and-own that knowledge into your favorite provisioning tool
- modularity means that multiple packages don't fight for ownership of the firewall configuration files

