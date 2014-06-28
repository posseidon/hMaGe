namespace :init do

  desc "Create thumbnail from original image"
  task :thumbnail, [:root_folder, :thumbnail_size] do |t, args|
    puts "TODO: Not implemented."
  end

  desc "Load Images from directory recursively into Map Model"
  task :load, [:root_folder] do |t, args|
    Dir["#{args[:root_folder]}/*"].map{|folder|
      Dir["#{folder}/*"].map{|file|
        # Original Image
        if File.file?(file)
          puts "#{file}"
        else # Thumbnail folder
          Dir.glob("#{file}/*.gif") do |thumbnail_file|
            puts thumbnail_file
          end
        end
      }
    }
  end

end
