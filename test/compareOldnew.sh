#!/bin/sh

set -eu

Old=${Old:-/usr/local/bin/yasql.orig}
New=${New:-../yasql.in}

DoOne () {

    local Script="$1"

    if [ '!' -x "$Script" ]; then
       printf "File '%s' is missing or not executable\n" "$Script"
       return
    fi

    local Dname=$(dirname "$Script")
    local Bname=$(basename "$Script")
    local BnameNet=$(basename "$Script" .sh)

    if [ x"$Dname" = x'.' ]; then
        Script="./$Bname"
    fi

    local OldLog="$BnameNet.old.log"
    local NewLog="$BnameNet.new.log"

    printf "running '%s' with Old='%s'\n" "$Script" "$Old"
    (set +eu; YaSql="$Old" "$Script" &>"$OldLog"; true)

    printf "running '%s' with New='%s'\n" "$Script" "$New"
    (set +eu; YaSql="$New" "$Script" &>"$NewLog"; true)

    if cmp &>/dev/null "$OldLog" "$NewLog"; then
        printf "log-files '%s' and '%s' are equals\n" "$OldLog" "$NewLog"
    else
        printf "log-files '%s' and '%s' differ\n" "$OldLog" "$NewLog"
        printf "LC_ALL=C diff -u -- '%s' '%s'\n" "$OldLog" "$NewLog"
    fi
}

for i in "$@"; do
    DoOne "$i"
done
