class Levels.Endless extends Levels.Base
	
	injectInto: ( gameLevel ) ->
		super( gameLevel )
		
		greenEnemy = new Builder.GreenEnemyPlane().randomPosition().keepLooping().keepRespawning()
		whiteEnemy = new Builder.WhiteEnemyPlane().randomPosition().keepLooping().keepRespawning()
		orangeEnemy = new Builder.OrangeEnemyPlane().randomPosition().keepLooping().keepRespawning()
		blueEnemy = new Builder.BlueEnemyPlane().randomPosition().keepLooping().keepRespawning()
		limeEnemy = new Builder.LimeEnemyPlane().randomPosition().keepLooping().keepRespawning()
		
		for i in [0...10]
			greenEnemy.create().spawn()
		for i in [10...20]
			whiteEnemy.create().spawn()
		for i in [20...30]
			orangeEnemy.create().spawn()
		for i in [30...40]
			blueEnemy.create().spawn()
		for i in [40...50]
			limeEnemy.create().spawn()