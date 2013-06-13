nginx:
  pkg.installed:
    - name: nginx
  service.running:
    - enable: True
    - reload: True

/etc/nginx/sites-enabled/default:
  file.absent

{% for project in pillar['projects'] %}
/etc/nginx/sites-available/{{ project.name }}:
  file.managed:
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx
    - source: salt://web/nginx/site.conf.jinja
    - template: jinja
    - defaults:
        name: {{ project.name }}
        domain: {{ project.domain }}
        access_log: /home/{{ project.user }}/logs/{{ project.name }}/access.log
        root_dir: /home/{{ project.user }}/public_html/{{ project.name }}

/etc/nginx/sites-enabled/{{ project.name }}:
  file.symlink:
    - target: /etc/nginx/sites-available/{{ project.name }}
{% endfor %}
