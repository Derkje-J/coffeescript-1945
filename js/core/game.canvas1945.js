// Generated by CoffeeScript 1.6.2
(function() {
  'use strict';
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Game.Canvas1945 = (function(_super) {
    __extends(Canvas1945, _super);

    Canvas1945.Width = 640;

    Canvas1945.LevelWidth = 640;

    Canvas1945.Height = 480;

    Canvas1945.LevelHeight = 410;

    Canvas1945.ScrollSpeed = 100;

    function Canvas1945() {
      Canvas1945.__super__.constructor.apply(this, arguments);
      this.canvas = this._createCanvas();
      this.stage = this.container = new createjs.Stage(this.canvas);
      this._setTicker();
      this._setInput(this.canvas);
      this._createPersistantData();
      this._createLayers();
      this._createLevel();
      this._createDebug();
      Object.defineProperty(this, 'paused', {
        get: function() {
          return createjs.Ticker.getPaused();
        },
        set: function(value) {
          return createjs.Ticker.setPaused(value);
        }
      });
    }

    Canvas1945.prototype._setTicker = function() {
      createjs.Ticker.addEventListener("tick", this.update);
      createjs.Ticker.useRAF = true;
      createjs.Ticker.setFPS(60);
      return this;
    };

    Canvas1945.prototype._setInput = function(canvas) {
      var _this = this;

      if (canvas == null) {
        canvas = this.canvas;
      }
      canvas.onkeydown = function(event) {
        _this.input(event, true);
        return false;
      };
      canvas.onkeyup = function(event) {
        _this.input(event, false);
        return false;
      };
      return this;
    };

    Canvas1945.prototype._createCanvas = function() {
      var canvas, container;

      canvas = document.createElement('canvas');
      canvas.id = 'game';
      canvas.setAttribute('width', Canvas1945.Width);
      canvas.setAttribute('height', Canvas1945.Height);
      canvas.setAttribute('tabindex', 0);
      container = document.getElementById("container");
      container.appendChild(canvas);
      canvas.onmousedown = function(event) {
        canvas.focus();
        return false;
      };
      return canvas;
    };

    Canvas1945.prototype._createLayers = function() {
      this.add('background', new Game.Container());
      this.add('level', new Game.Container());
      this.add('foreground', new Game.Container());
      this.add('hud', new Game.Container());
      return this;
    };

    Canvas1945.prototype._createLevel = function() {
      this.addLogic('collisions', this.collisions = new Game.CollisionManager());
      this.level = new Game.Level(this);
      return this;
    };

    Canvas1945.prototype._createPersistantData = function() {
      this.lives = 3;
      this.score = 0;
      return this;
    };

    Canvas1945.prototype._createDebug = function() {
      this.addTo('hud', 'fps', new Display.FPS());
      return this;
    };

    Canvas1945.prototype._removeLayers = function() {
      this.remove('hud');
      this.remove('foreground');
      this.remove('level');
      this.remove('background');
      return this;
    };

    Canvas1945.prototype.die = function() {
      if ((--this.lives) > 0) {
        return this.level.restart();
      } else {
        return createjs.Ticker.setPaused(true);
      }
    };

    Canvas1945.prototype.addTo = function(layer, key, object) {
      (this.get(layer)).add(key, object);
      return this;
    };

    Canvas1945.prototype.addLogic = function(key, object) {
      this.objects[key] = object;
      return this;
    };

    Canvas1945.prototype.getFrom = function(layer, key) {
      return (this.get(layer)).get(key);
    };

    Canvas1945.prototype.removeFrom = function(layer, key) {
      (this.get(layer)).remove(key);
      return this;
    };

    Canvas1945.prototype.update = function(event) {
      Canvas1945.__super__.update.call(this, event);
      this.stage.update();
      return this;
    };

    return Canvas1945;

  })(Game.Container);

}).call(this);