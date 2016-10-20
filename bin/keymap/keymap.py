#!/usr/bin/env python3

import os
import os.path
import re
import subprocess
import sys

from pprint import pprint

SETXKBMAP_ARGS = {
        'us': ('us', '-variant', 'intl'),
        'dvorak': ('us', '-variant', 'dvorak-intl'),
        'ru': ('ru', 'phonetic', '-variant', ',winkeys'),
        }

MAPS = ['us', 'dvorak', 'ru']

re_setxkbmap_query = re.compile(r'^(\w+):\s*(.*)$')

def get_mru_file():
    path = os.environ.get('XDG_CONFIG_HOME')
    if path is None:
        path = os.path.expanduser('~/.config')
    path = os.path.join(path, 'keymap_mru')
    if not os.path.isfile(path):
        open(path, 'a').close()
    return path

def get_mru():
    with open(get_mru_file(), 'r') as f:
        mru = f.read().strip()
        if len(mru) == 0:
            mru = get_current_map_key()
        return mru

def set_mru(m=None):
    if m is None:
        m = get_current_map_key()
    with open(get_mru_file(), 'w') as f:
        f.write(m)

def get_current_map():
    output = subprocess.check_output(('setxkbmap', '-query')).decode('utf-8')
    m = {}
    for line in output.split("\n"):
        match = re_setxkbmap_query.match(line)
        if match is not None:
            m[match.group(1)] = match.group(2)
    return m

def get_index():
    return MAPS.index(get_current_map_key())

def map_index_step(step):
    return (get_index() + step) % len(MAPS)

def get_next_map():
    return MAPS[map_index_step(1)]

def get_prev_map():
    return MAPS[map_index_step(-1)]

def set_map(m):
    set_mru()
    args = ['setxkbmap']
    if m in SETXKBMAP_ARGS:
        args.extend(SETXKBMAP_ARGS[m])
    else:
        args.append(m)
    subprocess.call(args)
    if m == 'us':
        subprocess.call(('xmodmap', os.path.expanduser('~/.xmodmap')))

def get_current_map_key():
    m = get_current_map()
    if m['layout'] == 'us' and 'variant' in m and m['variant'] == 'dvorak-intl':
        return 'dvorak' # ugly special case hack
    else:
        return m['layout']

def print_current_layout():
    print(get_current_map_key())

if __name__ == '__main__':
    if len(sys.argv) == 2:
        command = sys.argv[1]
        if command == 'prev':
            set_map(get_prev_map())
            print_current_layout()
        elif command == 'next':
            set_map(get_next_map())
            print_current_layout()
        elif command == 'list':
            print(' '.join(MAPS))
        elif command == 'mru':
            set_map(get_mru())
        elif command == 'current':
            print_current_layout()
        else:
            m = sys.argv[1]
            if m not in MAPS:
                print("Invalid map '{0}'. Valid options are: {1}".format(m, ' '.join(MAPS)), file=sys.stderr)
                sys.exit(1)
            set_map(m)
            print_current_layout()
    else:
        print("usage: {0} [prev|next|mru|list|current|$map]".format(sys.argv[0]), file=sys.stderr)
        sys.exit(1)
