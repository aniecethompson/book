class Main
  def self.welcome
    puts 'Welcome to Read It!'.red.bold
    puts 'A magical library where your wildest dreams can come true, just by turning the page on your next quest. Dive into the unknown, your journey awaits...'.yellow
    menu
  end

  def self.menu
    selection = prompt.select('Would you like to search for a new adventure or revist one from the past?', [
                                { name: 'Search New Book', value: 1 },
                                { name: 'View My Library', value: 2 },
                                { name: 'Exit', value: 3 }
                              ])

    if selection == 1
      search_book_title
    elsif selection == 2
      view_library
    elsif selection == 3
      return
    end
  end

  def self.search_book_title
    puts 'Your chariot awaits.'
    search_topic = prompt.ask('Please enter the realm in which you would like to explore...')
    API.search_topic(search_topic)
    @books = Book.return_all_books
    @books.each.with_index(1) { |book, index|
      puts "#{index}. #{book.title} written by #{book.author} published by #{book.publisher}"
    }

    add_book_to_library
  end

  def self.add_book_to_library
    answer = prompt.ask("\nPlease enter the number of the book you would like to add to your library")
    chosen_book = @books[answer.to_i - 1]
    # binding.pry

    Library.create(title: chosen_book.title, author: chosen_book.author, publisher: chosen_book.publisher)

    puts "#{chosen_book.title} has been added to your library!".green.bold
    menu
  end

  def self.view_library
    # View a “Reading List” with all the books the user has selected from their queries -- this is a local reading list and not tied to Google Books’s account features.
    Library.all.each.with_index(1) do |item, i|
      puts "#{i}. #{item.title} written by #{item.author} published by #{item.publisher}"
    end
    menu
  end

  private

  def self.prompt
    prompt = TTY::Prompt.new
  end
end
