# @author Daniel Alejandro Dominguez Diaz
module Lbry
  class Client
    attr_reader :client
    APIS = {
      daemon: Lbry::Daemon,
      crd: Lbry::Lbrycrd
    }
    def self.add_support_for(lbry_command, http_verb: :post)
      define_method(lbry_command) do |*args, &block|
        client.send(http_verb, lbry_command, *args)
      end
    end

    def initialize(auth: {}, api: :daemon)
      @client = APIS[api].new(auth)
    end

    # Announce blobs to the DHT
    # @overload blob_announce(query)
    #   @param [Hash] query
    #   @option query [String] :blob_hash announce a blob, specified by blob_hash
    #   @option query [String] :stream_hash announce all blobs associated with stream_hash
    #   @option query [String] :sd_hash announce all blobs associated with sd_hash and the sd_hash itself
    add_support_for :blob_announce

    # Get blob availability
    # @overload blob_announce(query)
    #   @param [Hash] query
    #   @option query [String] :blob_hash check availability for this blob hash
    #   @option query [Number] :search_timeout how long to search for peers for the blob in the dht
    #   @option query [Number] :sd_hash how long to try downloading from a peer
    add_support_for :blob_availability

    # Delete a blob
    # @overload blob_delete(query)
    #   @param [Hash] query
    #   @option query [String] :blob_hash blob hash of the blob to delete
    add_support_for :blob_delete

    # Download and return a blob
    # @overload blob_get(query)
    #   @param [Hash] query
    #   @option query [String] :blob_hash :required, blob hash of the blob to get
    #   @option query [Number] :timeout timeout in number of seconds
    #   @option query [String] :encoding by default no attempt at decoding is made, can be set to one of the following decoders: 'json'
    #   @option query [String] :payment_rate_manager if not given the default payment rate manager will be used. supported alternative rate managers: 'only-free'
    add_support_for :blob_get

    # Returns blob hashes. If not given filters, returns all blobs known by the blob manager
    # @overload blob_list(query)
    #   @param [Hash] query
    #   @option query [Boolean] :needed only return needed blobs
    #   @option query [Boolean] :finished only return finished blobs
    #   @option query [String] :uri filter blobs by stream in a uri
    #   @option query [String] :stream_hash filter blobs by stream hash
    #   @option query [String] :sd_hash filter blobs by sd hash
    #   @option query [Number] :page_size results page size
    #   @option query [Number] :page page of results to return
    add_support_for :blob_list

    # Returns blob hashes. If not given filters, returns all blobs known by the blob manager
    # @overload blob_reflect(query)
    #   @param [Hash] query
    #   @option query [String] :reflector_server reflector address
    add_support_for :blob_reflect

    # Reflects all saved blobs
    # No args
    add_support_for :blob_reflect_all

    # Returns blob hashes. If not given filters, returns all blobs known by the blob manager
    # @overload block_show(query)
    #   @param [Hash] query
    #   @option query [String] :blockhash :required, hash of the block to look up
    #   @option query [Number] :height :required, height of the block to look up
    add_support_for :block_show

    # Export serialized channel signing information for a given certificate claim id
    # @overload channel_export(query)
    #   @param [Hash] query
    #   @option query [String] :claim_id :required, Claim ID to export information about
    add_support_for :channel_export

    # Import serialized channel signing information (to allow signing new claims to the channel)
    # @overload channel_import(query)
    #   @param [Hash] query
    #   @option query [String] :serialized_certificate_info :required, certificate info
    add_support_for :channel_import

    # Get certificate claim infos for channels that can be published to
    # No args
    add_support_for :channel_list

    # Generate a publisher key and create a new '@' prefixed certificate claim
    # @overload channel_new(query)
    #   @param [Hash] query
    #   @option query [String] :channel_name :required, name of the channel prefixed with '@'
    #   @option query [Float] :amount :required, bid amount on the channel
    add_support_for :channel_new

    # Abandon a name and reclaim credits from the claim
    # @overload claim_abandon(query)
    #   @param [Hash] query
    #   @option query [String] :claim_id claim_id of the claim to abandon
    #   @option query [String] :txid txid of the claim to abandon
    #   @option query [Number] :nout nout of the claim to abandon
    add_support_for :claim_abandon

    # List current claims and information about them for a given name
    # @overload claim_list(query)
    #   @param [Hash] query
    #   @option query [String] :name name of the claim to list info about
    add_support_for :claim_list

    # List current claims and information about them for a given name
    # @overload claim_list_by_channel(query)
    #   @param [Hash] query
    #   @option query [String] :uri required, uri of the channel
    #   @option query [String] :uris uris of the channel
    #   @option query [Number] :page which page of results to return where page 1 is the first page, defaults to no pages
    #   @option query [Number] :page_size number of results in a page, default of 10
    add_support_for :claim_list_by_channel

    add_support_for :help

    SUPPORTED_METHODS = %w{
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
    }.each {|q| self.add_support_for q.to_sym }

  end
end
