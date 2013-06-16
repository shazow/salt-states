projects:
  - name: coinhooks
    domain: staging.coinhooks.com
    user: deploy
    group: www-data
    secret: CHANGETHISSECRET
    daemons:
      - name: celery
        command: /home/deploy/projects/coinhooks/env/bin/pceleryd /home/deploy/projects/coinhooks/deploy/production.ini --concurrency=1
