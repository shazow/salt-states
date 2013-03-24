# More good stuff here: https://github.com/oc/roninku/tree/master/states/nginx
nginx:
    pkg.installed:
        - name: nginx
    service.running:
        - enable: True


nginx:
    service.running:
        - enable: True
        - reload: True
        - watch:
            - file: /etc/nginx/nginx.conf
            - file: /etc/nginx/sites-enabled/*
            - pkg: nginx


/etc/nginx/sites-enabled/default:
    file.absent
