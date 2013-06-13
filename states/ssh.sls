keys:
  ssh_auth:
    - present
    - user: root
    - enc: ssh-rsa
    - names:
{% for ssh_key in pillar['ssh_pub_keys'] %}
      - {{ ssh_key }}
{% endfor %}
