class JobsController < ApplicationController

    #Index Action

    get '/jobs' do
        #@user_jobs = current_user.jobs
        if logged_in?
            @jobs = Job.all
            erb :'jobs/index'
        else
            redirect '/users/login'
        end
    end

    #Jobs related to a Specific User

    get '/jobs/:id/users' do 
        if logged_in?
            @user_jobs = current_user.jobs
            #binding.pry
            erb :'jobs/users'
        end
        #session[:user_id] = @user_jobs.id
    end

    #New Action

    get '/jobs/new' do
        if logged_in?
            erb :'jobs/new'
        else
            redirect '/users/login'
        end
    end

    #Create Action

    post '/jobs' do 
        #@jobs = Job.new(title: params["title"], description: params["desc"], release_date: params["date"], employer: params["employer"], location: params["location"], job_type: params["job_type"])
        @job_postings = current_user.jobs.build(params)        
        
        if @job_postings.save
            redirect "/jobs/#{@job_postings.id}"
        else
            redirect "/users/new"
        end
    end

    #Show action

    get '/jobs/:id' do 
        #set_post
        @jobs = Job.find_by_id(params[:id])
        erb :'jobs/show'
    end

    #Edit Action

    get '/jobs/:id/edit' do 
        @jobs = Job.find_by_id(params[:id])
        erb :'jobs/edit'
    end

    patch '/jobs/:id' do 
        Job.update(params[:id], title: params["title"], description: params["desc"], release_date: params["date"], employer: params["employer"], location: params["location"], job_type: params["job_type"])
        @jobs = Job.find(params[:id])
        redirect "/jobs/#{@jobs.id}"
    end

    #Delete Action
    delete '/jobs/:id' do 
        @jobs = Job.find_by_id(params[:id])
        @jobs.destroy
        redirect "/jobs"
    end

    private

    def set_post
        @jobs = Job.find_by_id(params[:id])
    end

end