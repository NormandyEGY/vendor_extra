#!/system/bin/sh
# Copyright (c) 2009-2012, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

# Disable qualcomm mpdecision
stop mpdecision

# Enable msm_mpdecision
echo '1' >> /sys/kernel/msm_mpdecision/conf/enabled
echo '0' >> /sys/kernel/msm_mpdecision/conf/boost_enabled
echo '245760' >> /sys/kernel/msm_mpdecision/conf/idle_freq
echo '2' >> /sys/kernel/msm_mpdecision/conf/max_cpus
echo '1' >> /sys/kernel/msm_mpdecision/conf/min_cpus
echo '12' >> /sys/kernel/msm_mpdecision/conf/nwns_threshold_0
echo '0' >> /sys/kernel/msm_mpdecision/conf/nwns_threshold_1
echo '1' >> /sys/kernel/msm_mpdecision/conf/scroff_single_core
echo '140' >> /sys/kernel/msm_mpdecision/conf/twts_threshold_0
echo '0' >> /sys/kernel/msm_mpdecision/conf/twts_threshold_1

# CPU frequency
echo 'interactive' >> /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 'interactive' >> /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo '1008000' >> /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo '245760' >> /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo '480000' >> /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
echo '40000' >> /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
echo '20000' >> /sys/devices/system/cpu/cpufreq/interactive/timer_rate

# GPU frequency
echo '300000000' >> /sys/devices/platform/kgsl-3d0.0/kgsl/kgsl-3d0/gpuclk
echo '300000000' >> /sys/devices/platform/kgsl-3d0.0/kgsl/kgsl-3d0/max_gpuclk

# Readahead
echo '2048' >> /sys/devices/virtual/bdi/default/read_ahead_kb

chown system /sys/devices/platform/rs300000a7.65536/force_sync
chown system /sys/devices/platform/rs300000a7.65536/sync_sts
chown system /sys/devices/platform/rs300100a7.65536/force_sync
chown system /sys/devices/platform/rs300100a7.65536/sync_sts

echo '5' >> /sys/devices/platform/msm_sdcc.1/idle_timeout

# Enable Power modes and set the CPU Freq Sampling rates
start qosmgrd
echo '1' >> /sys/module/pm2/modes/cpu0/standalone_power_collapse/idle_enabled
echo '1' >> /sys/module/pm2/modes/cpu1/standalone_power_collapse/idle_enabled
echo '1' >> /sys/module/pm2/modes/cpu0/standalone_power_collapse/suspend_enabled
echo '1' >> /sys/module/pm2/modes/cpu1/standalone_power_collapse/suspend_enabled
# SuspendPC:
echo '1' >> /sys/module/pm2/modes/cpu0/power_collapse/suspend_enabled
# IdlePC:
echo '1' >> /sys/module/pm2/modes/cpu0/power_collapse/idle_enabled

# Start thermal daemon.
start thermald

# Change adj level and min_free_kbytes setting for lowmemory killer to kick in.
echo '0,2,3,5,7,9' >> /sys/module/lowmemorykiller/parameters/adj
echo '4075,5437,6799,8847,11520,15360' >> /sys/module/lowmemorykiller/parameters/minfree

# Network tweaks.
sysctl -e -w net.ipv4.tcp_timestamps=0
sysctl -e -w net.ipv4.tcp_tw_reuse=1
sysctl -e -w net.ipv4.tcp_tw_recycle=1
sysctl -e -w net.ipv4.tcp_sack=1
sysctl -e -w net.ipv4.tcp_window_scaling=1
sysctl -e -w net.ipv4.tcp_keepalive_probes=5
sysctl -e -w net.ipv4.tcp_ecn=0
sysctl -e -w net.ipv4.tcp_max_tw_buckets=360000
sysctl -e -w net.ipv4.tcp_synack_retries=2
sysctl -e -w net.ipv4.route.flush=1
sysctl -e -w net.ipv4.icmp_echo_ignore_all=1
sysctl -e -w net.ipv4.conf.all.rp_filter=1
sysctl -e -w net.ipv4.tcp_synack_retries=2
sysctl -e -w net.ipv4.tcp_syn_retries=2
sysctl -e -w net.ipv4.tcp_no_metrics_save=1
sysctl -e -w net.ipv4.tcp_fin_timeout=15
sysctl -e -w net.ipv4.tcp_keepalive_intvl=60
sysctl -e -w net.ipv4.tcp_keepalive_time=1800
sysctl -e -w net.ipv4.tcp_ecn=1
sysctl -e -w net.ipv4.conf.all.secure_redirects=0
sysctl -e -w net.ipv4.conf.default.secure_redirects=0
sysctl -e -w net.core.bpf_jit_enable=1
sysctl -e -w net.core.wmem_max=25600
sysctl -e -w net.core.rmem_max=25600
sysctl -e -w net.core.rmem_default=25600
sysctl -e -w net.core.wmem_default=25600

# Various kernel memory settings.
sysctl -e -w fs.nr_open=1053696
sysctl -e -w fs.inotify.max_queued_events=32000
sysctl -e -w fs.inotify.max_user_instances=256
sysctl -e -w fs.inotify.max_user_watches=10240
sysctl -e -w kernel.msgmni=2048
sysctl -e -w kernel.msgmax=64000
sysctl -e -w kernel.shmmni=4096
sysctl -e -w kernel.shmall=2097152
sysctl -e -w kernel.shmmax=268435456
sysctl -e -w kernel.sched_latency_ns=18000000
sysctl -e -w kernel.sched_min_granularity_ns=1500000
sysctl -e -w kernel.sched_wakeup_granularity_ns=3000000
sysctl -e -w kernel.sched_shares_ratelimit=256000
sysctl -e -w kernel.threads-max=10000
sysctl -e -w fs.file-max=65536
sysctl -e -w fs.lease-break-time=10
sysctl -e -w vm.dirty_ratio=70
sysctl -e -w vm.dirty_background_ratio=50
sysctl -e -w vm.vfs_cache_pressure=101
sysctl -e -w vm.oom_kill_allocating_task=0
sysctl -e -w vm.dirty_expire_centisecs=2000
sysctl -e -w vm.dirty_writeback_centisecs=1000
sysctl -e -w vm.panic_on_oom=0
sysctl -e -w vm.overcommit_memory=1
sysctl -e -w vm.overcommit_ratio=40
sysctl -e -w vm.swappiness=70
sysctl -e -w vm.min_free_kbytes=4096
sysctl -e -w kernel.panic_on_oops=0
sysctl -e -w kernel.panic=0
sysctl -e -w kernel.sched_compat_yield=1
sysctl -e -w kernel.sched_child_runs_first=0
sysctl -e -w kernel.random.read_wakeup_threshold=1024
sysctl -e -w kernel.random.write_wakeup_threshold=2048

# Activate zram.
echo "$((125 * 1024 * 1024))" >> /sys/block/zram0/disksize
mkswap /dev/block/zram0
swapon /dev/block/zram0

## Sysinit start.
# Remount system as rw.
mount -o remount,rw /system
# Create init.d dir if it doesn't exist yet.
mkdir -p /system/etc/init.d
# Fixing permissions.
chown root.root /system/etc/init.d
chown root.root /system/etc/init.d/*
chmod 644 /system/etc/init.d
chmod 744 /system/etc/init.d/*
# Export path.
export PATH=/sbin:/system/sbin:/system/bin:/system/xbin
# Run sysinit on init.d dir.
/system/bin/logwrapper busybox run-parts /system/etc/init.d
# Remount system as ro.
mount -o remount,ro /system
## Sysinit end.
