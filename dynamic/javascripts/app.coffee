$ ->

  if ! navigator.geolocation 
    alert 'fuck'

  class Map
    constructor: ->
      @text = ($ '#text')
      @getLocation()

    getLocation: =>
      @text.text "Finding your location..."
      console.log 'getLocation'
      navigator.geolocation.getCurrentPosition ( pos ) =>
        [@lat, @lng] = [pos.coords.latitude, pos.coords.longitude]
        console.log @lat, @lng
        @setupClient()

    selectRandom: ( data ) ->
      data[ Math.floor(Math.random(data.total)*data.length)]

    `Map.prototype.template = function(a,b){return function(c,d){return a.replace(/#{([^}]*)}/g,function(a,e){return Function("x","with(x)return "+e).call(c,d||b||{})})}}`

    setupClient: =>
      @text.text "Finding a place to eat..."
      console.log 'setupClient'


      window.callbackHandler = callbackhandler = ( data, code ) ->
        console.log data, code
        map.draw data?.query?.results?.Result

      @search()

    search: ->
      $.getJSON "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20local.search%20where%20latitude%3D'#{ @lat }'%20and%20longitude%3D'#{ @lng }'%20and%20query%3D'restaurant'&format=json&diagnostics=true", callbackHandler

    draw: ( data ) =>
      choice = @selectRandom data
      map.text.text "eat at #{ choice.Title }"
      console.log choice
      console.log "draw"

  map = new Map

