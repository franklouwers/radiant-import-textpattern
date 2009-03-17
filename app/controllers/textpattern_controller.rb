class TextpatternController < ActionController::Base
  
  def redirect
    page = Page.find_by_slug(params[:slug])
    url = page.url
    redirect_to url_for(page.url), :status=>:moved_permanently
  end
  
end