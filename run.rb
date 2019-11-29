load 'lib/parser.rb'

parser = Parser::Parser.new('https://www.instagram.com/p/B4S1VdUJSNe/')
# print parser.allPosts
# p parser.video
puts parser.poster
puts parser.title
