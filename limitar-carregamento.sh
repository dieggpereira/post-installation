#!/usr/bin/env bash
atual=$(sudo cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode)
if [ $atual -eq '1' ]; then
    echo -e "\e[1;33mEstava ligado e foi DESLIGADO. \e[0m"
    echo 0 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
else
    echo -e "\e[1;33mEstava desligado e foi LIGADO. \e[0m"
    echo 1 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
fi