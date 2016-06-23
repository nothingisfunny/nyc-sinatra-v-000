class FiguresController < ApplicationController
	get '/figures' do
		erb :'figures/index'
	end

	post '/figures' do
		@figure = Figure.create(name: params["figure"]["name"])
		if params["figure"]["title_ids"]
			params["figure"]["title_ids"].each do |id|
				@figure.titles << Title.find_by(id: id)
			end
		end
		if params["figure"]["landmark_ids"]
			params["figure"]["landmark_ids"].each do |id|
			@figure.landmarks << Landmark.find_by(id: id)
			end
		end
		if !params["title"]["name"].empty?
			if Title.find_by(name: params["title"]["name"])
				@figure.titles << Title.find_by(name: params["title"]["name"])
			else
				@figure.titles << Title.create(name: params["title"]["name"])
			end
		end
		if !params["landmark"]["name"].empty?
			if Landmark.find_by(name: params["landmark"]["name"])
				@figure.landmarks << Landmark.find_by(name: params["landmark"]["name"])
			else
				@figure.landmarks << Landmark.create(name: params["landmark"]["name"])
			end
		end
		@figure.save
		redirect to "/figures/#{@figure.id}"
	end

	get '/figures/new' do
		erb :'figures/new'
	end

	post '/figures/:id' do
		@figure = Figure.find(params[:id])
		@figure.update(params["figure"])

		if !params["title"]["name"].empty?
			if Title.find_by(name: params["title"]["name"])
				@figure.titles << Title.find_by(name: params["title"]["name"])
			else
				@figure.titles << Title.create(name: params["title"]["name"])
			end
		end

		if !params["landmark"]["name"].empty?
			if Landmark.find_by(name: params["landmark"]["name"])
				@figure.landmarks << Landmark.find_by(name: params["landmark"]["name"])
			else
				@figure.landmarks << Landmark.create(name: params["landmark"]["name"])
			end
		end

		@figure.save

		redirect to "/figures/#{@figure.id}"
	end

	get '/figures/:id' do
		@figure = Figure.find(params[:id])
		erb :'figures/show'
	end

	get '/figures/:id/edit' do
		@figure = Figure.find(params[:id])
		erb :'figures/edit'
	end

end