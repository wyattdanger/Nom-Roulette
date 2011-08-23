$ ->

  if ! navigator.geolocation 
    alert 'fuck'

  puts = console.log

  class Map
    constructor: ->
      @text = ($ '#text')
      @getLocation()

    getLocation: =>
      @text.text "Finding your location..."
      console.log 'getLocation'
      navigator.geolocation.getCurrentPosition ( pos ) =>
        [@lat, @lng] = [pos.coords.latitude, pos.coords.longitude]
        @setupClient()

    setupClient: =>
      @text.text "Finding a place to eat..."
      console.log 'setupClient'
      @client = new simplegeo.PlacesClient 'JACRMaRvrLkB2xfymFcdqec8myfWuNcE'

      selectRandom = ( data ) ->
        data.features[ Math.floor(Math.random(data.total)*26)]

      window.callbackHandler = callbackhandler = ( err, data ) ->
        choice = selectRandom data
        map.text.text "eat at #{ choice.properties.name }"
        console.log choice
        map.draw choice.properties

      @client.search @lat, @lng, { category: "food" }, callbackHandler

    draw: =>
      console.log "draw"



  map = new Map

