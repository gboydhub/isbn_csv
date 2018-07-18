require 'csv'
require 'aws-sdk-s3'
require 'json'
require_relative 'isbn.rb'

# unless ARGV[0]
#     puts "Usage app.rb filename"
#     return
# end

# unless File.exist?(ARGV[0])
#     puts "Invalid file: #{ARGV[0]}"
#     return
# end

profile_name = "eponick"
region = "us-east-1"
bucket = "gb-isbn-list"

s3 = Aws::S3::Client.new(profile: profile_name, region: region, access_key_id: 'AKIAJ3AGYODI3EIIJNBQ', secret_access_key: '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')

resp = s3.get_object(bucket: bucket, key: 'isbn_list.csv')
valid_list = []
isbn_list = []
CSV.parse(resp.body, :headers => true) do |row|
    if valid_isbn?(row['ISBN'].to_s)
        valid_list << "valid"
    else
        valid_list << "invalid"
    end
    unless row['ISBN'] == nil
        isbn_list << row['ISBN'].to_s
    else
        isbn_list << ''
    end
end

p isbn_list
p valid_list

pfile = CSV.generate do |csv|
    csv << ["ISBN","VALIDITY"]
    isbn_list.each_with_index do |isbn, index|
        csv << [isbn, valid_list[index]]
    end
end

#obj = s3.bucket.object("isbn_out.csv");
s3.put_object(bucket: bucket, body: pfile, key: "isbn_out.csv")