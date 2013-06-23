// Generated by CoffeeScript 1.6.2
(function() {
  Game.EventManager = (function() {
    function EventManager() {
      this._events = {};
      Object.defineProperty(this, 'events', {
        get: function() {
          return _.keys(this._events);
        }
      });
      Object.seal(this);
    }

    EventManager.prototype.trigger = function(event, caller, args) {
      var trigger;

      if (this._events[event] != null) {
        trigger = function(element, index, list) {
          return element[1].apply(element[0], _([caller]).concat(args));
        };
        _(this._events[event]).each(trigger);
      }
      return this;
    };

    EventManager.prototype.on = function(event, context, func) {
      return this.bind(event, context, func);
    };

    EventManager.prototype.off = function(event, context, func) {
      return this.unbind(event, context, func);
    };

    EventManager.prototype.bind = function(event, context, func) {
      if (!_(func).isFunction()) {
        throw new TypeError('That is not a function');
      }
      if (this._events[event] == null) {
        this._events[event] = [];
      }
      this._events[event].push([context, func]);
      return this;
    };

    EventManager.prototype.unbind = function(event, context, func) {
      var binding, _i, _len, _ref;

      if (this._events[event] != null) {
        _ref = this._events[event];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          binding = _ref[_i];
          if (binding[0] === context && binding[1] === func) {
            this._events[event] = _(this._events[event]).without(binding);
          }
        }
      }
      return this;
    };

    EventManager.prototype.bindings = function(event) {
      var _ref;

      if ((event != null)) {
        return (_ref = this._events[event]) != null ? _ref : [];
      }
      return this._events;
    };

    EventManager.prototype.clear = function() {
      this._events = {};
      return this;
    };

    return EventManager;

  })();

  (typeof exports !== "undefined" && exports !== null ? exports : this).Game.EventManager = new Game.EventManager();

}).call(this);