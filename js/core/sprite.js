// Generated by CoffeeScript 1.6.2
(function() {
  Game.Sprite = (function() {
    Sprite.BaseSheet = new createjs.Bitmap("img/1945.png");

    function Sprite(data) {
      this.spritesheet = new createjs.SpriteSheet(data);
      this.animation = new createjs.BitmapAnimation(this.spritesheet);
      Object.defineProperty(this, 'createjs', {
        get: function() {
          return this.animation;
        }
      });
    }

    return Sprite;

  })();

}).call(this);
