// Generated by CoffeeScript 1.7.1
(function() {
  Levels.Base = (function() {
    function Base() {
      this.enemyCount = 0;
      this._isPaused = false;
      Object.defineProperty(this, 'isPaused', {
        get: function() {
          return this._isPaused;
        }
      });
    }

    Base.prototype.pause = function() {
      return this._isPaused = true;
    };

    Base.prototype.resume = function() {
      return this._isPaused = false;
    };

    Base.prototype.injectInto = function(gameLevel) {
      this.gameLevel = gameLevel;
    };

    Base.prototype.planeCreated = function(source) {
      if (source instanceof Game.EnemyPlane) {
        return this.enemyCount++;
      }
    };

    Base.prototype.planeDestroyed = function(source) {
      if (source instanceof Game.EnemyPlane) {
        return this.enemyCount--;
      }
    };

    Base.prototype.update = function(event) {};

    return Base;

  })();

}).call(this);