#!/usr/bin/env bash
atual=$(sudo cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode)
if [ $atual -eq '1' ]; then
    echo "Estava ligado e foi DESLIGADO."
    echo 0 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
else
    echo "Estava desligado e foi LIGADO."
    echo 1 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
fi