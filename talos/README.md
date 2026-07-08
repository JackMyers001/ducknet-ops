# talos

I manage my Talos nodes with [Sidero Omni], so these config files are manually applied through Omni's web UI.

[Sidero Omni]: https://www.siderolabs.com/omni

When creating the Talos installation media in Omni, I need to select "Tunnel Omni management traffic over HTTP/2" to allow SideroLink to connect to Omni in an IPv6-only environment.

## Extensions

### `talos01`

- `siderolabs/amd-ucode`
- `siderolabs/amdgpu`

### `talos02`

- `siderolabs/i915`
- `siderolabs/intel-ucode`

### `talos03`

- `siderolabs/i915`
- `siderolabs/intel-ucode`

## Kernel Args

### `talos01`

> [!NOTE]
> I did a _lot_ of benchmarking and found that `spec_rstack_overflow` and `tsa` dramatically improved `fio` performance (specifically IOPS). These flags are likely only applicable to Zen ~1-4 CPUs

- `amd_pstate=active`
- `iommu=pt`
- `spec_rstack_overflow=microcode`
- `tsa=vm`

### `talos02`

- `iommu=pt`

### `talos03

- `iommu=pt`
