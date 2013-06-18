pillow-deps:
  pkg.installed:
    - names:
      - libfreetype6-dev
      - libjpeg62-dev
      - libpng12-dev
      - libwebp-dev

pillow:
  pip.installed:
    - require:
      - pkg: pillow-deps
      - pkg: python

python:
  pkg.installed:
    - names:
      - python
      - python-dev
      - python-software-properties
      - python-virtualenv
      - python-pip
      - python-mako
