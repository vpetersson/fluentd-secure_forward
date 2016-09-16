# fluentd-secure_forward
The official fluentd container with the `secure_forward` plugin enabled.

## Start the container

```
$ docker run -d -ti \
  --name fluentd_agent \
  -p 127.0.0.1:24224:24224 \
  -e FLUENTD_TARGET=fluentd.somehost.com \
  -e FLUENTD_SECRET=ABC123 \
  vpetersson/fluentd-secure_host
```

With the container running, you can now launch your other containers with:

```
$ docker run -ti \
  --log-driver=fluentd \
  your-contianer
```

Built for [Provisioner](https://provisioner.vpetersson.com).
