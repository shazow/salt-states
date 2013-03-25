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

/home/{{ project.user }}/logs/{{ project.name }}:
    file.directory:
        - user: {{ project.user }}
        - group: {{ project.group }}
        - mode: 750
        - makedirs: True
        - require:
            - file: /home/{{ project.user }}
{% endfor %}
