(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  $(function() {
    var Map, map, puts;
    if (!navigator.geolocation) {
      alert('fuck');
    }
    puts = console.log;
    Map = (function() {
      function Map() {
        this.draw = __bind(this.draw, this);
        this.setupClient = __bind(this.setupClient, this);
        this.getLocation = __bind(this.getLocation, this);        this.text = $('#text');
        this.getLocation();
      }
      Map.prototype.getLocation = function() {
        this.text.text("Finding your location...");
        console.log('getLocation');
        return navigator.geolocation.getCurrentPosition(__bind(function(pos) {
          var _ref;
          _ref = [pos.coords.latitude, pos.coords.longitude], this.lat = _ref[0], this.lng = _ref[1];
          return this.setupClient();
        }, this));
      };
      Map.prototype.setupClient = function() {
        var callbackhandler, selectRandom;
        this.text.text("Finding a place to eat...");
        console.log('setupClient');
        this.client = new simplegeo.PlacesClient('JACRMaRvrLkB2xfymFcdqec8myfWuNcE');
        selectRandom = function(data) {
          return data.features[Math.floor(Math.random(data.total) * 26)];
        };
        window.callbackHandler = callbackhandler = function(err, data) {
          var choice;
          choice = selectRandom(data);
          map.text.text("eat at " + choice.properties.name);
          console.log(choice);
          return map.draw(choice.properties);
        };
        return this.client.search(this.lat, this.lng, {
          category: "food"
        }, callbackHandler);
      };
      Map.prototype.draw = function() {
        return console.log("draw");
      };
      return Map;
    })();
    return map = new Map;
  });
}).call(this);
