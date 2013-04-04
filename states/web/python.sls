pillow-deps:
  pkg.installed:
    - names:
      - libfreetype6-dev
      - libjpeg62-dev
      - libpng12-dev
      - libwebp-dev

pillow:
  pip.installed:
    - name: pillow
    - require:
      - pkg: pillow-deps
      - pkg: python

python:
  pkg.installed:
    - names:
      - python-dev
      - python-software-properties
      - python-virtualenv
      - python-pip
      - supervisor
