class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  # User Routes

  # Read - Get Request
  get '/users' do
    users = User.all 
    users.to_json(include: [:apods])
  end

  # Read - Get Request
  get '/users/:id' do
    user = User.find(params[:id])
    user.to_json(include: [:apods])
  end

  # Create - Post Request
  post "/users" do
    new_user = User.create({
      first_name: params[:first_name],
      last_name: params[:last_name],
      birth_date: params[:birth_date]
    })
    # new_apod_ids = Apod.select(:id).where("(Date.parse(date)).strftime('%m-%d') == ?", (Date.parse(params[:date])).strftime('%m-%d'))
    # new_apod_ids = Apod.select(:id).where("date[6..10] = ?", (params[:birth_date])[6..10])
    new_apod_ids = Apod.select(:id).where("STRFTIME('%m-%d', date) = ?", (params[:birth_date])[5..9])
    # new_apod_ids = Apod.select(:id).where("STRFTIME('%m-%d', date) = ?", "06-08")
    # new_user.apod_ids << new_apod_ids.map{ |h| h[:id].to_i }
    new_user.apods = Apod.find(new_apod_ids.map{ |h| h[:id].to_i })
    # binding.pry
    new_user.to_json(include: [:apods])
  end

  # Delete - Delete Request
  delete "/users/:id" do
    user = User.find(params[:id])
    # user.user_apods.destroy_all
    UserApod.where(user_id: params[:id]).delete_all
    user.destroy
    user.to_json
  end

  # Read - Get Request
  get '/apods' do
    apods = Apod.all 
    apods.to_json
  end

  # Read - Get Request
  get '/apods/:id' do
    apod = Apod.find(params[:id])
    apod.to_json
  end

end
