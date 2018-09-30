# Podcastify
Podcastify is a bulk podcast downloader for RelayFM content. This is a simple script written in Ruby which will help automate the download process so that you can do your work while the download runs. The best thing? The script will download each episode by the ascending sequence, episode by episode, instead of simultaneously downloading all of them at the same time.


# How to use
You must first have Ruby installed on your computer to run this script. If you don't have it, do check out the link below to learn how you can install ruby on your OS.
https://www.ruby-lang.org/en/downloads/

Once you have Ruby installed, you will need 2 additional gems/library to make this functional. Open your terminal, type in the following:

'gem install nokogiri'
'gem install colorize'

Once both gems installation are complete, download this as a zip. Place it in your preferred directory, right click and choose 'extract here'. The generated folder is called 'podcastify-master', and I recommend keeping the actual script inside the folder as all of the downloads will be stored in the same directory.

To use, launch your terminal, navigate to the script directory and type "ruby podcastify.rb", follow the prompt and your download will begin shortly.

# How does it work?
Behind the scenes, the script is essentially browsing relay.fm and clicking the buttons without loading up the browser. First it loads up "relay.fm/shows" and reads the site for all the existing show names, and displays it to the user. When you choose a site, it loads up the URL of the show and check for the latest episode, and then tells you what the latest episode is, so that you have an idea.

For example, if you chose to download the Cortex episodes, the script goes to "relay.fm/cortex" and look for the top most episode. You then choose if you want to download every single episode or the range of episodes you want to stop at. The script then manually visits each episode page e.g. "relay.fm/cortex/1" .."relay.fm/74" and downloads based on the given download link in each page. The script names the file "[show_name]+[episode_number].mp3" and writes the data onto your script directory.

# About me
My name is Jeffrey, and I am a junior web developer. I have literally just completed a coding bootcamp course and I have no prior coding experience. I have a lot of fun coding, and I have been listening to the Cortex podcast for some time now and really enjoy it, so I decided to do this as part of a side project. The reason I came up with this is because I download every episode that I listen to instead of streaming, but to visit each page and download manually was becoming quite a task, so I decided to solve this issue once and for all.


This script also simulates user action as much as possible, and by doing so, I hope to keep the integrity of Relay FM's data collection e.g. monthly page views/user clicks/number of podcast downloads and so on.
