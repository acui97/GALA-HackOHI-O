require_relative 'scraper'


class Database 
	def initialize date, housingType, ownOrRent, polyTrans[], monthlyData[]
		@date = date
		@housingType = housingType
		@ownOrRent = ownOrRent
		@polyTrans[] = polyTrans
		@monthlyData[] = monthlyData[]
	end
	
	attr_accessor : date
	attr_accessor : housingType
	attr_accessor : ownOrRent
	attr_accessor : polyTrans
	attr_accessor : monthlyData
	
	def getinformation 
		list[] = {data, housingType, ownOrRent, polyTrans, monthlyData}
	end
	
end
