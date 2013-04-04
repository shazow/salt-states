postgresql-repo:
  pkgrepo.managed:
    - human_name: ppa:pitti/postgresql
    - ppa: uwsgi/release


postgresql:
  pkg.installed:
    - names:
      - postgresql-common
      - postgresql-9.2
      - postgresql-server-dev-9.2
      - python-psycopg2
    - require:
      - pkgrepo: postgresql-repo
