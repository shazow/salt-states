packages:
  pkg.installed:
    - names:
      - build-essential
      - cron
      - curl
      - fail2ban
      - git
      - htop
      - logrotate
      - lsof
      - mailutils
      - net-tools
      - netcat
      - ntp
      - tmux
      - vim


/etc/iptables.firewall.rules:
  file.managed:
    - source: salt://common/iptables.firewall.rules
    - require:
      - pkg: iptables
