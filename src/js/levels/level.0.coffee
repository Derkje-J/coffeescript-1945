class Levels.Level0 extends Levels.Base
	
	injectInto: ( gameLevel ) ->
		super( gameLevel )
		
		greenEnemy = new Builder.GreenEnemyPlane().randomPosition().keepLooping()
		whiteEnemy = new Builder.WhiteEnemyPlane().randomPosition().keepLooping()
		orangeEnemy = new Builder.OrangeEnemyPlane().randomPosition().keepLooping()
		blueEnemy = new Builder.BlueEnemyPlane().randomPosition().keepLooping()
		limeEnemy = new Builder.LimeEnemyPlane().randomPosition().keepLooping()
		
		for i in [0...10]
			greenEnemy.create()
		for i in [10...20]
			whiteEnemy.create()
		for i in [20...30]
			orangeEnemy.create()
		for i in [30...40]
			blueEnemy.create()
		for i in [40...50]
			limeEnemy.create()
		
		
	planeDestroyed: () ->
		super
		if @enemyCount is 0
			console.log 'done'
		