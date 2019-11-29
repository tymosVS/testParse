require 'simplecov'
SimpleCov.start

require 'parser'

describe 'Parser' do
  subject { Parser::Parser.new('https://www.instagram.com/p/B4S1VdUJSNe/') }

  it 'check title' do
    expect(subject.title).to match(/Salma Hayek Pinault on Instagram: /)
  end

  it 'video return url to video' do
    expect(subject.video) == ("https://instagram.fozh1-1.fna.fbcdn.net/v/t50.16885-16/10000000_1149370995251379_994998280249887387_n.mp4?_nc_ht=instagram.fozh1-1.fna.fbcdn.net&_nc_cat=103&oe=5DE3A2D6&oh=a585c60667a20220b59d92338dd62af7")
  end

  it 'poster contein url' do
    expect(subject.poster) == ("https://instagram.fozh1-1.fna.fbcdn.net/v/t51.2885-15/e35/p1080x1080/76832283_418929815463688_894344...?_nc_ht=instagram.fozh1-1.fna.fbcdn.net&_nc_cat=104&oh=831fd9f1df3aacda27b73e30e15512c4&oe=5DE32603")
  end

  it 'description in Hash' do
    expect(subject.description).class == Hash
  end

  it 'description contain' do
    keys = [:comments_count, :like_count, :post_author, :post_description]
    expect(subject.description.keys).to contain_exactly(*keys)
  end

  it 'count_review return number' do
    expect(subject.count_review.class).to eq(Integer)
  end

  it 'count_review return number' do
    expect(subject.count_review.class).to eq(Integer)
  end

  it 'comments return Array' do
    expect(subject.comments.class).to eq(Array)
  end

  it 'in array comments conteined Hash' do
    expect(subject.comments[0].class).to eq(Hash)
  end

  it 'in array comments Hash have keys' do
    keys = [:count, :comment_text, :author_id, :is_verified, :avatar_url, :author_name, :has_liked, :likes_count]
    expect(subject.comments[0].keys).to eq(keys)
  end

  it 'in array comments Hash have keys' do
    expect(subject.comments[0][:count].class).to eq(Integer)
  end

  it 'in array comments Hash contain author_id type String' do
    expect(subject.comments[0][:author_id].class).to eq(String)
  end

  it 'in array comments Hash contain author_id not empty' do
    expect(subject.comments[0][:author_id]).not_to be_empty
  end

  it 'in array comments Hash contain avatar_url type String' do
    expect(subject.comments[0][:avatar_url].class).to eq(String)
  end

  it 'in array comments Hash contain avatar_url not empty' do
    expect(subject.comments[0][:avatar_url]).not_to be_empty
  end

  it 'in array comments Hash contain author_name type String' do
    expect(subject.comments[0][:author_name].class).to eq(String)
  end

  it 'in array comments Hash contain author_name type String' do
    expect(subject.comments[0][:author_name].class).to eq(String)
  end

  it 'in array comments Hash contain has_liked not empty' do
    expect(subject.comments[0][:has_liked]).not_to be_empty
  end

  it 'in array comments Hash contain has_liked not empty' do
    expect(subject.comments[0][:has_liked].class).to eq(String)
  end

  it 'in array comments Hash contain likes_count type Integer' do
    expect(subject.comments[0][:likes_count].class).to eq(Integer)
  end

  it 'in array comments Hash contain comment_text type string ' do
    expect(subject.comments[0][:comment_text].class).to eq(String)
  end

  it 'in array comments Hash contain string is_verified' do
    expect(subject.comments[0][:is_verified].class).to eq(String)
  end

  it 'in allPosts return hash' do
    expect(subject.allPosts.class).to eq(Hash)
  end

  it 'in posts Hash have keys' do
    keys = [:title, :count_review, :video, :poster, :description, :comments]
    expect(subject.allPosts.keys).to eq(keys)
  end

  it 'comments in Hash' do
    expect(subject.comments_count).class == Integer
  end
end
