# Only one single output remains unspent from block 123,321. What address was it sent to?
block_hash=$(bitcoin-cli getblockhash 123321)
block_data=$(bitcoin-cli getblock $block_hash 2)

txids=$(echo "$block_data" | jq -r '.tx[].txid')

for txid in $txids; do
    vout_count=$(bitcoin-cli getrawtransaction $txid 1 | jq '.vout | length')

    for ((i=0; i<vout_count; i++)); do
        unspent=$(bitcoin-cli gettxout $txid $i)
        if [ -n "$unspent" ]; then
            address=$(echo "$unspent" | jq -r '.scriptPubKey.addresses[0]')
            echo $address
            exit 0
        fi
    done
done
