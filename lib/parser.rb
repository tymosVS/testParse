require 'nokogiri'
require 'open-uri'

module Parser
  class Parser
    def initialize(url)
      @uri = URI(url)
      html_data = open(@uri)
      @doc = Nokogiri::HTML(html_data)
      @comments = []
    end

    def title
      @doc.at('title').text
    end

    def video
      post = @doc.search("meta[@property='og:video:secure_url']").first
      post[:content]
    end

    def poster
      post = @doc.search("meta[@property='og:image']").first
      post[:content]
    end

    def description
      post = @doc.search("meta[@property='og:description']").first
      reg_auth = /Comments - (?<author>.*) \(@.* on Instagram:/
      description = {}
      description[:like_count] = post[:content].split('Likes,')[0]
      description[:comments_count] = post[:content].split('Likes,')[1].split('Comments -')[0]
      description[:post_author] = post[:content].split('Likes,')[1].match(reg_auth)[:author]
      description[:post_description] = post[:content].split('Likes,')[1].split(/Comments - .* on Instagram:/)
      description
    end

    def count_review
      post = @doc.search("script[@type='application/ld+json']")
      count_review = ''
      post.each do |p|
        count_review = p.to_s.match(/\"userInteractionCount":\"(?<value>\d+)\"/)[:value].to_i
      end
      count_review
    end

    def comments
      count = /\"count\"\:(?<count>\d+)/
      comment_text = /\,\"page_info\".*\"text\":\"(?<comment>.*)\"\,/
      author_id = /\"created_at\".*\"owner\":\{\"id\"\:\"(?<author_id>\d+)/
      is_verified = /.*is_verified\"\:(?<is_verified>.*)\,/
      avatar_url = /\"profile_pic_url\"\:\"(?<avatar>.*)\"/
      author_name = /\,\"username\"\:\"(?<author_name>.*)\"\}\,/
      has_liked = /\"viewer_has_liked\"\:(?<has_liked>.*)\,/
      likes_count = /\"edge_liked_by\"\:\{\"count\"\:(?<comment_liked>\d+)/
      @comments = []
      comments_part1 = Regexp.new(count.source + comment_text.source + author_id.source)
      comments_part2 = Regexp.new(is_verified.source + avatar_url.source + author_name.source)
      comments_part3 = Regexp.new(has_liked.source + likes_count.source)
      comments_reg = Regexp.new(comments_part1.source + comments_part2.source + comments_part3.source)
      @doc.search("script[@type='text/javascript']").to_s.split('edge_threaded_comments').each do |post|
          comment = {}
          comment[:count] = post.to_s.match(comments_reg)[:count].to_i
          comment[:comment_text] = post.to_s.match(comments_reg)[:comment].to_s
          comment[:author_id] = post.to_s.match(comments_reg)[:author_id].to_s
          comment[:is_verified] = post.to_s.match(comments_reg)[:is_verified].to_s
          comment[:avatar_url] = post.to_s.match(comments_reg)[:avatar].to_s
          comment[:author_name] = post.to_s.match(comments_reg)[:author_name].to_s
          comment[:has_liked] = post.to_s.match(comments_reg)[:has_liked].to_s
          comment[:likes_count] = post.to_s.match(comments_reg)[:comment_liked].to_i
          @comments.push(comment)
      end
      @comments
    end

    def comments_count
      comments if @comments.size == 0
      @comments.size
    end

    def allPosts
      post = {}
      post[:title] = title
      post[:count_review] = count_review
      post[:video] = video
      post[:poster] = poster
      post[:description] = description
      post[:comments] = comments
      post
    end
  end
end
