require 'csv'

class Customer

  def writer
    letters = ("A".."Z").to_a


    26.times do |num|
      filtered_rows = []
      CSV.foreach('customers.csv', headers: true) do |row|
        if letters[num] == row["last_name"][0]
          filtered_rows << row
        end
        filtered_rows
      end
      CSV.open("customers_#{letters[num].downcase}.csv", "w") << filtered_rows
    end

  end

end

customer = Customer.new
customer.writer
