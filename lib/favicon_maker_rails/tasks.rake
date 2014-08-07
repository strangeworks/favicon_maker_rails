require 'favicon_maker'

def say(message)
  puts message unless Rake.application.options.silent
end

namespace :favicon do
  task :generate do
    options = {
      :versions => [
        :apple_152,
        :apple_144,
        :apple_120,
        :apple_114,
        :apple_76,
        :apple_72,
        :apple_60,
        :apple_57,
        :apple,
        :fav_196,
        :fav_160,
        :fav_96,
        :fav_32,
        :fav_16,
        :fav_png,
        :fav_ico,
        :mstile_144
      ],
      :custom_versions => {:apple_extreme_retina => {:filename => "apple-touch-icon-228x228-precomposed.png", :dimensions => "228x228", :format => "png"}},
      :root_dir => Rails.root,
      :input_dir => File.join('app', 'assets', 'images'),
      :base_image => 'favicon-source.png',
      :output_dir => 'public',
      :copy => true
    }

    if File::exists?(File.join('app', 'assets', 'images', 'favicon-source.png'))
      FaviconMaker::Generator.create_versions(options) do |filepath|
        say "Created favicon: #{filepath}"
      end
    else
      say "No source favicon found, please create favicon.png in your app/assets/images directory."
    end
  end
end

desc "Generate favicons from single favicon.png source"
task :favicon => "favicon:generate"
