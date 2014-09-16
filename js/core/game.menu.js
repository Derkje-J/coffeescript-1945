// Generated by CoffeeScript 1.7.1
(function() {
  'use strict';
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Game.Menu = (function(_super) {
    __extends(Menu, _super);

    function Menu(game) {
      this.game = game;
      this.onProgress = __bind(this.onProgress, this);
      Menu.__super__.constructor.apply(this, arguments);
      this.add('bar', this.bar = new Display.Progress());
      this.bar.x = (Game.Canvas1945.Width - this.bar.width) / 2;
      this.bar.y = (Game.Canvas1945.Height - this.bar.height) / 2;
    }

    Menu.prototype.onProgress = function(event) {
      this.bar.total = event.total;
      return this.bar.current = event.progress;
    };

    return Menu;

  })(Game.Container);

}).call(this);