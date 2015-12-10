class Mws::Apis::Orders

  def initialize(connection, overrides={})
    @connection = connection
    @param_defaults = {
      market: 'ATVPDKIKX0DER'
    }.merge overrides
    @option_defaults = {
      version: '2013-09-01',
      list_pattern: '%{key}.%{ext}.%<index>d'
    }
  end

  def list(params={})
    params[:markets] ||= [ params.delete(:markets) || params.delete(:market) || @param_defaults[:market] ].flatten.compact
    options = @option_defaults.merge action: 'ListOrders'
    puts "------------ time 2"
    ap @orders
    #params.merge!("CreatedAfter" => "2015-11-30T18:30:00Z")
    doc = @connection.get "/Orders/#{options[:version]}", params, options
    doc.xpath('Orders/Order').map do | node |
      Mws::Apis::OrderList.new(node)
      #@latest_ship_date = node.xpath('LatestShipDate').text.to_s
      #@order_type = node.xpath('OrderType').text.to_s
      # get_order_details(node)
    end
  end

  def get_order_details(node)
      @latest_ship_date = node.xpath('LatestShipDate').text.to_s
      @order_type = node.xpath('OrderType').text.to_s
      @purchase_date = node.xpath('PurchaseDate').text.to_s
      @buyer_email = node.xpath('BuyerEmail').text.to_s
      @amazon_order_id = node.xpath('AmazonOrderId').text.to_s
      @buyer_name = node.xpath('BuyerName').text.to_s
  end

end
