supervisor:
  pkg.installed:
    - name: supervisor
  service.running:
    - enable: True
    - restart: True

{% for project in pillar['projects'] %}
/etc/supervisor/conf.d/{{ project.name }}-uwsgi.conf:
  file.managed:
    - source: salt://supervisor/config.mako
    - template: mako
    - mode: 600
    - defaults:
        name: {{ project.name }}-uwsgi
        user: {{ project.user }}
        cwd: /home/{{ project.user }}/projects/{{ project.name }}/deploy
        log_path: /home/{{ project.user }}/projects/{{ project.name }}/logs/uwsgi.log
        command: >
          uwsgi
          --disable-logging --chmod --master --processes 1
          --home /home/{{ project.user }}/projects/{{ project.name }}/env
          --wsgi {{ project.name }}.web.wsgi
          --socket /tmp/{{ project.name }}-uwsgi.sock
          --pidfile /tmp/{{ project.name }}-uwsgi.pid
        environment:
          SESSION_SECRET: {{ project.secret }}
          BITCOIND_URL: {{ "http://{rpcuser}:{rpcpassword}@localhost:{rpcport}".format(**pillar['services']['bitcoin']) }}
          REDIS_URL: {{ "redis://{host}:{port}/{databases[projects]}".format(**pillar['services']['redis']) }}
          CELERY_URL: {{ "redis://{host}:{port}/{databases[celery]}".format(**pillar['services']['redis']) }}
    - watch_in:
      - service: supervisor
    - require:
      - pkg: supervisor
      - virtualenv: /home/{{ project.user }}/projects/{{ project.name }}/env
      - cmd: /home/{{ project.user }}/projects/{{ project.name }}/repo
      - file: /home/{{ project.user }}/projects/{{ project.name }}/logs


{% for daemon in project['daemons'] %}
/etc/supervisor/conf.d/{{ project.name }}-{{ daemon.name }}.conf:
  file.managed:
    - source: salt://supervisor/config.mako
    - template: mako
    - mode: 600
    - defaults:
        name: {{ project.name }}-{{ daemon.name }}
        user: {{ project.user }}
        cwd: /home/{{ project.user }}/projects/{{ project.name }}
        log_path: /home/{{ project.user }}/projects/{{ project.name }}/logs/{{ daemon.name }}.log
        command: {{ daemon.command }}
        environment:
    - watch_in:
      - service: supervisor
    - require:
      - pkg: supervisor
      - virtualenv: /home/{{ project.user }}/projects/{{ project.name }}/env
      - cmd: /home/{{ project.user }}/projects/{{ project.name }}/repo
      - file: /home/{{ project.user }}/projects/{{ project.name }}/logs
{% endfor %}

{% endfor %}
