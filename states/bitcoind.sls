bitcoin-repo:
  pkgrepo.managed:
    - human_name: ppa:bitcoin/bitcoin
    - ppa: bitcoin/bitcoin
    - keyid: 0E27C0A6
    - keyserver: keyserver.ubuntu.com

bitcoind:
  pkg.installed:
    - names:
      - bitcoind
    - require:
      - pkgrepo: bitcoin-repo

bitcoin:
  user.present:
    - home: /home/bitcoin
    - shell: /bin/bash
    - groups:
      - www-data # Group membership for executing hooks defined by www-data users.

/home/bitcoin:
  file.directory:
    - user: bitcoin
    - group: bitcoin
    - mode: 750
    - makedirs: True
    - require:
      - user: bitcoin

/home/bitcoin/.bitcoin:
  file.directory:
    - user: bitcoin
    - group: bitcoin
    - mode: 750
    - makedirs: True
    - require:
      - user: bitcoin
      - file: /home/bitcoin

/home/bitcoin/.bitcoin/bitcoin.conf:
  file.managed:
    - source: salt://bitcoind/bitcoin.conf.jinja
    - user: bitcoin
    - group: bitcoin
    - mode: 600
    - template: jinja
    - defaults:
        testnet: {{ pillar['services']['bitcoin']['testnet'] }}
        rpcuser: {{ pillar['services']['bitcoin']['rpcuser'] }}
        rpcport: {{ pillar['services']['bitcoin']['rpcport'] }}
        walletnotify: {{ pillar['services']['bitcoin']['walletnotify'] }}
        rpcpassword: {{ pillar['services']['bitcoin']['rpcpassword'] }}
        admin_email: {{ pillar['admin_email'] }}

/home/bitcoin/logs:
  file.directory:
    - user: bitcoin
    - group: bitcoin
    - mode: 750
    - makedirs: True
    - require:
      - file: /home/bitcoin

/etc/init/bitcoind.conf:
  file.managed:
    - source: salt://bitcoind/init.conf.jinja
    - template: jinja
    - mode: 600

/etc/supervisor/conf.d/bitcoind.conf:
  file.managed:
    - source: salt://supervisor/config.mako
    - template: mako
    - defaults:
        name: bitcoind
        user: bitcoin
        cwd: /home/bitcoin
        log_path: /home/bitcoin/logs/bitcoind.log
        command: bitcoind
        environment:
          USER: bitcoin
          HOME: /home/bitcoin
    - watch_in:
      - service: supervisor
    - require:
      - pkg: supervisor
      - file: /home/bitcoin/logs
