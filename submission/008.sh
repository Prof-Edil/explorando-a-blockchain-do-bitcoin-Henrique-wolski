# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`
txid="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"
rawtx=$(bitcoin-cli getrawtransaction "$txid" 1)
pubkey=$(echo "$rawtx" | jq -r '.vin[0].scriptSig.hex' | xxd -r -p | tail -c +2 | head -c -2 | xxd -p)
decoded_pubkey=$(bitcoin-cli decoderawtransaction "$rawtx" | jq -r '.vin[0].txinwitness[1]')
echo "$decoded_pubkey"
