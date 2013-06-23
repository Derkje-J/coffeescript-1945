'use strict'
###
  The MIT License

  Copyright (c) 2012 Olaf Horstmann, indiegamr.com ( pixel collision )
  Copyright (c) 2013 Derk-Jan Karrenbeld, derk-jan.com ( fixes, coffeescript and collision manager )

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
###

#
#
class Game.CollisionManager

	#
	#
	@Groups =
		Player: 'player'
		Enemy: 'enemy'
		PlayerBullet: 'player-bullet'
		EnemyBullet: 'enemy-bullet'
		Island: 'island'
		Pieces: 'pieces'
		
	#
	#
	@GridSize = 32

	#
	#
	constructor: () ->
		
		@objects = {}
		@collisions = {}
		
		@addCollision CollisionManager.Groups.Player, CollisionManager.Groups.Enemy
		@addCollision CollisionManager.Groups.PlayerBullet, CollisionManager.Groups.Enemy
		@addCollision CollisionManager.Groups.EnemyBullet, CollisionManager.Groups.Player
		
		# First build the grid
		@_grid = {}
		for x in [0..Game.Canvas1945.Width] by CollisionManager.GridSize
			@_grid[ x ] = {}
			for y in [0..Game.Canvas1945.Height] by CollisionManager.GridSize
				@_grid[ x ][ y ] = {}
				
		@_gridWidth = _( @_grid ).keys().length
		@_gridHeight = _( _( @_grid ).first() ).keys().length
		
		@_setupPixelPerfectCollision()
		
		Game.EventManager.on 'collidable.create', @, ( source, group, object ) => @add group, object
		Game.EventManager.on 'collidable.destroy', @, ( source, group, object ) => @remove group, object

	# Runs every tick and passes down the tick event
	# 
	# @param event [Event] the update event
	# @return [self] the chainable self
	#
	update: ( event ) =>
		return if event.paused
		
		# Fill the grid
		for group, group_objects of @objects
			for object in group_objects
				
				# For each object find the bounding box
				top_left = object.globalize( 0, 0 )
				bottom_right = object.globalize( object.width, object.height )
	
				# Place the objects in the sections where at least one pixel resides
				for i in [ ( ( top_left.x / CollisionManager.GridSize ) | 0 )..(( bottom_right.x / CollisionManager.GridSize ) | 0 )] when 0 < i < @_gridWidth
					x = i * CollisionManager.GridSize
					for j in [ ( ( top_left.y / CollisionManager.GridSize ) | 0 )..(( bottom_right.y / CollisionManager.GridSize ) | 0 )] when 0 < j < @_gridHeight
						y = j * CollisionManager.GridSize
						unless @_grid[ x ][ y ][ group ]?
							@_grid[ x ][ y ][ group ] = []
						@_grid[ x ][ y ][ group ].push object
						
		collided = []
		
		# Hittest the grid
		for x, rows of @_grid
			for y, sections of rows
			
				# Ah, a grid section with more than one group
				if _( sections ).keys().length > 1
					groups = _( sections ).keys()
					for groupa, collisions of @collisions
						if groupa in groups and ( groupb = _( collisions ).find( ( c ) -> c isnt groupa and c in groups ) )?
							
							# Test for collisions!
							left = sections[ groupa ]
							right = sections[ groupb ]
							
							for lefty in left
								continue if lefty in collided
								for righty in right
									break if lefty in collided
									continue if righty in collided
									
									if @_checkPixelCollision lefty.createjs, righty.createjs, 50
										collided.push lefty
										collided.push righty
										
										lefty.collide?( groupb, righty )
										righty.collide?( groupa, lefty )
				
				# Clear grid section
				@_grid[ x ][ y ] = {}

		return this
		
	#
	#
	addCollision: ( groupa, groupb ) ->
		return this if @collisions[ groupb ]? and groupa in @collisions[ groupb ]
		@collisions[ groupa ] = [] unless @collisions[ groupa ]?
		@collisions[ groupa ].push groupb
		return this
		
	#
	#
	removeCollision: ( groupa, groupb ) ->
		if @collisions[ groupa ]?
			@collisions[ groupa ] = _( @collisions[ groupa ] ).without groupb
		if @collisions[ groupb ]?
			@collisions[ groupb ] = _( @collisions[ groupb ] ).without groupa
		return this
		
	# Adds an object
	#
	# @param group [String] the collision group of the object
	# @param object [any] the object
	# @return [self] the chainable self
	#
	add: ( group, object ) ->
		@objects[ group ] = [] unless @objects[ group ]?
		@objects[ group ].push object
		return this
	
	# Removes an object
	#
	# @param group [String] the collision group of the object
	# @param object [any] the object
	# @return [self] the chainable self
	#
	remove: ( group, object ) ->
		@objects[ group ] = _( @objects[ group ] ).without object
		return this
	
	# Clears the collision manager from collidable objects
	#
	clear: () ->
		@objects = {}
		return this
	
	# Setups the pixel perfect collision
	#
	_setupPixelPerfectCollision: () ->
	
		@_collisionCanvasLeft = document.createElement 'canvas'
		@_collisionCanvasLeft.id = "collision-left"
		@_collisionCanvasLeft.setAttribute 'class', 'collision-debug'
		@_collisionCanvasLeft.setAttribute 'width', 3
		@_collisionCanvasLeft.setAttribute 'height', 3
		@_collisionCanvasRight = document.createElement 'canvas'
		@_collisionCanvasRight.id = "collision-right"
		@_collisionCanvasRight.setAttribute 'class', 'collision-debug'
		@_collisionCanvasRight.setAttribute 'width', 3
		@_collisionCanvasRight.setAttribute 'height', 3
		
		( @_collisionContextLeft = @_collisionCanvasLeft.getContext '2d' ).save()
		( @_collisionContextRight = @_collisionCanvasRight.getContext '2d' ).save()
		
		document.body.appendChild @_collisionCanvasLeft
		document.body.appendChild @_collisionCanvasRight
		
		@_cachedBAFrames = []
		return this
		
	# Checks if the bounding boxes collide of left and right
	#
	# @param left [createjs.Bitmap, createjs.BitmapAnimation] the left part of the collision check
	# @param right [createjs.Bitmap, createjs.BitmapAnimation] the right part of the collision check
	#
	# @return [Rectangle] the collision rectangle
	#
	_checkRectCollision: ( left, right ) ->
		return @_calculateIntersection( @_getBounds( left ), @_getBounds( right ) )

	# Checks if pixels collide
	#
	# @param left [createjs.Bitmap, createjs.BitmapAnimation] the left part of the collision check
	# @param right [createjs.Bitmap, createjs.BitmapAnimation] the right part of the collision check
	# @param alphaThreshold [Float] the minumum alpha of a pixel to be collidable
	# @param getRect [Boolean] if true, gets a collision rectangle
	# @param precheck [Boolean] if true, does a distance precheck
	# @param returnflag [Boolean] if true, returns a boolean
	#
	# @return [Boolean, Rectangle] the result
	#
	_checkPixelCollision: ( left, right, alphaThreshold = 0, getRect = false, precheck = off, returnflag = on ) ->

		unless ( not precheck ) or @_collisionDistancePrecheck left, right
			return false
			
		unless ( intersection = @_checkRectCollision left, right )?
			return false
		
		# Resize the canvases
		@_collisionCanvasLeft.width = intersection.width
		@_collisionCanvasLeft.height = intersection.height
		@_collisionCanvasRight.width = intersection.width
		@_collisionCanvasRight.height = intersection.height

		# Get the intersecting image-parts from the bitmaps
		imageDataLeft = @_intersectingImagePart intersection, left, @_collisionContextLeft, 1
		imageDataRight = @_intersectingImagePart intersection, right, @_collisionContextRight, 2

		# Compare the alpha values to the threshold and return the result
		# True if pixels are both > alphaThreshold at one coordinate
		pixelIntersection = @_compareAlphaValues imageDataLeft, imageDataRight, intersection.width, intersection.height, alphaThreshold, getRect
    
		return false unless pixelIntersection
		return true if returnflag
		
		pixelIntersection.x  += intersection.x
		pixelIntersection.x2 += intersection.x
		pixelIntersection.y  += intersection.y
		pixelIntersection.y2 += intersection.y
		return pixelIntersection

	# Does a collision distance precheck
	#
	# @param left [createjs.Bitmap, createjs.BitmapAnimation] the left part of the collision check
	# @param right [createjs.Bitmap, createjs.BitmapAnimation] the right part of the collision check
	#
	# @returns [Boolean] false if not even remotely overlapping
	#
	_collisionDistancePrecheck: ( left, right ) ->
    
		left_topleft = left.localToGlobal 0, 0
		right_topleft = right.localToGlobal 0, 0

		if left instanceof createjs.Bitmap 
			left_rect = 
				width: left.image.width
				height: left.image.height
		else
			left_rect = left.spriteSheet.getFrame( left.currentFrame ).rect
			
		if right instanceof createjs.Bitmap
			right_rect = 
				width: right.image.width
				height: right.image.height
		else 
			right_rect = right.spriteSheet.getFrame( right.currentFrame ).rect
    
		return ( Math.abs( right_topleft.x - left_topleft.x ) < right_rect.width * right.scaleX + left_rect.width * left.scaleX and 
			Math.abs( right_topleft.y - left_topleft.y ) < right_rect.height * right.scaleY + left_rect.height * left.scaleY )

			
	# Finds the image part that is intersecting
	#
	# @param intersection [Rectangle] the rectangle that is the intersection
	# @param bitmap [createjs.Bitmap, createjs.BitmapAnimation] the bitmap
	# @param ctx [Canvas.Context] the context to draw to
	# @param i [Integer] 0 for lefty, 1 for righty
	# @return [Array<Color>] the image data for the intersection
	#
	_intersectingImagePart: ( intersection, bitmap, ctx, i ) ->
		
		if bitmap instanceof createjs.Bitmap
		
			image = bitmap.image
			
		else if bitmap instanceof createjs.BitmapAnimation
		
			frame = bitmap.spriteSheet.getFrame( bitmap.currentFrame )
			frameName = "#{ frame.image.src }:#{ bitmap.currentFrame }:#{ frame.rect.x }:#{ frame.rect.y }:#{ frame.rect.width }:#{ frame.rect.height }"
			unless @_cachedBAFrames[ frameName ]?
				@_cachedBAFrames[ frameName ] = createjs.SpriteSheetUtils.extractFrame bitmap.spriteSheet, bitmap.currentFrame
			image = @_cachedBAFrames[ frameName ]
			
		bl = bitmap.globalToLocal intersection.x, intersection.y 
		ctx.restore()
		ctx.clearRect 0, 0, intersection.width, intersection.height 
		ctx.rotate @_getParentalCumulatedProperty( bitmap, 'rotation' ) * ( Math.PI/180 )
		ctx.scale @_getParentalCumulatedProperty( bitmap, 'scaleX', '*' ), @_getParentalCumulatedProperty( bitmap, 'scaleY', '*' )
		ctx.translate -bl.x - intersection[ 'rect' + i ].regX, -bl.y - intersection[ 'rect' + i ].regY
		ctx.drawImage image, 0, 0, image.width, image.height
		return ctx.getImageData( 0, 0, intersection.width, intersection.height ).data
	
	# Compares the alpha values between two image data arrays
	#
	# @param imageDataLeft [Array<Color>] the image data for the left side
	# @param imageDataRight [Array<Color>] the image data for the right side
	# @param width [Integer] the width of the image data
	# @param height [Integer] the height of the image data
	# @param alphaThreshold [Float] the minimum alpha value for a pixel to be collidable
	# @param getRect [Boolean] if true, gets the entire collision rect
	#
	# @return [Rectangle] the collision rectangle
	#
	_compareAlphaValues: ( imageDataLeft, imageDataRight, width, height, alphaThreshold, getRect ) ->
	
		# Colours consists of r, g, b, a, we need to start at index 3 ( a )
		offset = 3 
		
		pixelRect = 
			x: Infinity
			y: Infinity
			x2: -Infinity
			y2: -Infinity

		# Parsing through the pixels checking for an alpha match
		# @TODO: intelligent parsing, not just from 0 to end!
		for y in [ 0...height ]
			for x in [ 0...width ]
			
				# If this pixel has data
				alpha1 = if imageDataLeft.length > offset + 1 then imageDataLeft[ offset ] else 0
				alpha2 = if imageDataRight.length > offset + 1 then imageDataRight[ offset ] else 0
				
				# Overlapping pixel found?
				if alpha1 > alphaThreshold and alpha2 > alphaThreshold
				
					# Directly return this pixel
					unless getRect
						return { x: x, y: y, width: 1, height: 1 }
						
					# Keep looking for the total overlapping ret
					pixelRect.x = x if x < pixelRect.x
					pixelRect.x2 = x if x > pixelRect.x2 
					pixelRect.y = y if y < pixelRect.y
					pixelRect.y2 = y if y > pixelRect.y2
						
				# Move one pixel up the data stream ( r, g, b, a )
				offset += 4

		# If a overlap was found
		if pixelRect.x != Infinity
			pixelRect.width = pixelRect.x2 - pixelRect.x + 1
			pixelRect.height = pixelRect.y2 - pixelRect.y + 1
			return pixelRect
   
		# Nothing found
		return null

	# Gets the cumulated property from the parent child chain
	#
	# This is needed to paint the intersection part correctly,
	# if the tested bitmap is a child to a rotated/scaled parent
	# 
	# @param child [createjs.DisplayObject] the child
	# @param propName [String] the property
	# @param operation [String] the operation
	# @return [any] the value of the property
	#
	_getParentalCumulatedProperty: ( child, propName, operation = '+' ) ->
		if child.parent and child.parent[ propName ]
			cp = child[ propName ]
			pp = @_getParentalCumulatedProperty child.parent, propName, operation
			if operation is '*'
				return cp * pp;
			return cp + pp;

		return child[ propName ]

	#
	#
	#
	#
	_calculateIntersection: ( left, right ) ->
		# first we have to calculate the
		# center of each rectangle and half of
		# width and height
    
		r1 = {}
		r2 = {}
		
		r1.cx = left.x + ( r1.hw = ( left.width / 2 ) )
		r1.cy = left.y + ( r1.hh = ( left.height / 2 ) )
		r2.cx = right.x + ( r2.hw = ( right.width / 2 ) )
		r2.cy = right.y + ( r2.hh = ( right.height / 2 ) )

		dx = Math.abs( r1.cx - r2.cx ) - ( r1.hw + r2.hw )
		dy = Math.abs( r1.cy - r2.cy ) - ( r1.hh + r2.hh )

		if dx < 0 and dy < 0
		  dx = Math.min( Math.min( left.width, right.width ), -dx )
		  dy = Math.min( Math.min( left.height, right.height ), -dy )
		  return { x: Math.max( left.x, right.x )
				y: Math.max( left.y, right.y )
				width: dx
				height: dy
				rect1: left
				rect2: right }
		return null
		
	#
	#
	_getBounds: ( obj ) ->
		
		bounds =
			x: Infinity
			y: Infinity
			width: 0
			height: 0
			
		if obj instanceof createjs.Container
			bounds.x2 = -Infinity;
			bounds.y2 = -Infinity;
			
			# Expand bounds while iteration children
			for child in obj.children
				cbounds = @_getBounds child
				bounds.x = cbounds.x if cbounds.x < bounds.x
				bounds.y = cbounds.y if cbounds.y < bounds.y;
				bounds.x2 = cbounds.x + cbounds.width if cbounds.x + cbounds.width > bounds.x2
				bounds.y2 = cbounds.y + cbounds.height if cbounds.y + cbounds.height > bounds.y2

			# Retract bounds if not found
			bounds.x = 0 if bounds.x is Infinity
			bounds.y = 0 if bounds.y is Infinity
			if bounds.x2 is -Infinity 
				bounds.x2 = 0
			if bounds.y2 is -Infinity
				bounds.y2 = 0
      
		  bounds.width = bounds.x2 - bounds.x
		  bounds.height = bounds.y2 - bounds.y
		  delete bounds.x2
		  delete bounds.y2
		  return bounds
		  
		if obj instanceof createjs.Bitmap 
			imgr = obj.image
		else if obj instanceof createjs.BitmapAnimation 
			if obj.spriteSheet._frames and obj.spriteSheet._frames[ obj.currentFrame ] and obj.spriteSheet._frames[ obj.currentFrame ].image
			  cframe = obj.spriteSheet.getFrame obj.currentFrame 
			  imgr = cframe.rect
			  imgr.regX = cframe.regX
			  imgr.regY = cframe.regY
			else
			  imgr = {}
			  bounds.x = obj.x ? 0
			  bounds.y = obj.y ? 0
			
		else
			imgr = {}
			bounds.x = obj.x ? 0
			bounds.y = obj.y ? 0

		imgr.regX = imgr.regX ? 0 
		imgr.width = imgr.width ? 0
		imgr.regY = imgr.regY ? 0
		imgr.height = imgr.height ? 0
		bounds.regX = imgr.regX
		bounds.regY = imgr.regY
      
		gp  = obj.localToGlobal 0 - imgr.regX, 0 - imgr.regY
		gp2 = obj.localToGlobal imgr.width - imgr.regX, imgr.height - imgr.regY
		gp3 = obj.localToGlobal imgr.width - imgr.regX, 0 - imgr.regY
		gp4 = obj.localToGlobal 0 - imgr.regX, imgr.height - imgr.regY

		bounds.x = Math.min( Math.min( Math.min( gp.x, gp2.x ), gp3.x ), gp4.x )
		bounds.y = Math.min( Math.min( Math.min( gp.y, gp2.y ), gp3.y ), gp4.y )
		bounds.width = Math.max( Math.max( Math.max( gp.x, gp2.x ), gp3.x ),gp4.x ) - bounds.x
		bounds.height = Math.max( Math.max( Math.max( gp.y, gp2.y ), gp3.y ),gp4.y ) - bounds.y
		return bounds
	
	