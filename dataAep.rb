# This class uses data from xlsx file to get the information about the AepCostumers and selects it 
# with different criteria and use it to send celebration emails.
# Author Ganesh rahut 
require 'roo' 	#ruby gem to read data from xlsx file
require 'date'	# Date gem
require_relative 'database' 	#database class which is object of each custumer

class AepCostumers
	
	
	def initialize

		@@data = Roo::Spreadsheet.open('./HackOHiO_AEP Data.xlsx')
		custumerList 
		usess =  netUse 1121
		puts "The billing id is "
		puts usess[1].billingId
		numOfassetImprovement
		print hasDoneSurveys? 
	end

	# This method looks for the people who joined the Aep on the given day and returns the object of 
	# each custumer with their billing Id, husingType, ownOrRent, segments etc
	def custumerList #date

		@@listOfCustumer = []	#array of custumer object	
		custumerData = @@data.sheet('CustCharacteristics') #slect the given sheet from the file.
		
		connDate = custumerData.column(4) # Creating array of Connetion Date
		segments = custumerData.column(5) # Creating array of Segments of Custumers
		ownerOrRent = custumerData.column(7) #Array of owner types of custumers
		housingType = custumerData.column(8) #Array of husingType
		billingId = custumerData.column(1)	 #array of billingId of all the custumers in the sheet

		date =  Date.new(2015,6,30) # FOr debug propose.
		peopleIndex = 1  			#indexing the the array.
		
		while peopleIndex < connDate.length #checks all the data
			if connDate[peopleIndex].month == date.month  #compares if months is equal 
				if connDate[peopleIndex].day == date.day	#checks if days are equal if months is equal.
					aCustumer = Database.new 
					aCustumer.billingIdNumber = billingId[peopleIndex]
					aCustumer.ownOrRent = ownerOrRent[peopleIndex] 
					aCustumer.housingType =	housingType[peopleIndex]
					aCustumer.segment = segments[peopleIndex]
					
					@@listOfCustumer << aCustumer
				end
			end
			peopleIndex += 1
		end
		puts "The list of Custumers with aniversery today"
		puts @@listOfCustumer.to_a
		return @@listOfCustumer
	end


	def numOfassetImprovement #billingIdNumber

		numOfassetImprovement = 0
		custumerData = @@data.sheet('PoleTrnsfrmrImprovements')
		billingId = custumerData.column(1)
		billingIdNumber = billingId[1] #just for debuggging propose
		noOfImprovements = custumerData.column(6)
		peopleIndex = 1
		found = false
		while peopleIndex < billingId.length && !found 
			if(billingIdNumber == billingId[peopleIndex] ) 
				numOfassetImprovement = noOfImprovements[peopleIndex]
				found = !found
			end

			peopleIndex += 1

		end
		puts numOfassetImprovement
		return numOfassetImprovement
	end 

	def hasDoneSurveys? #billingIdNumber
		custumerData = @@data.sheet('SurveyData')
		billingId = custumerData.column(1)
		billingIdNumber = billingId[1]
		peopleIndex = 1
		while peopleIndex < billingId.length
			if billingId[peopleIndex] == billingIdNumber
				return true
			else 
				return false
			end 
			peopleIndex += 1
		end
	end

	def netUse billingIdNumber
		billingIdNumber = 13095811
		monthlydata = []
		custumerData = @@data.sheet('MonthlyData')
		billingId = custumerData.column(1)
		date = custumerData.column(2)
		zip = custumerData.column(3)
		averageBill = custumerData.column(4)
		netUse = custumerData.column(5)
		billAmount = custumerData.column(6)

		
		netUsage = 0
		peopleIndex = 1
		while peopleIndex < billingId.length
			if billingIdNumber == billingId[peopleIndex]
				monthData = MonthlyData.new
				monthData.billingId = billingId[peopleIndex]
				monthData.date = date[peopleIndex]
				monthData.zip = zip[peopleIndex]
				monthData.averageBill = averageBill[peopleIndex]
				monthData.netUse = netUse[peopleIndex]
				monthData.billAmount = billAmount[peopleIndex]

				monthlydata << monthData
			end
			peopleIndex += 1
		end

		return monthlydata
	end 

end
x = AepCostumers.new

