# It is time for collecting everything important for my linux environment

## Mouse Acceliration
by default graphical display servers such as x-org or wayland, adds some acceleration to mouse speed (they don't increase the speed although they can, but they accelerate it), meaning that the speed of the pointer will vary depending on the physical mouse speed, there is no fixed ratio between them.

---

### [source: Arch wiki](https://wiki.archlinux.org/title/Mouse_acceleration)
Disabling the mouse acceleration means that a linear function will be used to map from physical to virtual mouse movements. The mouse speed setting controls the inclination of this linear function.
To completely disable any sort of acceleration/deceleration, create the following file:
`/etc/X11/xorg.conf.d/50-mouse-acceleration.conf`
```
Section "InputClass"
	Identifier "<name of the mouse>"
	MatchIsPointer "yes"
	Option "AccelerationProfile" "-1"
	Option "AccelerationScheme" "none"
	Option "AccelSpeed" "-1"
EndSection
```

### to get the name of the mouse use this command:
```
xinput list-props $(xinput list | grep pointer | cut -d '=' -f 2 | cut -f 1)
```
This will list out the properties of all the pointers in use.
the name of the device we want will have an `accel` property or something similar.

---

## Audio
just insall pipewire and enable the services
```sh
systemctl --user --now enable pipewire pipewire-pulse wireplumber
```


## How To Transfere files with cat7 cable
Imagine we have two hosts, A and B, we want to send a file or more from A to B

it's actually easy as cake and faster than using usb

- plug the cable to both hosts

- make a subnet mask and give each host an IP address in the subnet
    > in host A:
    > ```sh
    > ip address add 10.0.0.10/24 dev <device_name>
    > ```
    > in host B:
    > ```sh
    > ip address add 10.0.0.20/24 dev <device_name>
    > ```
    > you can choose whatever IPs you like but make sure they are in the same subnet.
    > 
    > > to get the device name just run `ip addr show`

- connect B to A while A is listening to a port and sending the files into it
    > in host A:
    > ```sh
    > tar cz /path/to/send | nc -q <timeout_seconds> -l -p <port>
    > ```
    > in host B:
    > ```sh
    > nc -w <wait_seconds> <ip_given_to_A> <port> | tar xz --directory /path/to/save
    > ```

And thats it after the transfere is done the connection will close, because we specified the `-q` option.
> Avoid typing to `stdin` in both terminal while transfering, if you are using a terminal emulator you are free to open another terminal and do whatever you want while the files are being transfered.
