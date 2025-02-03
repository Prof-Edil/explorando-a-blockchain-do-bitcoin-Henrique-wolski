# Only one single output remains unspent from block 123,321. What address was it sent to?
blockhash=$(bitcoin-cli getblockhash 123321)
txids=$(bitcoin-cli getblock "$blockhash" | jq -r '.tx[]')

for txid in $txids; do
  vout_count=$(bitcoin-cli getrawtransaction "$txid" 1 | jq -r '.vout | length')
  for i in $(seq 0 $((vout_count - 1))); do
    is_spent=$(bitcoin-cli gettxout "$txid" $i | jq -r '.bestblock' 2>/dev/null) # Check if output is spent
    if [[ -z "$is_spent" ]]; then # If not spent
        address=$(bitcoin-cli getrawtransaction "$txid" 1 | jq -r ".vout[$i].scriptPubKey.address")
        echo "$address"
        exit 0 # Exit after finding the unspent output
    fi
  done
done
