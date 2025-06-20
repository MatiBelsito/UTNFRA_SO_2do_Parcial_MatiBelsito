#!/bin/bash

sudo fdisk /dev/sde << EOF
n
p
1

+512M
t
82
n
p
2


EOF

