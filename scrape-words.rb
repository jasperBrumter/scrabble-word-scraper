require 'open-uri'
require 'nokogiri'
require 'json'


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

length2 = scrapeX(2)
length3 = scrapeX(3)
length4 = scrapeX(4,3)
length5 = scrapeX(5,10)
length6 = scrapeX(6,25)
length7 = scrapeX(7,51)
length8 = scrapeX(8,85)
length9 = scrapeX(9,117)
