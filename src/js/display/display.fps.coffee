'use strict'
#
#
class Display.FPS

	@MaxFPS = 128
	@DebugWidth = 128
	@DebugHeight = 32
	@DebugStep = 4
	
	#
	#
	constructor: ->
	
		@text = new createjs.Text( "?? FPS", "8px Arial", "white" )
		@text.textAlign = 'right'
		@text.x = Game.Canvas1945.Width - 5
		@text.y = 5
		
		Object.defineProperty( @, 'createjs',
			get: -> return @text
		)

		@_frameCount = 0
		@_frameRate = Display.FPS.MaxFPS
		@_time = 0
		
		canvas = document.createElement 'canvas'
		canvas.id = 'fps'
		canvas.setAttribute 'width', Display.FPS.DebugWidth
		canvas.setAttribute 'height', Display.FPS.DebugHeight
		canvas.setAttribute 'style', 'position: fixed; left: 20px; top: 20px; border: 1px dashed rgba( 255, 255, 255, .5 ); padding: 1px;'
		document.body.appendChild canvas
		
		canvasCopyy = document.createElement 'canvas'
		canvasCopyy.setAttribute 'width', Display.FPS.DebugWidth
		canvasCopyy.setAttribute 'height', Display.FPS.DebugHeight
		
		@context = canvas.getContext '2d'
		@context.strokeStyle = 'lime'
		
		@contextCopy = canvasCopyy.getContext '2d'
		
		@_debugTime = 0
		
	#
	#
	update: ( event ) =>
		
		if ( ( @_time += event.delta ) >= 1000 )
		
			# Move the old context left
			@contextCopy.drawImage @context.canvas, 0, 0, Display.FPS.DebugWidth, Display.FPS.DebugHeight, 0, 0, Display.FPS.DebugWidth, Display.FPS.DebugHeight
			@context.clearRect 0, 0, Display.FPS.DebugWidth, Display.FPS.DebugHeight
			@context.drawImage @contextCopy.canvas, Display.FPS.DebugStep, 0, Display.FPS.DebugWidth - Display.FPS.DebugStep, Display.FPS.DebugHeight, 0, 0, Display.FPS.DebugWidth - Display.FPS.DebugStep, Display.FPS.DebugHeight
			@contextCopy.clearRect 0, 0, Display.FPS.DebugWidth, Display.FPS.DebugHeight
			
			# Link old point
			@context.beginPath()
			@context.moveTo Display.FPS.DebugWidth - Display.FPS.DebugStep, ( ( Display.FPS.MaxFPS - Math.min( Display.FPS.MaxFPS, @_frameRate ) ) / Display.FPS.MaxFPS * Display.FPS.DebugHeight + 0.5 ) | 0
			
			# Apply frame rates
			@_frameRate = @_frameCount
			@_frameCount = 0
			@_time -= 1000
			@_debugTime += 1
			@text.text = "#{ @_frameRate } FPS"
			
			# To new point
			@context.lineTo Display.FPS.DebugWidth, ( ( Display.FPS.MaxFPS - Math.min( Display.FPS.MaxFPS, @_frameRate ) ) / Display.FPS.MaxFPS * Display.FPS.DebugHeight + 0.5 ) | 0 
			@context.stroke()
			
			
			
			
		@_frameCount++