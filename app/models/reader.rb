class Reader < ActiveRecord::Base
    has_many :subscriptions
    has_many :magazines, through: :subscriptions

    def subscribe (magazine, price)
        Subscription.create(reader_id: self.id, magazine_id: magazine.id, price: price)    
    end

    def total_subscription_price
        total = []
        self.subscriptions.each do |subscription|
            total << subscription.price   
        end
        total.sum
    end

    def cancel_subscription(magazine)
        to_cancel = []
        self.subscriptions.each do |subscription|
            if subscription.magazine_id == magazine.id
                to_cancel << subscription.id
            end
        end
        Subscription.destroy(to_cancel)
    end
end
