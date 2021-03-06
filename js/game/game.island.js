// Generated by CoffeeScript 1.7.1
(function() {
  'use strict';
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Game.Island = (function(_super) {
    __extends(Island, _super);

    Island.Padding = 50;

    function Island(spritesheet, type) {
      var rel, x, y;
      if (type == null) {
        type = 'A';
      }
      rel = (Math.random() * (Game.Canvas1945.Height / 3 - Island.Padding) + .5) | 0;
      x = Math.random() * Game.Canvas1945.Width;
      y = (function() {
        switch (type) {
          case 'A':
            return rel;
          case 'B':
            return rel + Game.Canvas1945.Height / 3 * 1;
          case 'C':
            return rel + Game.Canvas1945.Height / 3 * 2;
        }
      })();
      Island.__super__.constructor.call(this, spritesheet, x, y, 0, 0);
      this.play('type-' + type);
    }

    Island.prototype.update = function(event) {
      if (event.paused || this.isLevelPaused === true) {
        return this;
      }
      Island.__super__.update.call(this, event);
      if (this.y > Game.Canvas1945.Height + Island.Padding) {
        this.y = -Island.Padding;
        return this.x = Math.random() * Game.Canvas1945.Width;
      }
    };

    return Island;

  })(Game.Movable);

}).call(this);
