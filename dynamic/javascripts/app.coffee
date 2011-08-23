$ ->

  if ! navigator.geolocation 
    alert 'fuck'

  class Noms

    phrases = [
        "Nom on some \#{ this.Title }, buddy!"
      , "Break bread at \#{ this.Title }, pal."
      , "Chow down at \#{ this.Title }, champ!"
      , "Put away some \#{ this.Title }, killer!"
      , "Cram some \#{ this.Title } in your face."
      , "Demolish some \#{ this.Title }, bro."
      , "Gobble up some \#{ this.Title }, turkey."
    ]

    constructor: ->
      @text = ($ '#text')
      @infoBox = ($ "#infoBox")
      @getLocation()

    getLocation: =>
      @text.text "Finding your location..."
      navigator.geolocation.getCurrentPosition ( pos ) =>
        [@lat, @lng] = [pos.coords.latitude, pos.coords.longitude]
        @setupClient()

    selectRandom: ( data ) ->
      data[ Math.floor(Math.random(data.total)*data.length)]

    `Noms.prototype.template = function(a,b){return function(c,d){return a.replace(/#{([^}]*)}/g,function(a,e){return Function("x","with(x)return "+e).call(c,d||b||{})})}}`

    setupClient: =>
      @text.text "Finding a place to eat..."


      window.callbackHandler = callbackhandler = ( data, code ) ->
        nom.draw data?.query?.results?.Result

      @search()

    search: ->
      $.getJSON "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20local.search%20where%20latitude%3D'#{ @lat }'%20and%20longitude%3D'#{ @lng }'%20and%20query%3D'restaurant'&format=json&diagnostics=true", callbackHandler

    info: ( obj ) ->
      console.log obj
      t = @template ($ '#info').text()
      nom.infoBox.html(t obj)

    headline: ( obj ) ->
      t = @template @selectRandom(phrases)
      nom.text.text(t obj)
      @info obj

    draw: ( data ) =>
      choice = @selectRandom data
      @headline( choice )

  nom = new Noms

