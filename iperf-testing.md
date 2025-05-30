# Testing

## Arch bare-metal

```bash
ip addr add 10.254.255.51/24 dev enp1s0f0np0
ip link set dev enp1s0f0np0 mtu 9000
ethtool -K enp1s0f0np0 tso on gso on gro on rx-checksumming on tx-checksumming on
```

### `tso on`

```
tx-tcp-ecn-segmentation: off [requested on]
tx-tcp-mangleid-segmentation: on
```

### `gso on`

No output

### `gro on`

No output

### `rx-checksumming on`

No output

### `tx-checksumming on`

```
tx-checksum-ipv4: off [requested on]
rx-checksum-ipv4: off [requested on]
tx-checksum-fcoe-crc: off [requested on]
tx-checksum-sctp: off [requested on]
```

### No tuning on host

```bash
root@pve01:~# iperf3 -B 10.254.255.55 -c 10.254.255.51
Connecting to host 10.254.255.51, port 5201
[  5] local 10.254.255.55 port 56017 connected to 10.254.255.51 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  2.74 GBytes  23.5 Gbits/sec    0    902 KBytes       
[  5]   1.00-2.00   sec  2.74 GBytes  23.5 Gbits/sec    0    860 KBytes       
[  5]   2.00-3.00   sec  2.74 GBytes  23.5 Gbits/sec    0    735 KBytes       
[  5]   3.00-4.00   sec  2.74 GBytes  23.5 Gbits/sec    0    834 KBytes       
[  5]   4.00-5.00   sec  2.74 GBytes  23.5 Gbits/sec    0    928 KBytes       
[  5]   5.00-6.00   sec  2.73 GBytes  23.5 Gbits/sec    0   1.01 MBytes       
[  5]   6.00-7.00   sec  2.74 GBytes  23.5 Gbits/sec    0    880 KBytes       
[  5]   7.00-8.00   sec  2.74 GBytes  23.5 Gbits/sec    0    732 KBytes       
[  5]   8.00-9.00   sec  2.74 GBytes  23.5 Gbits/sec    0    812 KBytes       
[  5]   9.00-10.00  sec  2.74 GBytes  23.5 Gbits/sec    0    897 KBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  27.4 GBytes  23.5 Gbits/sec    0             sender
[  5]   0.00-10.00  sec  27.4 GBytes  23.5 Gbits/sec                  receiver

iperf Done.

root@pve01:~# iperf3 -B 10.254.255.55 -c 10.254.255.51 -R
Connecting to host 10.254.255.51, port 5201
Reverse mode, remote host 10.254.255.51 is sending
[  5] local 10.254.255.55 port 53761 connected to 10.254.255.51 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  1.72 GBytes  14.8 Gbits/sec                  
[  5]   1.00-2.00   sec  1.74 GBytes  14.9 Gbits/sec                  
[  5]   2.00-3.00   sec  1.73 GBytes  14.9 Gbits/sec                  
[  5]   3.00-4.00   sec  1.73 GBytes  14.9 Gbits/sec                  
[  5]   4.00-5.00   sec  1.73 GBytes  14.8 Gbits/sec                  
[  5]   5.00-6.00   sec  1.73 GBytes  14.9 Gbits/sec                  
[  5]   6.00-7.00   sec  1.33 GBytes  11.4 Gbits/sec                  
[  5]   7.00-8.00   sec  1.65 GBytes  14.2 Gbits/sec                  
[  5]   8.00-9.00   sec  1.73 GBytes  14.9 Gbits/sec                  
[  5]   9.00-10.00  sec  1.72 GBytes  14.8 Gbits/sec                  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  16.8 GBytes  14.5 Gbits/sec  401             sender
[  5]   0.00-10.00  sec  16.8 GBytes  14.5 Gbits/sec                  receiver

iperf Done.
```

### MTU Correction

```bash
root@pve01:~# iperf3 -B 10.254.255.55 -c 10.254.255.51
Connecting to host 10.254.255.51, port 5201
[  5] local 10.254.255.55 port 54971 connected to 10.254.255.51 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  2.86 GBytes  24.6 Gbits/sec    0   1.26 MBytes       
[  5]   1.00-2.00   sec  2.87 GBytes  24.7 Gbits/sec    0   1.13 MBytes       
[  5]   2.00-3.00   sec  2.88 GBytes  24.7 Gbits/sec    0   1.14 MBytes       
[  5]   3.00-4.00   sec  2.88 GBytes  24.7 Gbits/sec    0   1.14 MBytes       
[  5]   4.00-5.00   sec  2.87 GBytes  24.6 Gbits/sec    0   1.62 MBytes       
[  5]   5.00-6.00   sec  2.86 GBytes  24.6 Gbits/sec    0   1.50 MBytes       
[  5]   6.00-7.00   sec  2.87 GBytes  24.6 Gbits/sec    0   1.67 MBytes       
[  5]   7.00-8.00   sec  2.87 GBytes  24.6 Gbits/sec    0   1.54 MBytes       
[  5]   8.00-9.00   sec  2.86 GBytes  24.6 Gbits/sec    0   1.50 MBytes       
[  5]   9.00-10.00  sec  2.86 GBytes  24.6 Gbits/sec    0   1.42 MBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  28.7 GBytes  24.6 Gbits/sec    0             sender
[  5]   0.00-10.00  sec  28.7 GBytes  24.6 Gbits/sec                  receiver

iperf Done.
root@pve01:~# iperf3 -B 10.254.255.55 -c 10.254.255.51 -R
Connecting to host 10.254.255.51, port 5201
Reverse mode, remote host 10.254.255.51 is sending
[  5] local 10.254.255.55 port 50893 connected to 10.254.255.51 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  2.85 GBytes  24.5 Gbits/sec                  
[  5]   1.00-2.00   sec  2.80 GBytes  24.0 Gbits/sec                  
[  5]   2.00-3.00   sec  2.88 GBytes  24.8 Gbits/sec                  
[  5]   3.00-4.00   sec  2.22 GBytes  19.0 Gbits/sec                  
[  5]   4.00-5.00   sec  2.51 GBytes  21.5 Gbits/sec                  
[  5]   5.00-6.00   sec  2.83 GBytes  24.3 Gbits/sec                  
[  5]   6.00-7.00   sec  2.56 GBytes  22.0 Gbits/sec                  
[  5]   7.00-8.00   sec  2.82 GBytes  24.2 Gbits/sec                  
[  5]   8.00-9.00   sec  2.43 GBytes  20.9 Gbits/sec                  
[  5]   9.00-10.00  sec  2.35 GBytes  20.2 Gbits/sec                  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  26.2 GBytes  22.5 Gbits/sec    0             sender
[  5]   0.00-10.00  sec  26.2 GBytes  22.5 Gbits/sec                  receiver

iperf Done.
```

~16% CPU when receive
~40% CPU when send

### MTU + Offload

```bash

```
