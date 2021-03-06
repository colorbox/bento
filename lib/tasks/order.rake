require_relative './rake_helpers'
require_relative '../idobata'

namespace :order do
  desc '平日分の Order レコードを作成する'
  task create: :environment do
    include Idobata

    today = Time.current.beginning_of_day.to_date
    orders_from_today = Order.where('date > ?', today)

    new_order_date = if orders_from_today.any?
                       next_weekday_of(orders_from_today.last.date)
                     else
                       next_weekday_of(today)
                     end

    begin
      url = ENV['IDOBATA_DEVELOPER_HOOK_URL']
      order = Order.create!(date: new_order_date)
      Idobata.post("#{I18n.l(order.date)} の Order レコードが正常に作成されました", url)
    rescue => e
      Idobata.post("Order レコード作成時にエラーが発生しました: #{e.message}", url)
    end
  end
end
