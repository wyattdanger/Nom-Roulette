$ ->

  if ! navigator.geolocation 
    alert 'bro you need geolocation'

  class Noms

    phrases = [
        "Nom on some <em>\#{ this.name }</em>, buddy!"
      , "Break bread at <em>\#{ this.name }</em>, pal."
      , "Chow down at <em>\#{ this.name }</em>, champ!"
      , "Put away some <em>\#{ this.name }</em>, killer!"
      , "Cram some <em>\#{ this.name }</em> in your face."
      , "Demolish some <em>\#{ this.name }</em>, bro."
      , "Gobble up some <em>\#{ this.name }</em>, turkey."
    ]

    constructor: ->
      mapOpts =
        zoom: 11
        mapTypeId: google.maps.MapTypeId.ROADMAP
      @map = new google.maps.Map( document.getElementById('map'), mapOpts )
      @service = new google.maps.places.PlacesService @map
      @text = ($ '#text')
      @infoBox = ($ "#infoBox")
      @getLocation()

    getLocation: =>
      @text.text "Finding your location..."
      navigator.geolocation.getCurrentPosition ( pos ) =>
        [@lat, @lng] = [pos.coords.latitude, pos.coords.longitude]
        @location = new google.maps.LatLng @lat, @lng
        @map.setCenter @location
        @user = new google.maps.Marker
          visible: true
          map: @map
          position: @location
        @setupClient()

    selectRandom: ( data ) ->
      data[ Math.floor(Math.random(data.total)*data.length)]

    template: 
      `function(a,b){return function(c,d){return a.replace(/#{([^}]*)}/g,function(a,e){return Function("x","with(x)return "+e).call(c,d||b||{})})}}`

    searchCallbackHandler: ( data, code ) ->
      nom.draw data

    detailsCallbackHandler: ( info, status) =>
      console.log 'details', info, status
      nom.info info
      @restaurantMarker = new google.maps.Marker
        visible: true
        map: @map
        position: info.geometry.location

    setupClient: ->
      setTimeout =>
        @text.html @text.text() + "<br/>Finding a place to eat..."
        window.searchCallbackHandler = @searchCallbackHandler
        @search()
      , 1000

    search: ->
      @service.search
        location: @location
        radius: 1600
        types: ['restaurant', 'food', 'bar']
        , searchCallbackHandler

    info: ( obj ) ->
      t = @template ($ '#info').text()
      nom.infoBox.html(t obj)

    headline: ( obj ) ->
      console.log obj
      t = @template @selectRandom(phrases)
      nom.text.html(t obj)
      window.detailsCallbackHandler = @detailsCallbackHandler
      @service.getDetails
        reference: obj.reference
        , detailsCallbackHandler

    draw: ( data ) =>
      choice = @selectRandom data
      @headline( choice )

  nom = new Noms

