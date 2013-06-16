admin_email: shazow@gmail.com

ssh_pub_keys:
  - "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAoSE8NlrU1T7ieTdq0ajMWISa7XX08VsxpXjJYUWVTORjzBSIjWDkGUs9d9/Q0FfvUhgXYOl7UfnvMoSMEtgrMfdy1qnMF0ZfmZQOLwAxyBdxaNhBvfkYsz1oD2oDDoY3hrY2lP0Ii38Nd1/Zn+P9CMu8mLLceDfY92K8T0/iNy70iuJvvObCLh5q1XU1cU2qErPskrhPNI5s/A/+CdTVqTfGhU2//B9xPNTzb8N5ixEv/i9j0YEH80vR82eHk6lT9cIyhHlzr9CDln8lnysrnbg6qtpEr+1RGvgK4t4H/SgbV2GEUngHnV9jpokdUs4pjvx+r96YmnEPqy10ElpBvQ== shazow@shazowic-beast"
  - "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAoSE8NlrU1T7ieTdq0ajMWISa7XX08VsxpXjJYUWVTORjzBSIjWDkGUs9d9/Q0FfvUhgXYOl7UfnvMoSMEtgrMfdy1qnMF0ZfmZQOLwAxyBdxaNhBvfkYsz1oD2oDDoY3hrY2lP0Ii38Nd1/Zn+P9CMu8mLLceDfY92K8T0/iNy70iuJvvObCLh5q1XU1cU2qErPskrhPNI5s/A/+CdTVqTfGhU2//B9xPNTzb8N5ixEv/i9j0YEH80vR82eHk6lT9cIyhHlzr9CDln8lnysrnbg6qtpEr+1RGvgK4t4H/SgbV2GEUngHnV9jpokdUs4pjvx+r96YmnEPqy10ElpBvQ== shazow@shazowic-toitle"

services:
  bitcoin:
    testnet: True
    rpcuser: bitcoin
    rpcpassword: CHANGETHISPASSWORD
    rpcport: 18338
    walletnotify: /home/deploy/projects/coinhooks/env/bin/python /home/deploy/projects/coinhooks/deploy/bin/walletnotify.py /home/deploy/projects/coinhooks/deploy/production.ini %s
  redis:
    port: 6379
    host: 127.0.0.1
    databases:
      projects: 0
      celery: 1
