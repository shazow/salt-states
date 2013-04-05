supervisor:
  pkg.installed:
    - name: supervisor
  service.running:
    - enable: True

{% for project in pillar['projects'] %}
/etc/supervisor/conf.d/{{ project.name}}.conf:
  file.managed:
    - source: salt://project/supervisor.conf.jinja
    - template: jinja
    - defaults:
        name: {{ project.name }}
        user: {{ project.user }}
        deploy_path: /home/{{ project.user }}/projects/{{ project.name }}/deploy
        virtualenv_path: /home/{{ project.user }}/projects/{{ project.name }}/env
        log_path: /home/{{ project.user }}/projects/{{ project.name }}/logs/uwsgi.log
    - watch_in:
      - service: supervisor
    - require:
      - pkg: supervisor
      - virtualenv: /home/{{ project.user }}/projects/{{ project.name }}/env
      - cmd: /home/{{ project.user }}/projects/{{ project.name }}/repo
      - directory: /home/{{ project.user }}/projects/{{ project.name }}/logs
{% endfor %}
