class Database 
	
	attr_accessor  :housingType
	attr_accessor  :ownOrRent
	attr_accessor  :billingIdNumber
	attr_accessor  :segment
	attr_accessor  :connDate
	attr_accessor  :years

	def initialize 
		@years = nil 
		@connDate = nil
		@housingType = nil
		@ownOrRent = nil
		@billingIdNumber = nil
		@segment = nil
	end
	
	
end

class MonthlyData 
	
	attr_accessor	:billingId
	attr_accessor	:date
	attr_accessor	:zip
	attr_accessor	:averageBill
	attr_accessor	:netUse
	attr_accessor	:billAmount
	

	def initialize
		billingId = nil
		date = nil
		zip = nil
		averageBill = nil
		netUse = nil
		billAmount = nil

	end


end
