jQuery ->
  $("form#map_search_form").submit ->
    param =  $("form#map_search_form").serialize() 
    console.log param
    $.getJSON "/companies/map.json?"+param, (json) ->
      clearOverlays()
      for c in json.companies
        myLatlng = new google.maps.LatLng(c.lat,c.lng);
        marker = new google.maps.Marker
            position: myLatlng,
            map: map_canvas,
            title: c.name
        window.markersArray.push marker
    return false

clearOverlays = ->
  if window.markersArray
    for i of window.markersArray
      window.markersArray[i].setMap null
