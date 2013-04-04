nginx:
  pkg:
    - installed
  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - watch:
      - file: /etc/nginx/nginx.conf
      - file: /etc/nginx/sites-enabled/* # FIXME: This doesn't work?


/etc/nginx/sites-enabled/default:
  file.absent


{% for project in pillar['projects'] %}
/etc/nginx/sites-available/{{ project.name }}:
  file.managed:
    - source: salt://web/nginx/site.conf.jinja
    - template: jinja
    - defaults:
      name: {{ project.name }}
      domain: {{ project.domain }}
      access_log: /home/{{ project.user }}/logs/{{ project.name }}/access.log
      root_dir: /home/{{ project.user }}/public_html/{{ project.name }}/
{% endfor %}
