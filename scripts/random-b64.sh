#!/bin/sh

# Generates a Base64 string.
openssl rand -base64 64 | tr -d "\n"
