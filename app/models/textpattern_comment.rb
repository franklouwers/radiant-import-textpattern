class TextpatternComment < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "textpattern"
  set_table_name :txp_discuss
  self.inheritance_column = nil
  
  belongs_to :article, :class_name => 'TextpatternArticle', :foreign_key => 'parentid'

  
  def to_comment
    Comment.new(
       :author       => name,
       :author_url   => web,
       :author_email => email.blank? ? 'anon@anon.com' : email,
       :author_ip    => ip,
       :content      => message,
       :content_html => message,
       :created_at   => posted,
       :updated_at   => posted,
       :user_agent   => "Import from textpattern",
       :referrer     => "Import from textpattern",
       :approved_at  => posted
     ) 
  end
  
end