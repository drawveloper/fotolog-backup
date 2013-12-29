request = require 'request'
$ = require 'cheerio'
fs = require 'fs'

imageURLs = []
user = process.argv[2]
throw new Error("Usage: coffee fotolog-build-index.coffee <username>") unless user

buildIndexFromPage = (page) ->
	request "http://www.fotolog.com.br/#{user}/mosaic/#{page}", (err, resp, html) ->
		return console.error(err)  if err
		console.log "finished page #{page}... adding images"

		images = $.load(html)("a.wall_img_container img")
		images.map (i,img) ->
			imageURLs.push $(img).attr("src").replace('_t','_f')

		if images.length < 30
			console.log imageURLs
			console.log "got #{imageURLs.length} images"
			fs.writeFileSync('index.json', JSON.stringify(imageURLs))
		else
			buildIndexFromPage(page + 30)

buildIndexFromPage(0)