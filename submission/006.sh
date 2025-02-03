# Which tx in block 257,343 spends the coinbase output of block 256,128?
coinbase_txid=$(bitcoin-cli getblock $(bitcoin-cli getblockhash 256128) 2 | jq -r '.tx[0].txid')
hash_257343=$(bitcoin-cli getblockhash 257343)
block_data=$(bitcoin-cli getblock $hash_257343 2)

echo $block_data | jq -r --arg txid "$coinbase_txid" '.tx[] | select(.vin[].txid==$txid) | .txid'
