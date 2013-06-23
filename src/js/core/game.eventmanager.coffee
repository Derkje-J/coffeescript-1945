# This is the event manager to bind events
#
class Game.EventManager
	
	# Creates a new Event Manager
	#
	constructor : () ->
		@_events = {}
		
		Object.defineProperty( @, 'events',			
			# @property [Array<String>] The events available 
			get: ->
				return _.keys @_events
		)
		
		Object.seal @
		
	# Triggers an event
	#
	# @param event [String] event name
	# @param caller [Object] who triggered the event ( passed as argument )
	# @param args [Array<any>] arguments to pass
	# @return [self] chaining self
	#
	trigger : ( event, caller, args ) ->
		
		if @_events[ event ]?
			trigger = ( element, index, list ) ->
				element[ 1 ].apply( element[ 0 ], _( [ caller ] ).concat args )
			_( @_events[ event ] ).each trigger
			
		return this
		
	# Binds an event (alias for bind)
	#
	# @param event [String] event name
	# @param context [Object] who binds on the event ( passed as this )
	# @param func [Function] the event
	# @return [self] chaining self
	#
	on : ( event, context, func ) ->
		return @bind event, context, func
		
	# Unbinds an event (alias for unbind)
	#
	# @param event [String] event name
	# @param context [Context] context
	# @param func [Function] the event
	# @return [self] chaining self
	#
	off : ( event, context, func ) ->
		return @unbind event, context, func
		
	# Binds an event
	#
	# @param event [String] event name
	# @param context [Context] context
	# @param func [Function] the event
	# @return [self] chaining self
	#
	bind : ( event, context, func ) ->
		unless _( func ).isFunction()
			throw new TypeError 'That is not a function'
		unless @_events[ event ]?
			@_events[ event ] = []
		@_events[ event ].push [ context, func ]
		return this
		
	# Unbinds an event
	#
	# @param event [String] event name
	# @param func [Function] the event
	# @param context [Context] will serve as this
	# @return [self] chaining self
	#
	unbind : ( event, context, func ) ->
		if @_events[ event ]?
			for binding in @_events[ event ] when binding[ 0 ] is context and binding[ 1 ] is func
				@_events[ event ] = _( @_events[ event ] ).without binding
		return this
	
	# Bindings for an event
	#
	# @param event [String] event name
	# @return [Array<Function>] the bindings
	#
	bindings : ( event ) ->
		if ( event? )
			return @_events[ event ] ? []
		return @_events
		
	# Purges all events
	# @return [self] chaining self
	#
	clear: () ->
		@_events = {}
		return this

(exports ? this).Game.EventManager = new Game.EventManager()
