'use strict'
#
#
class Game.AssetManager

	# Creates a new AssetManager
	#
	constructor: ->
		@preload = new createjs.LoadQueue()
		@preload.setMaxConnections 5
		
		@preload.loadFile { id: 'basesheet', src: "img/1945.png" }, false
		@preload.loadFile { id: 'bottom', src: "img/1945.bottom.gif" }, false
		@preload.loadFile { id: 'shards', src: "img/1945.shards.png" }, false
		
		@objects = {}
		
	# Starts loading all the assets
	#
	# @param callback [Function] the function to run after loading is complete
	# @return [self] the chainable self
	#
	load: ( callback ) ->
		@preload.addEventListener "complete", callback
		@preload.addEventListener "fileload", @_onload
		@preload.addEventListener "progress", @_onprogress
		@preload.load()
		return this
		
	# On file loaded
	#
	# @param event [FileLoadEvent] the event 
	#
	_onload: ( event ) =>
		switch event.item.type
			when createjs.LoadQueue.IMAGE
				@objects[ event.item.id ] = new createjs.Bitmap event.result
	
	# On total progress
	#
	# @param event [ProgressEvent] the event
	#
	_onprogress: ( event ) =>
		#console.log event.progress, event.loaded, event.total
	 
	# Gets the asset
	#
	# @param id [String] the asset id
	# @return [any] the asset
	#
	get: ( id ) ->
		return @objects[ id ]
		
( exports ? this ).Game.AssetManager = new Game.AssetManager()