class Email
	require'mail'
	
	@@options = { :address         => "smtp.gmail.com",
	            :port                 => 587,
	            :user_name            => 'modernwebfighters@gmail.com',
	            :password             => '123ABCabc',
	            :authentication       => 'plain',
	            :enable_starttls_auto => true  }
	
	# Constructor
	def initialize
		# set content to nil first
		@content = nil

		Mail.defaults do
	  		delivery_method :smtp, @@options
		end
	end
	
	def generate_content linkofwebpage
		page = linkofwebpage
	end
	
	@content = Mail::Part.new do
  			content_type 'text/html; charset=UTF-8'
  			body page
	end
	private :genereate_content
	
	def deliver destination_address, database
	
		# create the Mail object
		@mail = Mail.new do
		  to      destination_address
		  from    @@options[:address]
		  subject 'Thank You AEP Customer'
		end
		@mail.html_part = @content
		# send the email
		@mail.deliver
		puts 'Email is delivered to ' + destination_address + " !"
	end
	
	
end
