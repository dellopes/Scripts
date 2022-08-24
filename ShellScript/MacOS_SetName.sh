#!/usr/bin/env bash
# Get the Serial Number of the Machine
sn=$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}')
# Set the ComputerName, HostName and LocalHostName
scutil --set ComputerName "XX-X-XX-"$sn
scutil --set HostName "XX-X-XX-"$sn
scutil --set LocalHostName "XX-X-XX-"$sn