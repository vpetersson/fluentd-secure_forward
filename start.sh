#!/bin/sh -x

CONFFILE='/fluentd/etc/fluent.conf'

# Parse environment variables
if [ -n "$FLUENTD_SECRET" ]; then
  sed -i "s/FLUENTD_SECRET/$FLUENTD_SECRET/g" $CONFFILE
else
 echo "FLUENTD_SECRET environment variable must be set."
 exit 1
fi

if [ -n "$FLUENTD_TARGET" ]; then
  sed -i "s/FLUENTD_TARGET/$FLUENTD_TARGET/g" $CONFFILE
else
  echo "FLUENTD_TARGET environment variable must be set."
  exit 1
fi

if [ -n "$FLUENTD_PORT" ]; then
  sed -i "s/FLUENTD_PORT/$FLUENTD_PORT/g" $CONFFILE
else
  echo "FLUENTD_PORT not set. Defaulting to 24284."
  sed -i "s/FLUENTD_PORT/24284/g" $CONFFILE
fi

if [ -n "$MYHOSTNAME" ]; then
  sed -i "s/MYHOSTNAME/$MYHOSTNAME/g" $CONFFILE
else
  sed -i "s/MYHOSTNAME/$(hostname -f)/g" $CONFFILE
fi

# Args
if [ -n "$1" ]; then
  /usr/bin/fluentd -c "$CONFFILE" -p /fluentd/plugins "$1"
else
  /usr/bin/fluentd -c "$CONFFILE" -p /fluentd/plugins
fi
