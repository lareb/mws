class Mws::Apis::OrderList

	attr_reader :latest_ship_date, :order_type,:purchase_date,:buyer_email,:amazon_order_id,:last_update_date,:ship_service_level, :number_Of_items_shipped, :order_status, :sales_channel,:is_business_order,
	:number_of_items_unshipped, :buyer_name, :currency_code, :amount, :is_premium_order, :earliest_ship_date, 
	:marketplace_id, :fulfillment_channel, :payment_method, :state_or_region, :city, :phone, :country_code, :postal_code,
	:name, :address_line1, :is_prime, :shipment_service_level_category, :seller_order_id

  def initialize(node)
      @latest_ship_date = node.xpath('LatestShipDate').text.to_s
      @order_type = node.xpath('OrderType').text.to_s
      @purchase_date = node.xpath('PurchaseDate').text.to_s
      @buyer_email = node.xpath('BuyerEmail').text.to_s
      @amazon_order_id = node.xpath('AmazonOrderId').text.to_s
      @buyer_name = node.xpath('BuyerName').text.to_s
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