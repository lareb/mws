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
      @amazon_order_id = node.xpath('AmazonOrderId').text.to_s
      @last_update_date = node.xpath('LastUpdateDate').text.to_s
      @ship_service_level = node.xpath('ShipServiceLevel').text.to_s
      @number_Of_items_shipped = node.xpath('NumberOfItemsShipped').text.to_s
      @order_status = node.xpath('OrderStatus').text.to_s
      @sales_channel = node.xpath('SalesChannel').text.to_s
      @is_business_order = node.xpath('IsBusinessOrder').text.to_s
      @number_of_items_unshipped = node.xpath('NumberOfItemsUnshipped').text.to_s
      @buyer_name = node.xpath('BuyerName').text.to_s
      
      @currency_code = node.xpath('OrderTotal/CurrencyCode').text.to_s
      @amount = node.xpath('OrderTotal/Amount').text.to_s
      
      @is_premium_order = node.xpath('IsPremiumOrder').text.to_s
      @earliest_ship_date = node.xpath('EarliestShipDate').text.to_s
      @marketplace_id = node.xpath('MarketplaceId').text.to_s
      @fulfillment_channel = node.xpath('FulfillmentChannel').text.to_s
      @payment_method = node.xpath('PaymentMethod').text.to_s

      @state_or_region = node.xpath('ShippingAddress/StateOrRegion').text.to_s
      @city = node.xpath('ShippingAddress/City').text.to_s
      @phone = node.xpath('ShippingAddress/Phone').text.to_s
      @country_code = node.xpath('ShippingAddress/CountryCode').text.to_s
      @postal_code = node.xpath('ShippingAddress/PostalCode').text.to_s
      @name = node.xpath('ShippingAddress/Name').text.to_s
      @address_line1 = node.xpath('ShippingAddress/AddressLine1').text.to_s

      @is_prime = node.xpath('IsPrime').text.to_s
      @shipment_service_level_category = node.xpath('ShipmentServiceLevelCategory').text.to_s
      @seller_order_id = node.xpath('SellerOrderId').text.to_s
  end

end