
module Lbry
  class Client
    attr_reader :client

    SUPPORTED_METHODS = %w{
      blob_announce
      blob_availability
      blob_delete
      blob_get
      blob_list
      blob_reflect
      blob_reflect_all
      block_show
      channel_export
      channel_import
      channel_list
      channel_new
      claim_abandon
      claim_list
      claim_list_by_channel
      claim_list_mine
      claim_new_support
      claim_renew
      claim_send_to_address
      claim_show
      cli_test_command
      commands
      daemon_stop
      file_delete
      file_list
      file_reflect
      file_set_status
      get
      help
      peer_list
      peer_ping
      publish
      resolve
      resolve_name
      routing_table_get
      settings_get
      settings_set
      status
      stream_availability
      stream_cost_estimate
      transaction_list
      transaction_show
      utxo_list
      version
      wallet_balance
      wallet_decrypt
      wallet_encrypt
      wallet_is_address_mine
      wallet_list
      wallet_new_address
      wallet_prefill_addresses
      wallet_public_key
      wallet_send
      wallet_unlock
      wallet_unused_address
    }

    def initialize(auth: {})
      @client = Api.new(auth)
    end

    def method_missing(method_name, *args, &block)
      raise unless SUPPORTED_METHODS.include?(method_name.to_s)
      client.post(method_name, *args)
    end
  end
end
