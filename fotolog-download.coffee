request = require 'request'
fs = require 'fs'
path = require 'path'

try
	fs.statSync('./archive')
catch e
	console.log 'Creating archive folder'
	fs.mkdirSync('./archive')

imageURLs = require './index.json'

for url in imageURLs
	console.log 'Starting download of', url
	request(url).pipe(fs.createWriteStream("./archive/" + encodeURIComponent(url.slice(url.lastIndexOf('/')+1))));