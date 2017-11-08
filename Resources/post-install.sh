#!/usr/bin/env bash

chown -R $USER:staff /Applications/FoxyExtension/src/foxycli

env

# Add or Skip Model
if ! test -f "/Applications/FoxyExtension/src/foxycli/resources/Hey_Foxy.pmdl"; then
    # It's a clean install
    su $USER -c "cp /Applications/FoxyExtension/src/foxycli/resources/Hey_Foxy.pmdl.default /Applications/FoxyExtension/src/foxycli/resources/Hey_Foxy.pmdl"
fi

# private/tmp/PKInstallSandbox.0UMv1m/Scripts

# Make config.json
if ! test -f "/Applications/FoxyExtension/src/foxycli/config/config.json"; then
    # It's a clean install
    su $USER -c "cp /Applications/FoxyExtension/src/foxycli/config/config.default.json /Applications/FoxyExtension/src/foxycli/config/config.json"
fi

# Start App
cd /Applications/FoxyExtension/src/foxycli
su $USER -c 'PATH="$PATH:/Applications/FoxyExtension/libs/node/bin:/Applications/FoxyExtension/libs/libpng/1.6.34/bin:/Applications/FoxyExtension/libs/mad/0.15.1b/lib:/Applications/FoxyExtension/libs/portaudio/19.6.0/lib:/Applications/FoxyExtension/libs/sox/14.4.2" pm2 kill'
su $USER -c 'PATH="$PATH:/Applications/FoxyExtension/libs/node/bin:/Applications/FoxyExtension/libs/libpng/1.6.34/bin:/Applications/FoxyExtension/libs/mad/0.15.1b/lib:/Applications/FoxyExtension/libs/portaudio/19.6.0/lib:/Applications/FoxyExtension/libs/sox/14.4.2" pm2 start ecosystem.config.js'
su $USER -c 'PATH="$PATH:/Applications/FoxyExtension/libs/node/bin:/Applications/FoxyExtension/libs/libpng/1.6.34/bin:/Applications/FoxyExtension/libs/mad/0.15.1b/lib:/Applications/FoxyExtension/libs/portaudio/19.6.0/lib:/Applications/FoxyExtension/libs/sox/14.4.2" pm2 save'
PATH="$PATH:/Applications/FoxyExtension/libs/node/bin:/Applications/FoxyExtension/libs/libpng/1.6.34/bin:/Applications/FoxyExtension/libs/mad/0.15.1b/lib:/Applications/FoxyExtension/libs/portaudio/19.6.0/lib:/Applications/FoxyExtension/libs/sox/14.4.2" pm2 startup launchd -u $USER --hp $HOME


# Create Native Messaging Hosts
su $USER -c "mkdir -p $HOME/Library/Application\ Support/Mozilla/NativeMessagingHosts"

echo "{" > $HOME/Library/Application\ Support/Mozilla/NativeMessagingHosts/foxycli.json
echo '"name": "foxycli",' >> $HOME/Library/Application\ Support/Mozilla/NativeMessagingHosts/foxycli.json
echo '"description": "Hey Foxy Clinet",' >> $HOME/Library/Application\ Support/Mozilla/NativeMessagingHosts/foxycli.json
echo "\"path\": \"/Applications/FoxyExtension/start.sh\"," >> $HOME/Library/Application\ Support/Mozilla/NativeMessagingHosts/foxycli.json
echo '"type": "stdio",' >> $HOME/Library/Application\ Support/Mozilla/NativeMessagingHosts/foxycli.json
echo '"allowed_extensions": [ "foxycli@example.com" ]' >> $HOME/Library/Application\ Support/Mozilla/NativeMessagingHosts/foxycli.json
echo "}" >> $HOME/Library/Application\ Support/Mozilla/NativeMessagingHosts/foxycli.json

exit 0
