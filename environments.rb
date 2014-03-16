configure :development do
  DataMapper.setup(:default, "sqlite://#{Dir.pwd}/db/development.db")
end
