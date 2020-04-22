class API
  def self.search_topic(search_topic)
    # Search topic and return a list of 5 books matching that query.
    response = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=#{search_topic}&maxResults=5")
    items = response.parsed_response['items']

    # Return book's author, title, and publishing company.
    search_books = items.each do |item|
      title = item['volumeInfo']['title']
      # binding.pry
      # author = item['volumeInfo']['authors'] ? item['volumeInfo']['authors'][0] : nil
      author = item['volumeInfo']['authors'][0] if item['volumeInfo']['authors']
      publisher = item['volumeInfo']['publisher']
      Book.new(title, author, publisher)
    end
  end
end
