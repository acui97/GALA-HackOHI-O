require 'roo'
class AepCostumers
	
	
	def initialize

		@@data = Roo::Spreadsheet.open('./HackOHiO_AEP Data.xlsx')
		custumerList
	end

	def custumerList #date		
		print @@data.sheets
		custumer = @@data.sheet('CustCharacteristics')
		connDate = custumer.column(4);
		
		 connDate.each{ |cus|
		 	if cus == date {
		 		
		 	}
		 }

		puts connDate.class

	end

end
x = AepCostumers.new
