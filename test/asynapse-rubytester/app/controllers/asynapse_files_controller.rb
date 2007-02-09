require 'json'

class AsynapseFilesController < ApplicationController
  def show
    if params[:id]
      @af = AsynapseFile.find(params[:id])
    elsif params[:name]
      @af = AsynapseFile.find(:first, :conditions=>{:name=>params[:name]})
    end
    
    if !@af
      render :nothing=>true, :status=>404
      return
    end
    
    if params[:column]
      rsp = @af.attributes[params[:column]]
    else
      rsp = @af.attributes
    end
    
    respond_to do |wants|
       wants.html
       wants.xml { render :xml => @af.to_xml }
       wants.js { render :text => "var $_ = " + rsp.to_json }
    end    
  end
end