namespace :init do

  desc "Create thumbnail from original image"
  task :thumbnail, [:root_folder, :thumbnail_size] do |t, args|
    puts "TODO: Not implemented."
  end

  desc "Load Images from directory recursively into Map Model"
  task :load, [:root_folder] => :environment do |t, args|
    # Run with  rake init:load["/home/ntb/Downloads/source_images"]
    Dir["#{args[:root_folder]}/*"].map{|folder|
      Dir["#{folder}/*"].map{|file|
        if File.file?(file)
          map = Map.new(:name => '', :path => file)
          map.image = File.new(file)
          map.image.reprocess!
          map.save!
        end
        #else # Thumbnail folder
        #  Dir.glob("#{file}/*.gif") do |thumbnail_file|
        #    puts thumbnail_file
        #  end
        #end
      }
    }
  end

end
