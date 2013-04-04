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

/home/{{ project.user }}/projects/{{ project.name }}/repo/.git:
  cmd.run:
    - name: git init --separate-git-dir=repo deploy
    - unless: ls /home/{{ project.user }}/{{ project.name }}/repo/.git
    - user: {{ project.user }}
    - group: {{ project.group }}
    - cwd: /home/{{ project.user }}/projects/{{ project.name }}
    - shell: /bin/bash
    - require:
      - pkg: git
      - file: /home/{{ project.user }}/projects/{{ project.name }}
{% endfor %}
