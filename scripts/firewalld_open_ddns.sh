#!/bin/bash
# Update the firewalld public zone to allow access to a local machine with Dynamic DNS
set -eo pipefail

REMOTE_HOST=$1
LOCAL_PORT=$2

uname | grep -i linux > /dev/null || { echo "This script is only intended for Linux"; exit 1; }
[[ -z "$REMOTE_HOST" ]] && echo "Please provide a remote host" && exit 1

# Check if firewalld is enabled
sudo systemctl status firewalld > /dev/null
echo -n "Firewalld status: " && sudo firewall-cmd --state
echo "[$(date)] Opening port $LOCAL_PORT for $REMOTE_HOST"

# Get current IP address
CURRENT_IP=$(dig -4 +short "$REMOTE_HOST" | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}')
if [[ -z "$CURRENT_IP" ]]; then
  echo "Unable to resolve $REMOTE_HOST"
  exit 1
fi
echo "Current IP: $CURRENT_IP"

# Get old IP address
if [[ -z "$LOCAL_PORT" ]]; then
  RULE_LIST=$(sudo firewall-cmd --zone=public --list-rich-rules || true)
  if [[ -z "$RULE_LIST" ]]; then
    echo "No existing rules found and no port provided"
    exit 1
  fi
  LOCAL_PORT=$(echo "$RULE_LIST" | grep -oE 'port port=\"[0-9]{1,5}\"' | grep -oE '[0-9]{1,5}')
else
  RULE_LIST=$(sudo firewall-cmd --zone=public --list-rich-rules | grep "$LOCAL_PORT" || true)
fi

if [[ -z "$RULE_LIST" ]]; then
  echo "No existing rules found"
elif [[ $(echo "$RULE_LIST" | wc -l) -gt 1 ]]; then
  echo "Multiple rules found"
  exit 1
else
  echo "Existing rule: $RULE_LIST"
  OLD_IP=$(echo "$RULE_LIST" | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}')
  echo "Old IP: $OLD_IP"

  if [[ "$OLD_IP" == "$CURRENT_IP" ]]; then
    echo "IP address has not changed"
    exit 0
  fi

  echo -n "Deleting old rule: "
  sudo firewall-cmd --permanent --zone=public --remove-rich-rule='rule family="ipv4" source address="'"$OLD_IP"'/32" port port="'"$LOCAL_PORT"'" protocol="tcp" accept'
fi

echo -n "Adding new rule: "
sudo firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="'"$CURRENT_IP"'/32" port port="'"$LOCAL_PORT"'" protocol="tcp" accept'

# Reload firewalld
sudo firewall-cmd --reload
sudo firewall-cmd --zone=public --list-rich-rules
echo "[$(date)] Done"
