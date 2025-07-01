#!/bin/sh

echo "Running Nextcloud post-deployment configuration..."

# Configure Nextcloud to connect to Valkey with a password.
echo "Setting Valkey password..."
docker exec -it nextcloud sh -c "php occ config:system:set redis password --value=${NEXTCLOUD_VALKEY_PASSWORD}" || {
  echo "ERROR: Failed to set Valkey password."
  exit 1
}

# Configure Nextcloud email settings.
echo "Configuring email settings..."

# SMTP mode.
docker exec -it nextcloud sh -c "php occ config:system:set mail_smtpmode --value=smtp" || {
  echo "ERROR: Failed to set mail_smtpmode."
  exit 1
}

# SMTP host.
docker exec -it nextcloud sh -c "php occ config:system:set mail_smtphost --value=${NEXTCLOUD_SMTP_HOST}" || {
  echo "ERROR: Failed to set mail_smtphost."
  exit 1
}

# SMTP port.
docker exec -it nextcloud sh -c "php occ config:system:set mail_smtpport --value=465" || {
  echo "ERROR: Failed to set mail_smtpport."
  exit 1
}

# SMTP security setting.
docker exec -it nextcloud sh -c "php occ config:system:set mail_smtpsecure --value=ssl" || {
  echo "ERROR: Failed to set mail_smtpsecure."
  exit 1
}

# SMTP auth.
docker exec -it nextcloud sh -c "php occ config:system:set mail_smtpauth --value=true --type=boolean" || {
  echo "ERROR: Failed to set mail_smtpauth."
  exit 1
}

# SMTP auth type.
docker exec -it nextcloud sh -c "php occ config:system:set mail_smtpauthtype --value=LOGIN" || {
  echo "ERROR: Failed to set mail_smtpauthtype."
  exit 1
}

# SMTP name.
docker exec -it nextcloud sh -c "php occ config:system:set mail_smtpname --value=${NEXTCLOUD_SMTP_NAME}" || {
  echo "ERROR: Failed to set mail_smtpname."
  exit 1
}

# SMTP mail from address.
docker exec -it nextcloud sh -c "php occ config:system:set mail_from_address --value=${NEXTCLOUD_MAIL_FROM_ADDRESS}" || {
  echo "ERROR: Failed to set mail_from_address."
  exit 1
}

# SMTP mail domain.
docker exec -it nextcloud sh -c "php occ config:system:set mail_domain --value=${NEXTCLOUD_MAIL_DOMAIN}" || {
  echo "ERROR: Failed to set mail_domain."
  exit 1
}

# SMTP password.
docker exec -it nextcloud sh -c "php occ config:system:set mail_smtppassword --value=${NEXTCLOUD_SMTP_PASSWORD}" || {
  echo "ERROR: Failed to set mail_smtppassword."
  exit 1
}

# Run Mimetype migrations.
echo "Running Mimetype migrations (this may take a while)..."
docker exec -it nextcloud sh -c "php occ maintenance:repair --include-expensive" || {
  echo "WARNING: Failed to run mimetype migrations."
}

# Disable skeleton directory for newly created users.
echo "Disabling Skeleton directory for newly created users..."
docker exec -it nextcloud sh -c "php occ config:system:set skeletondirectory --value=''" || {
  echo "WARNING: Failed to disable skeleton directory."
}

# Set default phone region.
echo "Setting default phone region..."
docker exec -it nextcloud sh -c "php occ config:system:set default_phone_region --value=US" || {
  echo "ERROR: Failed to set default phone region."
  exit 1
}

# Set maintenance window start time (5AM)
echo "Setting maintenance window start time..."
docker exec -it nextcloud sh -c "php occ config:system:set maintenance_window_start --value=5" || {
  echo "ERROR: Failed to set maintenance window start time."
  exit 1
}

echo "Nextcloud post-deployment configuration script finished."
