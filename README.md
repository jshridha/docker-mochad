# Mochad in Docker
Mochad is a daemon for communicating with X10 home automation controllers.

This is a dockerized version of that daemon using an alpine baseimage weighing in at 3 MB total.

## To run this docker:

### Find which USB bus is hosting your X10 controller:
```sh
lsusb
```
Find your device from the output:
```
Bus 002 Device 005: ID 0bc7:0001 X10 Wireless Technology, Inc. ActiveHome (ACPI-compliant)
```

This indicates that your device is on bus 002, which should be passed through to the docker container

### Run the mochad docker container:

Example run command using the device found above:
```sh
docker run -d --name=mochad --device "/dev/bus/usb/002" jshridha/mochad:latest
```

### Check that your container is communicating with the usb device:
```
docker logs -f mochad
```

The docker is running properly:
```
Jun 29 20:54:34 34929f4bcf53 mochad[29]: starting
Jun 29 20:54:34 34929f4bcf53 mochad[29]: Found CM15A
Jun 29 20:54:34 34929f4bcf53 mochad[29]: In endpoint 0x81, Out endpoint 0x02
```

If you see this line, double check that you passed the correct USB bus and that nothing else is trying to use the device
```
mochad.c:627:Could not find/open CM15A/CM19A -5
```
