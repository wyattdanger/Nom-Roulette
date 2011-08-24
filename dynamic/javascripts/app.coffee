$ ->

  if ! navigator.geolocation 
    alert 'bro you need geolocation'

  textBox = ($ '#text')
  infoBox = ($ "#infoBox")

  class Map
    constructor: ->
      mapOpts =
        zoom: 17
        draggable: false
        disableDoubleClickZoom: true
        disableDefaultUI: true
        mapTypeId: google.maps.MapTypeId.ROADMAP
        scrollwheel: false

      mapStyles = [
        featureType: "all"
        stylers: [
          saturation: -100
        ]
      ]

      mapType = new google.maps.StyledMapType mapStyles,
        name: 'nom'

      @map = new google.maps.Map( document.getElementById('map'), mapOpts )
      @map.mapTypes.set "nom", mapType
      @map.setMapTypeId "nom"
      @service = new google.maps.places.PlacesService @map

    getLocation: =>
      navigator.geolocation.getCurrentPosition ( pos ) =>
        [@lat, @lng] = [pos.coords.latitude, pos.coords.longitude]
        @location = new google.maps.LatLng @lat, @lng
        @setupClient()

    setupClient: ->
      setTimeout =>
        textBox.html "Finding a place to eat..."
        window.searchCallbackHandler = @searchCallbackHandler
        @search()
      , 1000

    addMarker: ( info ) ->
      markerOptions =
        icon: "images/fork.png"
        visible: true
        map: @map
        position: info.geometry.location
      @restaurantMarker = new google.maps.Marker markerOptions
      @map.setCenter info.geometry.location

    search: ->
      @service.search
        location: @location
        radius: 3200
        types: ['restaurant', 'food', 'bar']
        , searchCallbackHandler

    searchCallbackHandler: ( data, code ) ->
      nom.draw data

  class NomsApp

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
      textBox.html "Finding your location..."
      @map = new Map
      @map.getLocation()
      ($ 'h2.tagline').css('cursor','pointer').click =>
        @map.getLocation()

    selectRandom: ( data ) ->
      data[ Math.floor(Math.random(data.total)*data.length)]

    template: 
      `function(a,b){return function(c,d){return a.replace(/#{([^}]*)}/g,function(a,e){return Function("x","with(x)return "+e).call(c,d||b||{})})}}`

    info: ( obj ) ->
      t = @template ($ '#info').text()
      infoBox.html(t obj)
      textBox.find('a').attr('href', obj.url )

    headline: ( obj ) ->
      t = @template @selectRandom(phrases)
      textBox.html(t obj)
      window.detailsCallbackHandler = @detailsCallbackHandler
      @map.service.getDetails
        reference: obj.reference
        , detailsCallbackHandler

    detailsCallbackHandler: ( info, status) =>
      nom.info info
      @map.addMarker info


    draw: ( data ) =>
      choice = @selectRandom data
      @headline( choice )


  nom = new NomsApp


