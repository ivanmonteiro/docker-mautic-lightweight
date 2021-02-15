# docker-mautic-low-memory
Repository: https://github.com/ivanmonteiro/docker-mautic-low-memory

## Introduction
The original [docker-mautic](https://github.com/mautic/docker-mautic) image uses too much memory, making it difficult to run on most entry-tier servers which usually has less than 1GB of RAM memory.

Docker-mautic-low-memory uses up to 6x less memory. 

Without the modifications listed below, the server RAM was hitting 100% and occasionaly the server would be unresponsive and crash. Tests were running at Google Cloud's free-tier instance [f1-micro](https://cloud.google.com/compute/docs/machine-types) (total 0.6GB memory). 

Now, mautic runs at idle using ~20mb and occasionally ~120mb when running cron background jobs.

## Improvements to reduce memory usage

The crontab was changed to avoid running tasks in parallel. The default mautic crontab run too many tasks at the same time.

Using php-fpm and nginx also has shown to further reduce memory usage, specially on idle. The file `www2-override-mautic-fpm.conf` limits the maximum child processes and uses about ~20mb when no requests/background jobs are being processed.

The environment variable `PHP_MEMORY_LIMIT` is set to 128MB (original is 512MB). Keep in mind that if you run into errors try to increase mautic's  `PHP_MEMORY_LIMIT` environment variable at `docker-compose.yml`.

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
docker-compose build
docker-compose up -d
```

Contributions are welcome!