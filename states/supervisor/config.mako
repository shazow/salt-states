[program:${name}]
directory=${cwd}
user=${user}

environment=${','.join('='.join(kv) for kv in environment.iteritems())}
command=${command}

stdout_logfile=${log_path}
redirect_stderr=true
stopsignal=INT
autorestart=true
