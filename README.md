# docker-mautic-lightweight


## Introduction

**[docker-mautic-lightweight](https://hub.docker.com/r/ivanmonteiro/docker-mautic-lightweight) uses up to 6x less memory and uses less CPU usage when running background tasks.**

The original [docker-mautic](https://github.com/mautic/docker-mautic) image uses too much memory and CPU, making it difficult to run on modest vps servers. Most entry-tier vps servers of cloud providers has <= 1GB of RAM memory. Also some vps use shared-core CPU with constraints on how much cpu one application can use, e.g., Google Cloud's E2 shared-core instances.

Without modifications, the original [docker-matutic](https://github.com/mautic/docker-mautic) image deployeed on a [f1-micro](https://cloud.google.com/compute/docs/machine-types) (0.6GB memory/shared CPU) instance was hitting 100% RAM usage and 100% CPU usage spikes.

Now using docker-mautic-lightweight the same [f1-micro](https://cloud.google.com/compute/docs/machine-types) instance runs at idle using ~20mb and occasionally ~120mb when running cron background jobs.

## Pre-requisites

- You should have [docker](https://docs.docker.com/get-docker/) installed and configured at your server.

- Change server_name at `nginx/mautic-fpm.conf`.

- Set up a ssl certificate and add it to `nginx/mautic-fpm.conf`.

Optional (but recommended): 
- [Check if your server has swap enabled](https://superuser.com/questions/706748/how-to-check-the-swap-is-on-or-off). 
- If swap file is disabled, [create a swap file on your server](https://linuxize.com/post/create-a-linux-swap-file/). On memory-constrained servers it is often useful to have swap on to avoid crashes when the server's memory limit is reached.

## Usage

Clone this repository: https://github.com/ivanmonteiro/docker-mautic-low-memory

And run:
```
docker-compose up -d
```

## Improvements to reduce memory usage

Most of the improvements of RAM usage are due to changing the background tasks running on crontab. The default mautic crontab run too many tasks at the same time.

Also, using php-fpm and nginx also has shown to further reduce memory usage, specially at idle. The file `www2-override-mautic-fpm.conf` limits the maximum child processes and uses about ~20mb when no requests are being processed.

The environment variable `PHP_MEMORY_LIMIT` is set to 128MB (original is 512MB). Keep in mind that if you run into errors try to increase mautic's `PHP_MEMORY_LIMIT` environment variable at `docker-compose.yml`.

Github URL: https://github.com/ivanmonteiro/docker-mautic-low-memory

Docker Hub URL: https://hub.docker.com/r/ivanmonteiro/docker-mautic-lightweight

Contributions are welcome!
