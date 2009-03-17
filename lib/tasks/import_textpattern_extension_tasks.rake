namespace :radiant do
  namespace :extensions do
    namespace :import_textpattern do
      
      desc "Import the contents of the textpattern database into Radiant"
      task :run => :environment do
        TextpatternImport.all
      end
      
      desc "Runs the migration of the Import Textpattern extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          ImportTextpatternExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          ImportTextpatternExtension.migrator.migrate
        end
      end
    end
  end
end
