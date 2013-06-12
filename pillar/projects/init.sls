admin_email: shazow@gmail.com

projects:
  - name: coinhooks
    domain: coinhooks.com
    user: deploy
    group: www-data

services:
  bitcoin:
    testnet: True
    rpcuser: bitcoinrpc
    rpcpassword: CHANGETHISPASSWORD
  redis:

