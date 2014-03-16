# main.rb
require 'rubygems'
require 'sinatra'
require 'data_mapper'
require './environments'
require './models/model'
require 'sinatra/form_helpers'
require './helpers/helper'

enable :sessions
set :session_secret, '*&(^B2345'
set :partial_template_engine, :erb

before do
    @current_user ||= User.get(session[:user_id]) if session[:user_id]
end

get '/' do
    erb :index
end

get '/signup' do
    erb :signup
end

get '/logout' do
    session.clear
    redirect '/'   
end


post '/signup' do
    @user= User.new(params[:user])
    if @user.save
        loginUser(@user)
        redirect '/'
    else
        redirect "/signup"
    end
end

get '/index' do
    erb :index
end
