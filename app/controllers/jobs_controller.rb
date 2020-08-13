class JobsController < ApplicationController

    #Index Action

    get '/jobs' do
        redirect_if_not_logged_in

        @jobs = Job.all
        erb :'jobs/index'
    end

    #Jobs related to a Specific User

    get '/jobs/:id/users' do 
        redirect_if_not_logged_in

        @user_jobs = current_user.jobs
        erb :'jobs/users'
    end

    #New Action

    get '/jobs/new' do
        redirect_if_not_logged_in
        erb :'jobs/new'
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
        if logged_in? && set_user
            @jobs = Job.find_by_id(params[:id])
            erb :'jobs/show'
        else
            redirect '/'
        end
    end

    #Edit Action

    get '/jobs/:id/edit' do 
        if logged_in? && set_user
            @jobs = Job.find_by_id(params[:id])
            erb :'jobs/edit'
        else
            redirect '/'
        end
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

    def set_user
        @current_admin = current_user.jobs.find_by_id(params[:id])
    end

end