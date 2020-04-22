class Book
  attr_accessor :title, :author, :publisher
  @@all_books = []

  def initialize(title, author, publisher)
    @title = title
    @author = author ||= "unknown author"
    @publisher = publisher ||= "unknown publisher"
    @@all_books << self
  end

  def self.return_all_books
    @@all_books
  end
end
