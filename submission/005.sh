# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`
txid="37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517"

pubkeys=$(bitcoin-cli getrawtransaction $txid 2 | jq -r '.vin[].txinwitness[1]' | awk '{print "\"" $0 "\""}' | paste -sd "," -)

address=$(bitcoin-cli createmultisig 1 "[$pubkeys]" | jq -r '.address')

echo $address
