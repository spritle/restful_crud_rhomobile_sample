require 'rho/rhocontroller'
require 'helpers/browser_helper'


class DeveloperController < Rho::RhoController
  include BrowserHelper

  # GET /Developer
  def index
    puts "Calling Index................"
    response =  Rho::AsyncHttp.get(:url => Rho::RhoConfig.RESTFUL_URL + "developers.json",
    :headers => {"Content-Type" => "application/json"})
    @result = response["body"]
    #@developers1=@result[0]['name']
    #@developers=@result[0]['name']
    #@developers = Developer.find(:all)
    render :back => '/app'
  end

  # GET /Developer/{1}
  def show
    p @params['id'],"-------------"
    @id =@params['id']
    p @id,"-------iiiiid----------"
    #@developer = Developer.find(@params['id'])
    response =  Rho::AsyncHttp.get(:url => Rho::RhoConfig.RESTFUL_URL + "developers/"+@id+".json",
    :headers => {"Content-Type" => "application/json"})
    @result = response["body"]

    p @result,"*********ressuisuos" 
  end

  # GET /Developer/new
  def new
    @developer = Developer.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Developer/{1}/edit
  def edit
    p "============================"
    id =@params['developer_id'].to_s
    response =  Rho::AsyncHttp.get(:url => Rho::RhoConfig.RESTFUL_URL + "developers/#{id}.json",
    :headers => {"Content-Type" => "application/json"})
    @result = response["body"]

    p @result,"----------------ressssssss---"
  end

  # POST /Developer/create
  def create
    p @params,"-----------------"
    p @params['developer']['name'],"--------------name-----"
    name=@params['developer']['name']
    role=@params['developer']['role']
    p name,role,"********************"
    #@developer = Developer.create(@params['developer'])
    @body = '{"developer" : {"name" : "'+name+'","role" :"'+role+'"  } }'
    puts @body,"-----------body-------------"
    @result =  Rho::AsyncHttp.post(:url => Rho::RhoConfig.RESTFUL_URL + "developers.json",
    :body => @body, :http_command => "POST", :headers => {"Content-Type" => "application/json"})  
    redirect :action => :index
  end

  # POST /Developer/{1}/update
  def update
    p @params,"-------------update"
    name=@params['developer']['name']
    role=@params['developer']['role']
    p name,role,"****************uuuuuuuuuuu****"
    @body = '{"developer" : {"name" : "'+name+'","role" :"'+role+'"  } }'
    id = @params["developer_id"].to_s

    response =  Rho::AsyncHttp.post(:url => Rho::RhoConfig.RESTFUL_URL + "developers/#{id}.json",
    :body => @body, :http_command => "PUT",:headers => {"Content-Type" => "application/json"})
    
    puts "----------------update success ---------"
    #@developer = Developer.find(@params['id'])
    #@developer.update_attributes(@params['developer']) if @developer
    redirect :action => :index
  end

  # POST /Developer/{1}/delete
  def delete
    # @developer = Developer.find(@params['id'])
    # @developer.destroy if @developer
    id = @params["developer_id"].to_s
    response =  Rho::AsyncHttp.post(:url => Rho::RhoConfig.RESTFUL_URL + "developers/#{id}.json",
    :http_command => "DELETE", 
    :headers => {"Content-Type" => "application/json"})  
    redirect :action => :index  
  end
end
