(function(){var a=function(b,c){return function(){return b.apply(c,arguments)}};$(function(){var c,b;if(!navigator.geolocation){alert("bro you need geolocation")}c=(function(){var d;d=["Nom on some <em>#{ this.name }</em>, buddy!","Break bread at <em>#{ this.name }</em>, pal.","Chow down at <em>#{ this.name }</em>, champ!","Put away some <em>#{ this.name }</em>, killer!","Cram some <em>#{ this.name }</em> in your face.","Demolish some <em>#{ this.name }</em>, bro.","Gobble up some <em>#{ this.name }</em>, turkey."];function e(){this.draw=a(this.draw,this);this.detailsCallbackHandler=a(this.detailsCallbackHandler,this);this.getLocation=a(this.getLocation,this);var f;f={zoom:11,mapTypeId:google.maps.MapTypeId.ROADMAP};this.map=new google.maps.Map(document.getElementById("map"),f);this.service=new google.maps.places.PlacesService(this.map);this.text=$("#text");this.infoBox=$("#infoBox");this.getLocation()}e.prototype.getLocation=function(){this.text.text("Finding your location...");return navigator.geolocation.getCurrentPosition(a(function(g){var f;f=[g.coords.latitude,g.coords.longitude],this.lat=f[0],this.lng=f[1];this.location=new google.maps.LatLng(this.lat,this.lng);this.map.setCenter(this.location);this.user=new google.maps.Marker({visible:true,map:this.map,position:this.location});return this.setupClient()},this))};e.prototype.selectRandom=function(f){return f[Math.floor(Math.random(f.total)*f.length)]};e.prototype.template=function(g,f){return function(i,h){return g.replace(/#{([^}]*)}/g,function(j,k){return Function("x","with(x)return "+k).call(i,h||f||{})})}};e.prototype.searchCallbackHandler=function(g,f){return b.draw(g)};e.prototype.detailsCallbackHandler=function(g,f){console.log("details",g,f);b.info(g);return this.restaurantMarker=new google.maps.Marker({visible:true,map:this.map,position:g.geometry.location})};e.prototype.setupClient=function(){return setTimeout(a(function(){this.text.html(this.text.text()+"<br/>Finding a place to eat...");window.searchCallbackHandler=this.searchCallbackHandler;return this.search()},this),1000)};e.prototype.search=function(){return this.service.search({location:this.location,radius:1600,types:["restaurant","food","bar"]},searchCallbackHandler)};e.prototype.info=function(g){var f;f=this.template(($("#info")).text());return b.infoBox.html(f(g))};e.prototype.headline=function(g){var f;console.log(g);f=this.template(this.selectRandom(d));b.text.html(f(g));window.detailsCallbackHandler=this.detailsCallbackHandler;return this.service.getDetails({reference:g.reference},detailsCallbackHandler)};e.prototype.draw=function(g){var f;f=this.selectRandom(g);return this.headline(f)};return e})();return b=new c})}).call(this);