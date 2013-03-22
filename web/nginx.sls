# More good stuff here: https://github.com/oc/roninku/tree/master/states/nginx
nginx:
    pkg.installed:
        - name: nginx
    service.running:
        - enable: True

default-nginx:
    file.absent:
            - name: /etc/nginx/sites-enabled/default
