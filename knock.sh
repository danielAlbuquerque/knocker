#!/bin/bash

usage() {
echo "+--------------------------+"
echo "+      port knocker        +"
echo "+--------------------------+"
echo ""
echo "Usage: ./knock <ip address>"
echo ""
exit 1
}

if [[ ($# == "--help") || $# == "-h" ]]; then
    usage
fi
if [[ $# -eq 0 ]]; then
    usage
fi

## Main
ipaddr="${1}"
for port in '8283:tcp' '1482:udp' '5283:tcp' '1817:tcp'; do {
    echo "${port}"
    proto="$(awk -F: '{print $2}' <<< "${port}")"
    port="$(awk -F: '{print $1}' <<< "${port}")"
    case "${proto}" in
        "tcp") nc "${ipaddr}" "${port}"
            ;;
        "udp") echo close | nc "${ipaddr}" -u "${port}"
            ;;
        *) echo "Failed: Invalid Protocol"
    esac
}
done
