# File created on 10-27-2018 for HackOHI/O by Andy Cui

require_relative 'email'
require_relative 'database'
require_relative 'dataAep'
class Main
	
	# Class variables used for accessing data and sending emails based on that data 
	@@database
	@@email

	# Initializes main and begins running the program
	def initialize
		# Initializing the class variables 
		@@database = AepCostumers.new
		@@email = Email.new
		mode = ARGV[0].to_i
		# MAKE COMMAND LINE INPUT FOR VERSION TO RUN
		puts mode
		if mode == 1
			run_program
		elsif mode == 2
			run_sample_day
		end
	end

	# Runs the program. The program will sleep until a certain time each day, where it will then parse the data for birthdays or customer anniversaries, sending out data-based emails that will improve customer relations by suggesting potential saving methods
	def run_program 
		while true
			# Time variable to check the current date and time
			date = Date.new
			time = Time.new

			# Gets the list of customers from the database
			list_customers = @@database.custumerList date
			
			# Goes through the process of checking emails if it is 9 AM
			if time.hour == 9
				# Iterate over each customer and looks at their connection date
				list_customers.each do |customer|

					# Here is where we would grab their email address
					address = "cui.400@osu.edu" # FIX for actual use
					@@email.deliver address, @@database, customer # FIX WHEN DB DONE AND EMAIL DONE


					# THIS BLOCK IS COMMENTED OUT BECAUSE DATABASE WILL HANDLE THE DATE COMPARISON
					# # Compares the current day with the customer's date of connection and ensures the customer was not added on the same year
					# if customer.connect_date.day == time.day # FIX WHEN DB DONE
					# 	if customer.connect_date.month == time.month # FIX WHEN DB DONE
					# 		if customer.connect_date.year != time.year # FIX WHEN DB DONE 
					# 			@@email.format_email address @@database # FIX WHEN EMAIL DONE
					# 		end
					# 	end
					# end
				end
			end
			# Sleeping for the rest of the hour
			if time.hour == Time.new.hour
				sleep(3600 - (Time.new.min*60 + Time.new.sec))
			end
		end
	end


	def run_sample_day
		# while true
			puts "What is the year you would like to test? Enter the current or a future year."
			year = Integer(STDIN.gets.chomp) rescue false
			
			# Grabs the sample year and ensures that it is the present or future
			while !year || year < Time.new.year
				puts "Enter the current or a future year."
				year = Integer(STDIN.gets.chomp) rescue false
			end
			
			month = false
			day = false
			run = Date.new(year, month, day) rescue false
			while !month || !day || !run || Date.new(year, month, day) < Date.new 

				if year && month && day
					puts Date.new(year, month, day) < Date.new
					puts month
					puts day
					puts run
				end

				puts "What is the month you would like to test? Enter the current or a future month."
				month = Integer(STDIN.gets.chomp) rescue false
				while !month 
					puts "Enter a current or future month."
					month = Integer(STDIN.gets.chomp) rescue false
				end

				puts "What is the day you would like to test? Enter the current or a future day."
				day = Integer(STDIN.gets.chomp) rescue false
				while !day
					puts "Enter a current or future day."
					day = Integer(STDIN.gets.chomp) rescue false
				end

				run = Date.new(year, month, day) rescue false
				if run 
					date = run
				end
				if !run || Date.new(year, month, day) < Date.new
					puts "The full date you entered was in the past. Please input a correct date."
				end
			end

			# Gets the list of customers from the database
			list_customers = @@database.custumerList date # FIX WHEN DB DONE
			list_customers
			
			# Iterate over each customer and looks at their connection date
			list_customers.each do |customer|
				# Here is where we would grab their email address
				puts "gets into customer loop"
				address = "cui.400@osu.edu" # FIX for actual use
				# HERE IS WHERE WE SHOULD ADD IMAGE
				@@email.deliver address, @@database, customer # FIX WHEN DB DONE AND EMAIL DONE

				# THIS BLOCK IS COMMENTED OUT BECAUSE DATABASE WILL HANDLE THE DATE COMPARISON
				# # Compares the current day with the customer's date of connection and ensures the customer was not added on the same year
				# if customer.connect_date.day == time.day # FIX WHEN DB DONE
				# 	if customer.connect_date.month == time.month # FIX WHEN DB DONE
				# 		if customer.connect_date.year != time.year # FIX WHEN DB DONE 
				# 			@@email.format_email address @@database # FIX WHEN EMAIL DONE
				# 		end
				# 	end
				# end
			end
		# end
			# # Sleeping for the rest of the hour
			# if time.hour == Time.new.hour
			# 	sleep(3600 - (Time.new.min*60 + Time.new.sec))
			# end
	end
end

tester = Main.new