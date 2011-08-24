$ ->

  if ! navigator.geolocation 
    alert 'bro you need geolocation'

  class Noms

    phrases = [
        "Nom on some <a>\#{ this.name }</a>, buddy!"
      , "Break bread at <a>\#{ this.name }</a>, brother."
      , "Chow down at <a>\#{ this.name }</a>, champ!"
      , "Put away some <a>\#{ this.name }</a>, killer!"
      , "Demolish some <a>\#{ this.name }</a>, bro."
      , "Try out some <a>\#{ this.name }</a>, lil' guy."
      , "Gobble up some <a>\#{ this.name }</a>, turkey."
      , "Stuff your face at <a>\#{ this.name }</a>, dude."
      , "Throw back some <a>\#{ this.name }</a>, boss."
      , "Chew on some <a>\#{ this.name }</a>, chief."
      , "Chew on some <a>\#{ this.name }</a>, you animal."
      , "Chew on some <a>\#{ this.name }</a>, you animal."
    ]

    constructor: ->
      mapOpts =
        zoom: 17
        draggable: false
        disableDoubleClickZoom: true
        disableDefaultUI: true
        mapTypeId: google.maps.MapTypeId.ROADMAP
        scrollwheel: false
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
      @map.setCenter info.geometry.location

    setupClient: ->
      setTimeout =>
        @text.html "Finding a place to eat..."
        window.searchCallbackHandler = @searchCallbackHandler
        @search()
      , 1000

    search: ->
      @service.search
        location: @location
        radius: 3200
        types: ['restaurant', 'food', 'bar']
        , searchCallbackHandler

    info: ( obj ) ->
      t = @template ($ '#info').text()
      nom.infoBox.html(t obj)
      nom.text.find('a').attr('href', obj.url )

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

  ($ 'h2.tagline').css('cursor','pointer').click ->
    location.reload true

