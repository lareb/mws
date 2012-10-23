
require 'mws'
require 'active_support/core_ext'

mws = Mws.connect(
  merchant: 'XXX', 
  access: 'XXX', 
  secret: 'XXX'
)

class Workflow

  def initialize(queue)
    @queue = queue
    @handlers = []
  end
  
  def register(*deps, &handler)
    @handlers << [ handler, deps ]
  end

  def complete(feed)
    @handlers.each do | handler |
      handler.last.delete feed
    end
    proceed
  end

  def proceed
    @handlers.each_with_index do | handler, index |
      if handler.last.empty?
        @handlers[index] = nil
        [ handler.first.call ].compact.flatten.each do | feed |
          @queue << feed
        end
      end
    end
    @handlers.compact!
  end

end

in_process_q = []
terminated_q = []

workflow = Workflow.new(in_process_q)

workflow.register do
  product_feed = mws.feeds.products.add(
    Mws::Apis::Feeds::Product.new('2634897') do
      tax_code 'A_GEN_TAX'
      name "Rocketfish\u2122 6' In-Wall HDMI Cable"
      brand "Rocketfish\u2122"
      description "This 6' HDMI cable supports signals up to 1080p and most screen refresh rates to ensure stunning image clarity with reduced motion blur in fast-action scenes."
      bullet_point 'Compatible with HDMI components'
      bullet_point'Connects an HDMI source to an HDTV or projector with an HDMI input'
      bullet_point 'Up to 15 Gbps bandwidth'
      bullet_point'In-wall rated' 
      msrp 49.99, 'USD'
      category :ce
      details {
        cable_or_adapter {
          cable_length {
            length 6
            unit_of_measure :feet
          }
        }
      }
    end
  )
  workflow.register product_feed do
    price_feed = mws.feeds.prices.add(
      Mws::Apis::Feeds::PriceListing.new('2634897', 49.99).on_sale(29.99, Time.now, 3.months.from_now)
    )
    image_feed = mws.feeds.images.add(
      Mws::Apis::Feeds::ImageListing.new('2634897', 'http://images.bestbuy.com/BestBuy_US/images/products/2634/2634897_sa.jpg', 'Main'),
      Mws::Apis::Feeds::ImageListing.new('2634897', 'http://images.bestbuy.com/BestBuy_US/images/products/2634/2634897cv1a.jpg', 'PT1')
    )
    workflow.register price_feed, image_feed do
      inventory_feed = mws.feeds.inventory.add(
        Mws::Apis::Feeds::Inventory.new('2634897', quantity: 10, fulfillment_type: :mfn)
      )
      workflow.register inventory_feed do
        puts 'The workflow is complete!'
      end
      inventory_feed
    end
    [ price_feed, image_feed ]
  end
  product_feed
end

workflow.proceed

50.times do
  puts "In Process: #{in_process_q}"
  mws.feeds.list(ids: in_process_q).each do | info |
    puts "SubmissionId: #{info.id} Status: #{info.status}"
    terminated_q << in_process_q.delete(info.id) if [:cancelled, :done].include? info.status
  end unless in_process_q.empty?

  puts "Terminated: #{terminated_q}"
  unless terminated_q.empty?
    id = terminated_q.shift
    result = mws.feeds.get id
    puts result.inspect
    if result.message_count == result.message_count(:success)
      workflow.complete result.transaction_id
    end
  end
  puts  "|                        Waiting                           |"
  print '------------------------------------------------------------'
  60.times do |it|
    sleep 1
    print "\r"
    prg = it + 1
    rem = 60 - prg
    prg.times { print '=' }
    rem.times { print '-' }
  end
  print "\n"
end
