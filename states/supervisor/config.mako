[program:${name}]
directory=${cwd}
user=${user}

environment=${','.join("%s='%s'" % (k, v) for k, v in environment.iteritems())}
command=${command}

stdout_logfile=${log_path}
redirect_stderr=true
stopsignal=INT
autorestart=true
