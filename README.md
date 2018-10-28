# GALA-HackOHI-O
This project sends a customer appreciation email, thanking the customer for x years of service and letting the customer know what we're doing to update and improve the assets in their area.

# Contributors
Logan Walters - Outlined the project and described how we should try to use the data. Designed the html and css as well as pair programmed.
Ganesh Rahut - Created the DataAEP class and functions to extract and manipulate the data from the dataset.
Muhammed Akhlak Chowdhury - Created the email class
Andy Cui - Created the main.rb file, helped debug, and changed some styling

# Instructions
$ bundle install

For the following instruction, use main.rb 1 or main.rb 2. The first option will run continuously and sleep when not processing. It will send emails out every morning to anniversary customers at 8 AMThe second option will allow you to select a certain day to test. We recommend using any current or future year, and 6/30 to see two anniversary emails. 

$ ruby main.rb 1
or
$ ruby main.rb 2
