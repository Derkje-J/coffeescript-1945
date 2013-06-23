'use strict'
#
#
class Game.Container
	
	# Creates a new container
	#
	constructor: ->
	
		@objects = {}
		@container = new createjs.Container()
		
		Object.defineProperties( @, 
			'createjs':
				get: -> return @container
			
			'x':
				get: -> return @_x ? 0
				set: ( value ) -> 
					@_x = value
					@container.x = ( value + .5 )| 0
			
			'y':
				get: -> return @_y ? 0
				set: ( value ) -> 
					@_y = value
					@container.y = ( value + .5 ) | 0
					
			'length':
				get: -> return _( @objects ).keys().length
		)
		
	# Runs every tick and passes down the tick event
	# 
	# @param event [Event] the update event
	# @return [self] the chainable self
	#
	update: ( event ) =>
		for key, object of @objects when object.update?
			object.update event
		return this
		
	#
	#
	#
	input: ( event, state ) =>
		for key, object of @objects when object.input?
			object.input event, state
	
	# Adds an object
	#
	# @param key [String] the id of the object
	# @param object [any] the object
	# @return [self] the chainable self
	#
	add: ( key, object ) ->
	
		if @get( key )?
			throw new Error "There already is an object with that key (#{ key })."
			
		@objects[ key ] = object
		
		@container.addChild object.createjs ? object
		return this
	
	# Removes an object
	#
	# @param key [String] the id of the object
	# @return [self] the chainable self
	#
	remove: ( key ) ->
		return this unless ( object = @get( key ) )?

		@container.removeChild object.createjs ? object
		delete @objects[ key ]
		return this
	
	# Gets an object
	#
	# @param key [String] the id of the object
	# @return [any] the object
	#
	get: ( key ) ->
		return @objects[ key ]
	
		
	# Add to layer
	#
	# @param layer [String] the layer name
	# @param key [String] the key
	# @param object [any] the object
	# @return [self] the chainable self
	#
	addTo: ( layer, key, object ) ->
		( @get layer ).add key, object
		return this
		
		# Gets from layer
	#
	# @param layer [String] the layer name
	# @param key [String] the key
	#
	getFrom: ( layer, key ) ->
		return ( @get layer ).get key
		
	# Remove from layer
	#
	# @param layer [String] the layer name
	# @param key [String] the key
	# @return [self] the chainable self
	#
	removeFrom: ( layer, key ) ->
		( @get layer ).remove key
		return this
	
	#
	#
	findKey: ( search ) ->
		result = null
		_( @objects ).find( ( object, key ) ->
			if object is search
				result = key
				return true
			return false
		)
		
		return result
	
