class LandmarksController < ApplicationController
	get '/landmarks' do
		erb :'landmarks/index'
	end

	get '/landmarks/new' do
		erb :'landmarks/new'
	end

	post '/landmarks' do
		@landmark = Landmark.create(params["landmark"])
		redirect_to "/landmarks/#{@landmark.id}"
	end

	get '/landmarks/:id/edit' do
		@landmark = Landmark.find_by(params[:id])
		erb :'landmarks/edit'
	end

	post '/landmarks/:id' do
		@landmark = Landmark.find_by(params[:id])
		@landmark.update(params["landmark"])
		redirect_to "/landmarks/#{@landmark.id}"
	end

	get '/landmarks/:id' do
		@landmark = Landmark.find_by(params[:id])
		erb :'landmarks/show'
	end

	
end
