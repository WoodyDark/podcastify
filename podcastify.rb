require 'open-uri'
require 'nokogiri'
require "fileutils"
require 'colorize'

#Introduction and intializing
system("clear")
puts ""
puts ""
puts "Welcome to #{"Podcastify".yellow}. #{"Podcastify".yellow} is a script developed by Jeffrey Soong to help save you time and effort, by automating bulk podcasts download in the background while you do your work. #{"Podcastify".yellow} only works for Relay FM shows"
puts ""
puts ""

numbering = 1
show_list = []
show_names = []
show_links = []
shows_page = Nokogiri::HTML(open("https://www.relay.fm/shows"))
shows_page.css(".broadcast__name a").each do |item|
	show_list.push(numbering.to_s + ". " + item.inner_html)
	show_names.push(item.inner_html)
	show_links.push("https://www.relay.fm#{(item.attr('href'))}")
	numbering += 1
end


#Quesiton 1
q1 = false
while q1 == false
	puts show_list
	puts ""
	puts "Which show would you like to download?"
	show = gets.chomp.to_i-1
	puts ""
	if show > 0
		selected_show = show_names[show]
		puts "You have selected #{selected_show.light_blue}!".green
		q1 = true
	else
		puts "Show not found, please ensure you specify the number according to the list".red
	end
	puts ""
end


#Question 2
selected_show_page = Nokogiri::HTML(open(show_links[show]))
latest_episode = selected_show_page.css("h3 a")[0].inner_html.split(":")[0].gsub!("#","").to_i
q2 = false
while q2 == false
	puts "The latest episode for #{selected_show.light_blue} is episode #{latest_episode.to_s.light_blue}"
	puts "Do you want to download all episodes of #{selected_show.light_blue}? (y/n)"
	all_episode = gets.chomp.downcase
	puts ""
	q2 = true
	if all_episode == "y"
		episode_start = 1
		episode_end = latest_episode
	elsif all_episode == "n"
		puts "Which episode would you like to start from?"
		episode_start = gets.chomp.to_i
		puts ""
		if episode_start <= latest_episode || episode_start > 0
			puts "Which episode would you like to stop at?"
			episode_end = gets.chomp.to_i
			puts ""
			if episode_end > latest_episode || episode_end < episode_start
				puts "The episode that you have chosen does not exist, please try again".red
				q2 = false
			end
		else
			puts "The episode that you have chosen does not exist, please try again".red
			q2 = false
		end
	else
		q2 = false
	end
end
puts "Download range has been set to episode #{episode_start.to_s} to #{episode_end.to_s}".green
puts ""


#Question3
puts "Configuration complete. Download will be starting shortly. Please ensure you have an active internet connection. To cancel download, press [Ctrl+C] or [Command+C]"
puts ""
episode = episode_start
while episode != episode_end+1
	puts "Initializing download for #{selected_show.light_blue} episode #{episode}"
	url = "#{show_links[show]}/#{episode}"
	show_page = Nokogiri::HTML(open(url))
	audio = show_page.css(".js-audio")
	download_link = audio.attr("href")
	puts "Downloading for #{selected_show.light_blue} episode #{episode}"
	tempfile = URI.parse(download_link).open
	tempfile.close
	FileUtils.mv tempfile.path, "#{selected_show} #{episode}.mp3"
	puts "Download complete for #{selected_show.light_blue} episode #{episode}"
	puts "..."
	episode += 1
end

puts "Download complete, #{'Podcastify'.yellow} is shutting down. See you again soon"