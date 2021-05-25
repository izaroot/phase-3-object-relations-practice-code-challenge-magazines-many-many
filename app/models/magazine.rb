class Magazine < ActiveRecord::Base
    has_many :subscriptions
    has_many :readers, through: :subscriptions

    def email_list
        emails = []
        self.readers.each do |reader|
            emails << reader.email 
        end
        emails.join(";")
    end

    def self.most_popular
        sub_count = 0
        best_magazine = {}
        self.all.each do |magazine|
            if magazine.subscriptions.count >= sub_count
                sub_count = magazine.subscriptions.count
                best_magazine = magazine
            end
        end
        puts sub_count
        best_magazine
    end
end