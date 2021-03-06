class TranslationsController < ApplicationController
  def new
    resource_type = params[:resource_type].constantize

    @resource = params[:resource_id] == 0.to_s ? resource_type.new : resource_type.find(params[:resource_id])
    @translation = @resource.translations.build :locale => params[:target_locale]
    @locale = params[:target_locale]

    respond_to do |format|
      format.html { render :layout => "ajax" }
      format.json { render json: @resource }
    end
  end

  def resource
    @resource
  end

  helper_method :resource
end
