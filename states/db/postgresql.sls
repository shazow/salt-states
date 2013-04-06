postgresql-repo:
  pkgrepo.managed:
    - human_name: ppa:pitti/postgresql
    - ppa: pitti/postgresql

postgresql:
  pkg.installed:
    - names:
      - postgresql-common
      - postgresql-9.2
      - postgresql-server-dev-9.2
      - python-psycopg2
    - require:
      - pkgrepo: postgresql-repo
