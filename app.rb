require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'
require 'pg'

before do
	@db = PG.connect(dbname: 'memetube', host: 'localhost')
end

after do
	@db.close
end

 get '/' do
	if params[:task]
		sql = "insert into tasks(item) values('#{params[:task]}')"
		@db.exec(sql)
	end


	sql = "select * from tasks"

	@tasks = @db.exec(sql)

		# binding.pry
	@header = 'index'
	erb :index



  redirect to '/index'

  erb :index
end

get '/index' do
	sql = 'select * from video'
	@videos = @db.exec(sql)

	erb :index
end


get '/add_video' do
	

	@header = 'Add a video'
	sql = "insert into video(title, url) values(#{params[:title]}, #{params[:url]})"

	erb :add_video

end


