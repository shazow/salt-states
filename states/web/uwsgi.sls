uwsgi-repo:
  pkgrepo.managed:
    - human_name: ppa:uwsgi/release
    - ppa: uwsgi/release


uwsgi:
  pkg.installed:
    - name: uwsgi
    - require:
      - pkgrepo: uwsgi-repo
