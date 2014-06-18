request = require 'request'
fs = require 'fs'
path = require 'path'

# Maximum number of parallel connections
parallelAvail = 10

try
	fs.statSync('./archive')
catch e
	console.log 'Creating archive folder'
	fs.mkdirSync('./archive')

imageURLs = require './index.json'

downloadImage = (i) ->
	url = imageURLs[i]
	console.log 'Starting download of',url
	request { url: url, encoding:'binary' }, (err, resp, data) ->
		return console.error(err)  if err
		fs.writeFile "./archive/" + encodeURIComponent(url.slice(url.lastIndexOf('/')+1)), data, 'binary', (e) ->
			return console.error(e)  if e
			parallelAvail++
			parallelDownload()

parallelDownload = () ->
	if parallelAvail > 0 and imageIndex < imageURLs.length
		parallelAvail--
		downloadImage( imageIndex++ ) 
		parallelDownload()


imageIndex = 0
parallelDownload()