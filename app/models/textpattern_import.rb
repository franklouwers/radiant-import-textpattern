class TextpatternImport
  
  class << self
    attr_accessor :errors
    attr_accessor :pages   
    attr_accessor :users
  end
  
  
  self.errors = {}
  @@errors = {}
  
  #Import the contents of a Textpattern db into radiant
  #
  #Usage:
  #   TextpatternImport.all
  #
  #Notes: 
  #Lots of room here to break this up into smaller chunks of work / methods.
  # 
  # Based on the MephistoImport extension
  
  def self.all
    pages = []
    users = []

    for u in TextpatternUser.find(:all)
      unless user = User.find_by_login(u.name)
        user = u.to_user
        user.save
      end  

      users << user.id
    end

    @published = TextpatternArticle.find_all_published
    @parent    = Page.find_by_title('Articles')
    
    for article in @published
      page = article.to_page
      for c in article.comments
        if c.visible == 1
          comment = c.to_comment
          page.comments << comment
        end 
      end
      page.parent = @parent
      if page.save
          # #see if we have the tags extension loaded
          #       if page.respond_to?(:tag_with)
          #         page.tag_with [article.tag_names].join(',').split(',').uniq.compact.join(';')
          #       end
        pages << page.id
      else
        @@errors[page] = page.errors 
      end
    end
  
  end

end
