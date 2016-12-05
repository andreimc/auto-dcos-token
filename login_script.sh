#!/usr/bin/env expect -f
set timeout 10
set dcos_token [lindex $argv 0 0]
spawn dcos auth login
expect "Enter OpenID Connect ID Token:"
send "$dcos_token\n"
expect eof
