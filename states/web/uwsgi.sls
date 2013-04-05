uwsgi:
  pkgrepo.managed:
    - ppa: uwsgi/release
    - require_in:
      - pkg: uwsgi
  pkg.installed:
    - name: uwsgi
