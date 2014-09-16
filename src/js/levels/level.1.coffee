class Levels.Level1 extends Levels.Base
	
	injectInto: ( gameLevel ) ->
		super( gameLevel )
		
		greenEnemy = new Builder.GreenEnemyPlane()	
		
		s = 1000
		
		@timeline = new Game.Timeline()
		@timeline.add 1 * s, greenEnemy.positionX( 20 ).create()
		@timeline.add 1.1 * s, greenEnemy.positionX( 80 ).create()
		@timeline.add 1.2 * s, greenEnemy.positionX( 140 ).create()
		@timeline.add 1.3 * s, greenEnemy.positionX( 80 ).create()
		@timeline.add 1.4 * s, greenEnemy.positionX( 140 ).create()
		@timeline.add 1.5 * s, greenEnemy.positionX( 200 ).create()
		@timeline.add 1.6 * s, greenEnemy.positionX( 140 ).create()
		@timeline.add 1.7 * s, greenEnemy.positionX( 200 ).create()
		@timeline.add 1.8 * s, greenEnemy.positionX( 260 ).create()
		@timeline.add 1.9 * s, greenEnemy.positionX( 200 ).create()
		@timeline.add 2.0 * s, greenEnemy.positionX( 260 ).create()
		@timeline.add 2.1 * s, greenEnemy.positionX( 320 ).create()
		@timeline.add 5 * s, { spawn: () -> }
			
		@timeline.prepare()
		
	#
	#
	#
	update: ( event ) ->
		if @timeline.update( event ).isDone
			_.defer @gameLevel.finish, 2
		