require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'json'


class DeveloperController < Rho::RhoController
  include BrowserHelper

  # GET /Developer
  def index
    response =  Rho::AsyncHttp.get(:url => Rho::RhoConfig.RESTFUL_URL + "developers.json",
     :headers => {"Content-Type" => "application/json"})
     @result = response["body"] 
     
    render :back => '/app'
  end

  # GET /Developer/{1}
  def show
    id =@params['id']
    response =  Rho::AsyncHttp.get(:url => Rho::RhoConfig.RESTFUL_URL + "developers/"+ id +".json",
    :headers => {"Content-Type" => "application/json"})
    
    @result = response["body"]
  end

  # GET /Developer/new
  def new
    @developer = Developer.new
    
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Developer/{1}/edit
  def edit
    id =@params['developer_id'].to_s
    response =  Rho::AsyncHttp.get(:url => Rho::RhoConfig.RESTFUL_URL + "developers/#{id}.json",
    :headers => {"Content-Type" => "application/json"})
    
    @result = response["body"]
  end

  # POST /Developer/create
  def create
    name = @params['developer']['name']
    role = @params['developer']['role']
    body = '{"developer" : {"name" : "'+ name +'","role" :"'+ role +'"  } }'

    @result =  Rho::AsyncHttp.post(:url => Rho::RhoConfig.RESTFUL_URL + "developers.json",
    :body => body, :http_command => "POST", :headers => {"Content-Type" => "application/json"})  

    redirect :action => :index
  end

  # POST /Developer/{1}/update
  def update

    name=@params['developer']['name']
    role=@params['developer']['role']
    
    body = '{"developer" : {"name" : "' + name + '","role" :"' + role + '"  } }'
    id = @params["developer_id"].to_s

    response =  Rho::AsyncHttp.post(:url => Rho::RhoConfig.RESTFUL_URL + "developers/#{id}.json",
    :body => body, :http_command => "PUT",:headers => {"Content-Type" => "application/json"})
    
    redirect :action => :index
  end

  # POST /Developer/{1}/delete
  def delete
    id = @params["developer_id"].to_s
    response =  Rho::AsyncHttp.post(:url => Rho::RhoConfig.RESTFUL_URL + "developers/#{id}.json",
    :http_command => "DELETE", 
    :headers => {"Content-Type" => "application/json"})  
    
    redirect :action => :index  
  end
end
