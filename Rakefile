task :default => :new

require 'fileutils'

desc "New post"
task :new do
  puts "New post URL："
    @url = STDIN.gets.chomp
    puts "New post Title："
    @name = STDIN.gets.chomp
    puts "New post Subtitle："
    @subtitle = STDIN.gets.chomp
    puts "New post Categories，以空格分隔："
    @categories = STDIN.gets.chomp
    puts "New post Tag："
    @tag = STDIN.gets.chomp
    @slug = "#{@url}"
    @slug = @slug.downcase.strip.gsub(' ', '-')
    @date = Time.now.strftime("%F")
    @post_name = "_posts/#{@date}-#{@slug}.md"
    if File.exist?(@post_name)
            abort("Duplicate post name")
    end
    FileUtils.touch(@post_name)
    open(@post_name, 'a') do |file|
            file.puts "---"
            file.puts "layout: post"
            file.puts "title: #{@name}"
            file.puts "subtitle: #{@subtitle}"
            file.puts "author: Lynn"
            file.puts "date: #{Time.now}"
            file.puts "categories: #{@categories}"
            file.puts "tag: #{@tag}"
            file.puts "---"
    end
    exec "vi #{@post_name}"
end