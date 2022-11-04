
class Comment

	attr_reader :id, :comment
	def initialize(hash_item)
	
		@id = hash_item.keys[0]
		@comment = hash_item.values[0]

	end
end
