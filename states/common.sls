packages:
  pkg.installed:
    - names:
      - build-essential
      - cron
      - curl
      - fail2ban
      - git
      - htop
      - iptables
      - logrotate
      - lsof
      - mailutils
      - net-tools
      - netcat
      - ntp
      - tmux
      - vim


/etc/iptables.rules:
  file.managed:
    - source: salt://common/iptables.rules
    - require:
      - pkg: iptables
  cmd.wait:
    - name: iptables-restore < /etc/iptables.rules
    - watch:
      - file: /etc/iptables.rules
    - require:
      - pkg: iptables


/etc/network/if-pre-up.d/firewall:
  file.managed:
    - source: salt://common/iptables_restore
    - mode: 755
    - require:
      - file: /etc/iptables.rules
