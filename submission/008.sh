# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`
tx_data=$(bitcoin-cli getrawtransaction e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163 1)

scriptSig=$(echo "$tx_data" | jq -r '.vin[0].scriptSig.asm')

pubkey=$(echo "$scriptSig" | awk '{print $NF}')

echo $pubkey
