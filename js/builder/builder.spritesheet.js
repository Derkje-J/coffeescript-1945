// Generated by CoffeeScript 1.6.2
(function() {
  'use strict';
  var __slice = [].slice;

  Builder.SpriteSheet = (function() {
    function SpriteSheet(image) {
      if (image == null) {
        image = Game.AssetManager.get('basesheet').image;
      }
      this.data = {
        images: [image],
        frames: [],
        animations: {}
      };
      Object.defineProperty(this, 'createjs', {
        get: function() {
          return new createjs.SpriteSheet(this.data);
        }
      });
    }

    SpriteSheet.prototype.sequence = function(x, y, w, h, gx, gy, xlen, len) {
      var i, i_x, i_y, sequence, _i;

      if (len == null) {
        len = xlen;
      }
      sequence = [];
      for (i = _i = 0; 0 <= len ? _i < len : _i > len; i = 0 <= len ? ++_i : --_i) {
        i_x = x + ((w + gx) * (i % xlen));
        i_y = y + ((h + gy) * ((i / xlen) | 0));
        sequence.push(this.data.frames.length);
        this.data.frames.push([i_x, i_y, w, h, 0, (w / 2 + .5) | 0, (h / 2 + .5) | 0]);
      }
      return sequence;
    };

    SpriteSheet.prototype.animation = function() {
      var animation, s;

      animation = arguments[0], s = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
      this.data.animations[animation] = {
        frames: this.sequence.apply(this, s),
        next: true,
        frequency: 2
      };
      return this;
    };

    SpriteSheet.prototype.animationExtra = function() {
      var animation, frequency, next, s, _i;

      animation = arguments[0], s = 4 <= arguments.length ? __slice.call(arguments, 1, _i = arguments.length - 2) : (_i = 1, []), next = arguments[_i++], frequency = arguments[_i++];
      this.data.animations[animation] = {
        frames: this.sequence.apply(this, s),
        next: next,
        frequency: frequency
      };
      return this;
    };

    return SpriteSheet;

  })();

}).call(this);
