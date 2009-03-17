class TextpatternUser < ActiveRecord::Base
  self.abstract_class   = true
  establish_connection :textpattern
  set_table_name       :txp_users
  
  def to_user
    password = 'radiant'
    User.new(
       :login      => name,
       :name       => realname,
       :email      => email,
       :notes      => 'Imported from TextPattern',
       :password   => password,
       :password_confirmation => password
     )
  end
  

end
