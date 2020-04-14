require_relative '../config/environment'
require 'pry'
require 'colorize'
require "tty-prompt"
require "httparty"
class Main

    def self.welcome
        puts "Welcome to Read It!".red.bold
        sleep(1)
        puts "A magical library where your wildest dreams can come true, just by turning the page on your next quest. Dive into the unknown, your journey awaits...".yellow
        sleep(2)
        menu
    end 

    def self.menu
        selection = prompt.select("Would you like to search for a new adventure or revist one from the past?",[
            {name: 'Search New Book', value: 1},
            {name: 'View My Library', value: 2},
            {name: 'Exit', value: 3}
        ])

        if selection == 1
            search_book_title
        elsif selection == 2
            view_library
        else selection == 3
            return
        end
    end 

    def self.search_book_title
        puts "Your chariot awaits."
        sleep(1)
        puts "Please enter the realm in which you would like to explore...".blue.bold
        
        # Search topic and return a list of 5 books matching that query.
        search_topic = STDIN.gets.chomp
        response = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=#{search_topic}&maxResults=5")
        items = response.parsed_response['items']
        
        # Return book's author, title, and publishing company.
        @books = {}
        count = 1
        search_books = items.each_with_index do |item, i|
            @books[i+1] ||= {}
            @books[i+1] = {
                    title: item["volumeInfo"]["title"],
                    author: item["volumeInfo"]["authors"][0], 
                    publisher: item["volumeInfo"]["publisher"]
                }     
            
            
        puts "#{i + 1}. #{item["volumeInfo"]["title"]} written by #{item["volumeInfo"]["authors"][0]} published by #{item["volumeInfo"]["publisher"]}"
        end
        
        sleep(5)
    
        add_book_to_library
    end

    def self.add_book_to_library
        puts "Please enter the number of the book you would like to add to your library".blue.bold
        answer = STDIN.gets.chomp
        Library.create(title: @books[answer.to_i][:title], author: @books[answer.to_i][:author], publisher: @books[answer.to_i][:publisher])
        
        puts "#{@books[answer.to_i][:title]} has been added to your library!".green.bold
        sleep(2)
        menu
    end

    def self.view_library
        # View a “Reading List” with all the books the user has selected from their queries -- this is a local reading list and not tied to Google Books’s account features.
        Library.all.each_with_index do |item, i|
            puts "#{i + 1}. #{item.title} written by #{item.author} published by #{item.publisher}"
        
        end
        menu
    end

    private
    
    def self.prompt
        prompt = TTY::Prompt.new

    end

end

