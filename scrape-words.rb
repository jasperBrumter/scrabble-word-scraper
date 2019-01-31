require 'open-uri'
require 'nokogiri'
require 'json'
require 'csv'


def scrapeX(length, pagenumber = 0)
	puts "now scraping #{length} letter words."
	lengthX = []

	url = "https://www.listesdemots.net/mots#{length}lettres.htm"
	html = open(url)
	doc = Nokogiri::HTML(html)

	doc.search('.mot').text.strip.split(" ").each do |word|
		lengthX << word
	end

	unless pagenumber == 0
		(2..pagenumber).each do |index|
			url = "https://www.listesdemots.net/mots#{length}lettrespage#{index}.htm"
			html = open(url)
			doc = Nokogiri::HTML(html)

			doc.search('.mot').text.strip.split(" ").each do |word|
				lengthX << word
			end
		end
	end
	puts "scraped #{lengthX.count} #{length} letter words!"
	return lengthX
end


CSV.open("french_scrabble_words.csv", "w") do |csv|
	csv << scrapeX(2)
	csv << scrapeX(3)
	csv << scrapeX(4,3)
	csv << scrapeX(5,10)
	csv << scrapeX(6,25)
	csv << scrapeX(7,51)
	csv << scrapeX(8,85)
	csv << scrapeX(9,117)
	csv << scrapeX(10,136)
	csv << scrapeX(11,136)
	csv << scrapeX(12,118)
	csv << scrapeX(13,90)
	csv << scrapeX(14,61)
	csv << scrapeX(15,38)
end