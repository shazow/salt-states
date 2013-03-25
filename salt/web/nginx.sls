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


{% for project in pillar['projects'] %}
/etc/nginx/sites-available/{{ site.name }}.conf:
    file.managed:
        - source: salt://web/nginx/site.conf.jinja
        - template: jinja
        - defaults:
            name: {{ site.name }}
            domain: {{ site.domain }}
            access_log: /home/{{ site.user }}/logs/{{ site.name }}/access.log
            root_dir: /home/{{ site.user }}/public_html/{{ site.name }}/
{% endfor %}
