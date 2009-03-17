# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class ImportTextpatternExtension < Radiant::Extension
  version "0.1"
  description "Import the contents of a Textpattern blog into Radiant"
  url "http://github.com/franklouwers/radiant-import-textpattern"
  
  # redirect old style routes to new. Example:
  # OLD:  http://www.beyondthetype.com/2008/1/3/new-rss-feed-url
  # NEW: http://www.beyondthetype.com/articles/2008/01/03/new-rss-feed-url/
  define_routes do |map|
      map.connect '/article/:slug', :controller => 'textpattern', :action => 'redirect'
                
  end

end