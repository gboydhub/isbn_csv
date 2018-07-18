require 'csv'
require_relative 'isbn.rb'

unless ARGV[0]
    puts "Usage app.rb filename"
    return
end

unless File.exist?(ARGV[0])
    puts "Invalid file: #{ARGV[0]}"
    return
end

valid_list = []
isbn_list = []
CSV.foreach(ARGV[0], :headers => true) do |row|
    if valid_isbn?(row['ISBN'])
        valid_list << "valid"
    else
        valid_list << "invalid"
    end
    unless row['ISBN'] == nil
        isbn_list << row['ISBN']
    else
        isbn_list << ''
    end
end

CSV.open('isbn_out.csv', 'wb') do |csv|
    csv << ["ISBN","VALIDITY"]
    isbn_list.each_with_index do |isbn, index|
        csv << [isbn, valid_list[index]]
    end
end