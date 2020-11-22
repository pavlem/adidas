# Adidas Instructions
There is no special installation required, just start the project and build since there are no third party libs. Add your bundle ID to build on real iPhone device. 

# User Interface:
- First screen is just a start screen, tap on start and the Table View with list of Adidas products will open
- Products are searchable by name or description (just drag down and search bar will appear). 
- Tap and any product to open it's details in a PUSH navigation fashion
- Tap add review to open a MODAL screen for a review
- When reviewing, on POST button tapped, there is a loading indicator until the review is done in a networking sense

# Architecture:
- MMVM used as an app design pattern since it complements apples native, out of the box, MVC for UIKit and it's new MVVM in SwiftUI
- Networking module is independent and can be implemented anywhere. It is based on apple’s “URLSession” and no third party libs
- There are Unit tests for VM and moc JSON of products list
- Custom navigation push is implemented (fade in)
- Caching of the images is implemented via "NSCache" class
- Many reusable components have been made like AdidasButton, AdidsasImageView, Alert heleper...

- File organisation:
	- App - App related data
	- Components - reusable components like button, imageview...
	- Sections - sections of the app which contain VCs, VMs, Views
	- ViewModels - view models 
	- Lib - all custom made libs with the main one being the networking module under “Networking” and image caching helper class
	- Resources - storyboards, strings, images
	- Vendors - third party classes - in our case there is only one and it's reachability 

# Notes:
- I had a lot of problems with docker file and I spent a lot of time making it work. On mac it' didn't want to work via brew install, and when I installed it via graphical interface it finally worked. Also "http://localhost:3001/api-docs/swagger/" and "http://localhost:3002/api/" behave little bit weird. For example I can query from the first the reviews, but if I add them via second (new reviews) they are not shown on the first although they are on the second and I have used the same product IDs. 

# Future improvements
Definitely I would maybe need one more day on this project to make it as best as possible in an UI sense, nicer look and feel, fonts, colours etc, but I simply didn't have enough in this case, especially since I had problems with docker. Also the networking layer can be even more abstract where I would implement a WebClient and Services which inherit that web client and so on....