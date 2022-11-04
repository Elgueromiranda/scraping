
require_relative 'comment.rb'
require 'nokogiri'
require 'open-uri'
require 'set'


class Post 
	attr_accessor :title ,:url,:points,:comments, :item_id
	attr_reader :website

	def initialize(string)
		@title = ""
		@url = ""
		@points = ""
		@item_id = ""
		@comments = []
		@website = string
		read
	end

	def read
		
		hasho = ""
		inputUrl = URI.open(@website)
		doc = Nokogiri::HTML5(inputUrl)
		
		@title = doc.search("title")[0].content
		@url = doc.search("link")[0]["href"]
		@points = doc.search("h3")[0].content
		@item_id = doc.search("script")[-2].content
		hasho = @item_id

		@item_id = hasho.split[2].split(",")[2]

		commentHash = {}

		commentData = []
		userData = []


		 doc.search("span > div > a").each do |y|
		 	userData << y.content.to_s
		 end
		 	

		doc.search("div.comment-body > p > span").each do |x|
			 commentData << x.content.to_s
		end

		c = 0

		userData.each { |x| 

			commentHash.store(x, commentData[c])
			
			addComment(commentHash)
				
			commentHash.clear
			c += 1
		 }
	end	
	def addComment(new_comment_hash)
		@comments << Comment.new(new_comment_hash).inspect
	end
end


post = Post.new("https://novum.substack.com/p/social-recession-by-the-numbers")


puts post.title
puts post.url
puts post.points
puts post.item_id

puts post.comments


