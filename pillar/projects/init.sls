projects:
  - name: coinhooks
    domain: staging.coinhooks.com
    user: deploy
    group: www-data
    secret: CHANGETHISSECRET
    daemons:
      - name: celery
        command: env/bin/pceleryd deploy/production.ini --concurrency=1
