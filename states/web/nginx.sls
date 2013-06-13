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
        access_log: /home/{{ project.user }}/{{ project.name }}/logs/access.log
        root_dir: /home/{{ project.user }}/{{ project.name }}/public_html

/etc/nginx/sites-enabled/{{ project.name }}:
  file.symlink:
    - target: /etc/nginx/sites-available/{{ project.name }}
{% endfor %}
