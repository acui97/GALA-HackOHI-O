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
	
	def generate_content database, customer
		page = '<html lang="en">
		<head>
	  	<meta charset="utf-8">
	  	<title>Email</title>
		</head>
		<body>
		<div><img style="width:200px;" src="https://www.elp.com/content/elp/en/articles/2017/03/aep-unveils
		-new-logo-brand-identity/_jcr_content/leftcolumn/article/thumbnailimage.img.jpg"/></div>
		<br /><br />
		<h3>Dear Customer #'
		page += customer.billingIdNumber.to_s
		page += ',</h3>
		<div style="background-color:lightgray"><br /><br /><div style="
		width: 500px;
		height: auto;
		text-align: center;
		margin: 0px auto;
		border: red solid 2px;">
			<h3>Thank You For</h3>
			<div style="
			width: 100px;
			height: 100px;
			margin: 5px 200px;
			padding: 0px;
			background-color: skyblue;
			border-radius: 50%;"><p style = "
				width: 100px;
				top: 50%;
				position: relative;
				text-align: center;
				font-size: 50px;
				margin: auto;">'

		page += customer.years.to_s 
		page += '</p></div><h3> Awesome Years!</h3></div>
		<div style="margin: 0px 100px 30px;">
		<h2>What we have done to improve</h2>
		<p>Since you joined us, we\'ve added or updated '
		page += (database.numOfassetImprovement customer.billingIdNumber).to_s
		page += ' assets to your network to improve the quality you receive. 
		We will continue to work on making your experience better!</p>'
		page += '</div></div></body></html>'
	
	
		@content = Mail::Part.new do
  			content_type 'text/html; charset=UTF-8'
			body page
		end
	end
	private :generate_content
	
	def deliver destination_address, database, customer
	
		puts "gets to email"
		generate_content database, customer
		# create the Mail object
		@mail = Mail.new do
		  to      destination_address
		  from    @@options[:address]
		  subject 'Thank You AEP Customer'
		end
		@mail.html_part = @content
		# send the email
		@mail.deliver
		puts 'Email is delivered to ' + destination_address + "!"
	end
	
	
end
