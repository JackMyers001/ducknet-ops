# Benchmark results

## OG

```
=========================
FIO Benchmark Summary
For: test_device
CPU Idleness Profiling: disabled
Size: 30G
Quick Mode: disabled
=========================
IOPS (Read/Write)
        Random:             61,058 / 475
    Sequential:             14,561 / 599

Bandwidth in KiB/sec (Read/Write)
        Random:       1,258,057 / 52,123
    Sequential:       1,255,698 / 63,596


Latency in ns (Read/Write)
        Random:     131,410 / 15,581,191
    Sequential:     100,917 / 15,661,929
```

## 25GbE + 980 PRO + 2x write-through

```
=========================
FIO Benchmark Summary
For: test_device
CPU Idleness Profiling: disabled
Size: 30G
Quick Mode: disabled
=========================
IOPS (Read/Write)
        Random:           79,671 / 3,838
    Sequential:             17,445 / 624

Bandwidth in KiB/sec (Read/Write)
        Random:       1,269,803 / 60,538
    Sequential:       1,328,064 / 74,988


Latency in ns (Read/Write)
        Random:     126,064 / 59,772,218
    Sequential:     124,832 / 60,121,512
```

## 25GbE + Erying

```
=========================
FIO Benchmark Summary
For: test_device
CPU Idleness Profiling: disabled
Size: 30G
Quick Mode: disabled
=========================
IOPS (Read/Write)
        Random:           80,363 / 4,360
    Sequential:             15,043 / 868

Bandwidth in KiB/sec (Read/Write)
        Random:      1,243,876 / 158,610
    Sequential:      1,294,732 / 154,233


Latency in ns (Read/Write)
        Random:     129,305 / 53,204,423
    Sequential:      98,033 / 46,000,887
```

## 25GbE + Erying + No pve Cache

```
=========================
FIO Benchmark Summary
For: test_device
CPU Idleness Profiling: disabled
Size: 30G
Quick Mode: disabled
=========================
IOPS (Read/Write)
        Random:             78,926 / 439
    Sequential:             14,328 / 716

Bandwidth in KiB/sec (Read/Write)
        Random:      1,249,840 / 130,370
    Sequential:      1,309,645 / 171,507


Latency in ns (Read/Write)
        Random:     137,767 / 15,553,690
    Sequential:      98,362 / 15,658,300
```


```
=========================
FIO Benchmark Summary
For: test_device
CPU Idleness Profiling: disabled
Size: 30G
Quick Mode: disabled
=========================
IOPS (Read/Write)
        Random:             86,978 / 481
    Sequential:             17,945 / 540

Bandwidth in KiB/sec (Read/Write)
        Random:      1,290,980 / 215,678
    Sequential:      1,272,559 / 159,392


Latency in ns (Read/Write)
        Random:     131,279 / 66,745,952
    Sequential:      90,400 / 15,496,548
```


## 25GbE REAL + erying + no pve cache

```
=========================
FIO Benchmark Summary
For: test_device
CPU Idleness Profiling: disabled
Size: 30G
Quick Mode: disabled
=========================
IOPS (Read/Write)
        Random:             75,200 / 426
    Sequential:             14,924 / 579

Bandwidth in KiB/sec (Read/Write)
        Random:       1,209,532 / 54,663
    Sequential:      1,264,497 / 228,454


Latency in ns (Read/Write)
        Random:     141,683 / 15,530,488
    Sequential:      92,347 / 15,603,715
```
