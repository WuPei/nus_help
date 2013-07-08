# Objective:
Encourage Mutual Help, Information Sharing and Communication

# Initiative:
We believe people in general are willing to help each other, and it’s possible to know more people through this helping process. Meanwhile, people in one field may need help in another.

There are people who need help found it very hard to gain help, because they don’t know whom to task.
There are people who have time and can actually offer help to other people, but they don’t know who need help.

Thus, we want to create such kind of platform for people to post help request on certain fields, and also subscribe to certain topics so that an email alert can be issued when there’s a need for help.

Moreover, we believe the process of communication can be made fun, thus some interesting features are added to the system to facilitate interesting communication process.

# Set Up the Server:
Note: the setup for Server has been Verified on Mac and Ubuntu machine. Most likely RubyOnRails cannot work well on Windows Machine.
1. Install Ruby 2.0.0. Recommend to install from rvm
2. cd to our project's root folder, run `bundle install`. This would install all necessary Gem files.
   (In case of Exceptions... Please Google the solution)
3. install ImageMagick. On Mac, either via macport, or homebrew; on Ubuntu, via apt-get.
4. in your command line, type `identify` to check if `identify` commend is there. 
   If not, find the path of your ImageMagick by doing `locate convert`, then add the `bin`
   Iolder in that path into your `/etc/paths` (System Path)
5. Run `rails s` to start our app on server

# FAQ
### 1. Is this a Mobile App?
Answer: yes this website can be run on Mobile
### 2. Where can I see a demo of this app?
Answer: we're in testing phase, thus haven't buy a domain yet. For browsing, you may simply visit: <http://192.241.208.238:3000/>.
