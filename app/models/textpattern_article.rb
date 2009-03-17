class TextpatternArticle < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "textpattern"
  set_table_name :textpattern
  self.inheritance_column = nil
 
  has_many :comments, :conditions => ["visible = 1"], :class_name => 'TextpatternComment', :foreign_key => 'parentid'        
        
        
#  +-----------------+--------------+------+-----+---------------------+----------------+
  # | Field           | Type         | Null | Key | Default             | Extra          |
  # +-----------------+--------------+------+-----+---------------------+----------------+
  # | ID              | int(11)      |      | PRI | NULL                | auto_increment |
  # | Posted          | datetime     |      | MUL | 0000-00-00 00:00:00 |                |
  # | AuthorID        | varchar(64)  |      |     |                     |                |
  # | LastMod         | datetime     |      |     | 0000-00-00 00:00:00 |                |
  # | LastModID       | varchar(64)  |      |     |                     |                |
  # | Title           | varchar(255) |      | MUL |                     |                |
  # | Title_html      | varchar(255) |      |     |                     |                |
  # | Body            | mediumtext   |      |     |                     |                |
  # | Body_html       | mediumtext   |      |     |                     |                |
  # | Excerpt         | text         |      |     |                     |                |
  # | Excerpt_html    | mediumtext   |      |     |                     |                |
  # | Image           | varchar(255) |      |     |                     |                |
  # | Category1       | varchar(128) |      | MUL |                     |                |
  # | Category2       | varchar(128) |      |     |                     |                |
  # | Annotate        | int(2)       |      |     | 0                   |                |
  # | AnnotateInvite  | varchar(255) |      |     |                     |                |
  # | comments_count  | int(8)       |      |     | 0                   |                |
  # | Status          | int(2)       |      |     | 4                   |                |
  # | textile_body    | int(2)       |      |     | 1                   |                |
  # | textile_excerpt | int(2)       |      |     | 1                   |                |
  # | Section         | varchar(64)  |      |     |                     |                |
  # | override_form   | varchar(255) |      |     |                     |                |
  # | Keywords        | varchar(255) |      |     |                     |                |
  # | url_title       | varchar(255) |      |     |                     |                |
  # | custom_1        | varchar(255) |      |     |                     |                |
  # | custom_2        | varchar(255) |      |     |                     |                |
  # | custom_3        | varchar(255) |      |     |                     |                |
  # | custom_4        | varchar(255) |      |     |                     |                |
  # | custom_5        | varchar(255) |      |     |                     |                |
  # | custom_6        | varchar(255) |      |     |                     |                |
  # | custom_7        | varchar(255) |      |     |                     |                |
  # | custom_8        | varchar(255) |      |     |                     |                |
  # | custom_9        | varchar(255) |      |     |                     |                |
#  | custom_10       | varchar(255) |      |     |                     |                |
#  | uid             | varchar(32)  |      |     |                     |                |
#  | feed_time       | date         |      |     | 0000-00-00          |                |
#  +-----------------+--------------+------+-----+---------------------+----------------+
        
  def to_page
    
    u =  User.find_by_login(authorid)
    
    UserActionObserver.current_user = u
    
    page = Page.new(
      :title           => title,
      :created_at      => lastmod,
      :updated_at      => lastmod,
      :slug            => url_title,
      :status          => Status[:published],
      :breadcrumb      => title,
      :published_at    => posted, 
      :enable_comments => annotate.to_s,
      :keywords        => keywords,
      :created_by   => u,
      :updated_by   => u
    )
    
    page.parts << PagePart.new(:name => 'body',  :filter_id =>  "Textile", :content => body )
    page.parts << PagePart.new(:name => 'intro', :filter_id => "Textile", :content => body.grep(/(.*?)\n\s*\n/))
    
    page
  end

  def self.find_all_published
    find(:all, :conditions => "status = 4")
  end

end
