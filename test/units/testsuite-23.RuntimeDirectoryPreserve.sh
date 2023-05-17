#!/usr/bin/env bash
# SPDX-License-Identifier: LGPL-2.1-or-later
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh
set -eux
set -o pipefail

# Test RuntimeDirectoryPreserve=yes

at_exit() {
    set +e

    rm -fr /run/hoge /tmp/aaa
}

trap at_exit EXIT

systemd-mount -p RuntimeDirectory=hoge -p RuntimeDirectoryPreserve=yes -t tmpfs tmpfs /tmp/aaa

touch /run/hoge/foo
touch /tmp/aaa/bbb

systemctl restart tmp-aaa.mount

test -e /run/hoge/foo
test ! -e /tmp/aaa/bbb
