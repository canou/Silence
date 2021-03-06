#!/usr/bin/env bash

if [ "$#" -lt 1 ]; then
    echo "usage: ./scripts/fix-patch.sh <files>"
    exit 1
fi

for file in "$@"; do
    commit=$(echo ${file##*/} | sed 's/.patch$//')
    sed -i -e 's/thoughtcrime\/securesms/smssecure\/smssecure/g' \
           -e 's/org.thoughtcrime.securesms/org.smssecure.smssecure/g' \
           -e 's/org.thoughtcrime.provider.securesms/org.smssecure.provider.smssecure/g' \
           -e 's/org.smssecure.smssecure.util.TextSecure/org.smssecure.smssecure.util.Silence/g' \
           -e 's/org.thoughtcrime.redphone.util/org.smssecure.smssecure.util/g' \
           -e 's/TextSecurePreferences/SilencePreferences/g' \
           -e 's/TextSecureTestCase/SilenceTestCase/g' \
           -e 's/TextSecure.LightNoActionBar/Silence.LightNoActionBar/g' \
           -e 's/TextSecure.LightActionBar/Silence.LightActionBar/g' \
           -e 's/TextSecure.DarkNoActionBar/Silence.DarkNoActionBar/g' \
           -e 's/TextSecure.DarkActionBar/Silence.DarkActionBar/g' \
           -e 's/TextSecure.LightTheme/Silence.LightTheme/g' \
           -e 's/TextSecure.DarkTheme/Silence.DarkTheme/g' \
           -e 's/TextSecure.SubtitleTextStyle/Silence.SubtitleTextStyle/g' \
           -e 's/TextSecure.LightIntroTheme/Silence.LightIntroTheme/g' \
           -e 's/TextSecure.TitleTextStyle/Silence.TitleTextStyle/g' \
           -e 's/queryTextSecureContacts/querySilenceContacts/g' \
           -e 's/@color\/signal/@color\/silence/g' \
           -e 's/@color\/textsecure/@color\/silence/g' \
           -e 's/^[Ff]ixes #/Fixes https:\/\/github.com\/WhisperSystems\/Signal-Android\/issues\//g' \
           -e 's/^[Cc]loses #/Closes https:\/\/github.com\/WhisperSystems\/Signal-Android\/pull\//g' \
           -e 's/^SingleRecipientNotificationBuilder_new_textsecure_message/SingleRecipientNotificationBuilder_new_smssecure_message/g' \
           -e 's/src\/org.smssecure.smssecure.util.SilencePreferences.java/src\/org\/smssecure\/smssecure\/util\/SilencePreferences.java/g' \
           -e "0,/^---/s//\nUpstream commit: https:\/\/github.com\/WhisperSystems\/Signal-Android\/commit\/$commit\n---/" \
           "$file"
done
