#!/bin/bash
systemctl --user restart wireplumber pipewire pipewire-pulse
rm -r ~/.config/pulse
