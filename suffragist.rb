require 'sinatra'
require 'yaml/store'

get '/' do
  erb :index
end

get '/results' do
  hash = {
  }
  @store = YAML::Store.new 'votes.yml'
  @votes = @store.transaction do
    puts  @store['votes'].inspect
    @store['votes'].each do |key, value|
      hash[key.to_sym] = value
    end
    hash
  end
  erb :results
end

post '/cast' do
  @vote = params['vote']
  @store = YAML::Store.new 'votes.yml'
  @store.transaction do
    @store['votes'] ||= {}
    @store['votes'][@vote] ||= 0
    @store['votes'][@vote] += 1
  end
  erb :cast
end

Choices = {
  ham: 'hamburger',
  piz: 'pizza',
  cur: 'curry',
  noo: 'noodles',
}
