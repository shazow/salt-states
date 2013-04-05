{% for project in pillar['projects'] %}
{{ project.user }}:
  user.present:
    - home: /home/{{ project.user }}
    - gid: {{ project.group }}

/home/{{ project.user }}:
  file.directory:
    - user: {{ project.user }}
    - group: {{ project.group }}
    - mode: 750
    - makedirs: True
    - require:
      - user: {{ project.user }}

/home/{{ project.user }}/.ssh:
  file.directory:
    - user: {{ project.user }}
    - group: {{ project.group }}
    - mode: 700
    - makedirs: True
    - require:
      - file: /home/{{ project.user }}

/home/{{ project.user }}/projects/{{ project.name }}:
  file.directory:
    - user: {{ project.user }}
    - group: {{ project.group }}
    - mode: 750
    - makedirs: True
    - require:
      - user: {{ project.user }}

{% for directory in ['logs'] %}
/home/{{ project.user }}/projects/{{ project.name }}/{{ directory }}:
  file.directory:
    - user: {{ project.user }}
    - group: {{ project.group }}
    - mode: 750
    - makedirs: True
    - require:
      - file: /home/{{ project.user }}/projects/{{ project.name }}
{% endfor %}

/home/{{ project.user }}/projects/{{ project.name }}/repo:
  cmd.run:
    - name: git init --separate-git-dir=repo deploy
    - unless: ls /home/{{ project.user }}/{{ project.name }}/repo/config
    - user: {{ project.user }}
    - group: {{ project.group }}
    - cwd: /home/{{ project.user }}/projects/{{ project.name }}
    - shell: /bin/bash
    - require:
      - pkg: git
      - file: /home/{{ project.user }}/projects/{{ project.name }}

/home/{{ project.user }}/projects/{{ project.name }}/repo/hooks/post-receive:
  file.managed:
    - source: salt://project/post-receive.jinja
    - template: jinja
    - user: {{ project.user }}
    - group: {{ project.group }}
    - mode: 750
    - defaults:
        name: {{ project.name }}
        virtualenv_path: /home/{{ project.user }}/projects/{{ project.name }}/env
    - require:
      - cmd: /home/{{ project.user }}/projects/{{ project.name }}/repo
      - pkg: uwsgi
{%- endif %}

{% endfor %}
