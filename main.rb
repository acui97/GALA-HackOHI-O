# File created on 10-27-2018 for HackOHI/O by Andy Cui

# The user enters an argument and that decides whether the program runs continuously in real time or a sample day, either today or a future day
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
			if list_customers.length == 0
				puts "No anniversaries found today"
			end
			
			# Goes through the process of checking emails if it is 9 AM
			# if time.hour == 9
				# Iterate over each customer and looks at their connection date
				list_customers.each do |customer|

					# Here is where we would grab their email address
					puts "Enter email that you will be using"
					address = STDIN.gets.chomp # FIX for actual use
					# HERE IS WHERE WE SHOULD ADD IMAGE
					run = @@email.deliver address, @@database, customer rescue false # FIX WHEN DB DONE AND EMAIL DONE

					unless run
						until run
							puts "Enter a valid email"
							address = STDIN.gets.chomp
							run = @@email.deliver address, @@database, customer rescue false
						end
					end


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
			# Sleeping for the rest of the day, runs next day at 8 AM
			puts "Sleeping for #{115200 - (Time.new.hour*3600 + Time.new.min*60 + Time.new.sec)} seconds" 
			sleep(115200 - (Time.new.hour*3600 + Time.new.min*60 + Time.new.sec))
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
			if list_customers.length == 0
				puts "No anniversaries found today"
			end
			
			# Iterate over each customer and looks at their connection date
			list_customers.each do |customer|
				# Here is where we would grab their email address
				puts "Enter email that you will be using"
				address = STDIN.gets.chomp # FIX for actual use
				# HERE IS WHERE WE SHOULD ADD IMAGE
				run = @@email.deliver address, @@database, customer rescue false # FIX WHEN DB DONE AND EMAIL DONE

				unless run
					until run
						puts "Enter a valid email"
						address = STDIN.gets.chomp
						run = @@email.deliver address, @@database, customer rescue false
					end
				end


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