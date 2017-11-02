---
layout: post
title: "Throwaway MySQL Servers with Docker"
category: posts
---

## MySQL without the Mess

Sometimes, I need MySQL<sup>[1](#fn1)</sup> but:

* I don't want to install MySQL on macOS (homebrew or otherwise).
* I don't want to spin up a virtual machine (locally or in the cloud).
* I don't want to install it, administer it, upgrade it, or clean it up.

With Docker, I can pull down the [official MySQL image](https://hub.docker.com/_/mysql/)
and run _both_ server and client from it.


## What to Install

Get [Docker for Mac](https://www.docker.com/docker-mac), or equivalent. Once installed,
you get the menu bar whale icon and the `docker` command will be available on
the command-line.

Pull down the mysql image:

{% highlight bash %}
$ docker pull mysql
{% endhighlight %}

or, if you don't want latest, check the [available versions](https://hub.docker.com/_/mysql/).

This isn't a Docker tutorial; you know [where](https://www.google.com/search?q=docker+tutorial) to find one if needed :-)


## How to Run the Server

Run this command in its own terminal. This is where you'll control the
MySQL server and see its logs.

{% highlight bash %}
$ docker run -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -p 3306:3306 --rm mysql

# docker run                   -- runs an image
# -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -- sets an environment variable
# -p 3306:3306                 -- exposes container port 3306 as local port 3306
# --rm                         -- cleans up container after it exits
# mysql                        -- the name of the image to run
{% endhighlight %}

The use of `-e MYSQL_ALLOW_EMPTY_PASSWORD=yes` might raise an eyebrow, but
we're not deploying to production. This is _meant_ to be run locally and to be
trashed. Convenience is often the opposite of security.

Note: `ctrl-c` doesn't kill the server -- but `ctrl-\` does.


## How to Run the Client

Run this command in another terminal. This is where you'll run the client and
connect to the MySQL server. This is where you'll type your commands.

{% highlight bash %}
$ docker run -it -v $PWD:/data -w /data --rm mysql mysql -h $LOCAL_IP -u root -p

# docker run                      -- runs an image
# -i                              -- keeps STDIN open
# -t                              -- allocates a pseudo-TTY
# -v $PWD:/data                   -- binds $PWD to /data inside the container
# -w /data                        -- changes the PWD of the container to /data
# --rm                            -- cleans up container after it exits
# mysql                           -- the name of the image to run
# mysql -h $LOCAL_IP -u root -p   -- the command to run inside the container
{% endhighlight %}

We configured the server so the root account doesn't have a password; press ENTER when prompted.

Don't use `127.0.0.1` for `$LOCAL_IP`, it only works with your real IP address.


## This MySQL Server is Empty... Now What?

This is by design: you're spinning up a brand new MySQL server with nothing in it.

There are two ways to initialize the server with your data:

* loading data from the client
* starting the server with the data

## Loading Data From the Client

The way we configured the client, all your $PWD files are available from the
client container. In the MySQL client, source the relevant SQL dump to bootstrap the server.

{% highlight SQL %}
> source dump.sql
{% endhighlight %}


## Starting the Server with the Data

The [documentation](https://hub.docker.com/_/mysql/) says:

{% highlight text %}
[the container] will execute files with extensions .sh, .sql and .sql.gz
that are found in /docker-entrypoint-initdb.d. Files will be executed in
alphabetical order.
{% endhighlight %}

Yes, it's a bit magical but, if you put .sql (etc) files in `/docker-entrypoint-initdb.d`,
they will be automatically loaded into the server.

In practice, add `-v` to the server command from above:

{% highlight bash %}
$ docker run -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -p 3306:3306 \
  -v $PWD:/docker-entrypoint-initdb.d --rm mysql
{% endhighlight %}

`$PWD` assumes you start the server in the directory where your .sql files are. If that's not the case, replace `$PWD`
with the directory that contains your SQL dump.


## Discussion

It's possible to create an image with your data already sitting in the
`/docker-entrypoint-initdb.d` directory. It could be convenient to use and
distribute this image rather than following these instructions.

With the right docker images, it's easy to run multiple versions of MySQL.
Use `mysql:8.0.3` (for example) instead of `mysql` for the image name.

The image's [DockerHub page](https://hub.docker.com/_/mysql/) contains a _LOT_
more options. If you're going to use the image, I recommend going over its documentation.

If you're curious, all the details are contained in the [Dockerfile](https://github.com/docker-library/mysql/blob/883703dfb30d9c197e0059a669c4bb64d55f6e0d/5.7/Dockerfile).

--------------------------------------------------

<a name="fn1">1</a>: I'm taking a MOOC, it's a long story.

