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
