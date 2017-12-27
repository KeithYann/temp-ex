const fs = require('fs');

if (process.argv[2]) {
  const limitHeight = parseInt(process.argv[2]);
  const config = JSON.parse(fs.readFileSync('/app/bitcore-node-btc/bin/mynode/bitcore-node.json'));
  config.servicesConfig.bitcoind.limitHeight = limitHeight;
  fs.writeFileSync('/app/bitcore-node-btc/bin/mynode/bitcore-node.json', JSON.stringify(config));
}