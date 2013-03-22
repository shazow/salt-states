pil-deps:
    pkg.installed:
        - names:
            - libfreetype6-dev
            - libjpeg62-dev
            - libpng12-dev

pil:
    pip.installed
        - pkgs: PIL
        - require:
            - pkg: pil-deps
            - pkg: python

python:
    pkg.installed:
        - names:
            - python-dev
            - python-software-properties
            - python-virtualenv
            - python-pip
            - supervisor


{% for lib in ['libfreetype.so','libz.so','libjpeg.so'] %}
/usr/lib/i386-linux-gnu/{{ lib }}:
    file:
        - symlink
        - target: /usr/lib/{{ lib }}
        - require:
            - pkg: libjpeg62-dev
        - require_in:
            - pkg: pil
{% endfor %}
