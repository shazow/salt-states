# salt-states

My lovely salty salt states.

Based on [https://gist.github.com/shazow/1210041](https://gist.github.com/shazow/1210041).


## Quickstart

Fire up your machine and...

1. [Install Salt](http://docs.saltstack.com/topics/installation/index.html) and Mako (because we use a Mako templates for some things):
   `sudo aptitude install salt-minion python-mako`

2. Clone the Salt States: `git clone https://github.com/shazow/salt-states`

3. Apply the Salt States:
   `sudo salt-call --local -c ./salt-states state.highstate`

This is the quick-and-dirty "local" mode. Can also be done in the more scaleable
[master-minion setup](http://docs.saltstack.com/ref/configuration/minion.html).
