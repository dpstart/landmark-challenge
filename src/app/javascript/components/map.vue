<template>
    <v-content>
      <v-container fluid fill-height>
        <v-layout align-center justify-center>
          <v-flex xs12 sm12 md6 offset-md1>
            <div class="google-map" :id="mapName"></div>
          </v-flex>
          <v-flex xs12 sm12 md4 offset-md1>

            <v-container
              fluid
              style="min-height: 0;"
              grid-list-lg
            >
              <v-layout row wrap :key="index" v-for="(elem, index) in monumentData">
                <v-flex xs12>
                  <v-card color="blue-grey" class="white--text">
                    <v-card-title primary-title>
                      <div>
                        <h3 class="headline mb-0">{{elem.name}}</h3>
                        <div>{{elem.description}}</div>
                       </div>
                    </v-card-title>
                    <v-card-actions>
                      <v-btn @click="pan(index)">See on map</v-btn>
                      <v-btn :to="{name: 'Landmark', params: {name: elem.name, data: elem}}">Go to page</v-btn>
                    </v-card-actions>
                  </v-card> 
                </v-flex>
              </v-layout>
            </v-container>
          </v-flex>
        </v-layout>
      </v-container>
    </v-content>
</template>

<script>

import { mapGetters } from 'vuex'

//TODO: Sepearate into 2 components, use vuex to communicate.

function getContentString (name, desc) {

    var content = '<div id="content">'+
                  '<div id="siteNotice">'+
                  '</div>'+
                  '<h1 id="firstHeading" class="firstHeading">' + name + '</h1>'+
                  '<br>'+
                  '<div id="bodyContent">'+
                  desc
                  '</div>';

    return content;
  }


export default {
  name: 'google-map',
  props: ['name'],
  data: function () {
    return {
      mapName: this.name + "-map",
      map: null,
      bounds: null,
      markers: [],

      gradient: 'to top right, rgba(63,81,181, .7), rgba(25,32,72, .7)',
    }
  },

  watch: {

    //Watch for changes, then call function to handle map and cards. 
    monumentData: {
      handler:function (newData) {
        this.makeMapAndCards()
      },
      deep:true
    }
  },

  computed: {
    ...mapGetters({
      monumentData: 'getLandmarks'
    })
  },
  methods: {
    pan (index) {
      var center = new google.maps.LatLng(this.monumentData[index].latitude, this.monumentData[index].longitude);
    // using global variable:
      this.map.panTo(center);
      this.map.setZoom(17);

      for(var i = 0 ; i< this.markers.length; i++){
        var infowindow = new google.maps.InfoWindow({
            content: getContentString(this.monumentData[index].name, this.monumentData[index].desc)
           });
        
        if(this.markers[i].getTitle() == this.monumentData[index].name){
          infowindow.open(this.map, this.markers[i]);
          break;
        }
      }
    },

    makeMapAndCards: function () {

      this.bounds = new google.maps.LatLngBounds();
      const element = document.getElementById(this.mapName)
      const mapCentre = {latitude: this.monumentData[0].latitude, longitude: this.monumentData[0].longitude}
      const options = {
        center: new google.maps.LatLng(mapCentre.latitude, mapCentre.longitude)
      }
      this.map = new google.maps.Map(element, options);
      this.monumentData.forEach((data) => {
        const position = new google.maps.LatLng(data.latitude, data.longitude);
        const marker = new google.maps.Marker({ 
          position,
          map: this.map,
          icon: {
            size: new google.maps.Size(55, 55),
            scaledSize: new google.maps.Size(55, 55),
            url: "https://d30y9cdsu7xlg0.cloudfront.net/png/7224-200.png"
          }
        });
        marker.setTitle(data.name);
        this.markers.push(marker)
        this.map.fitBounds(this.bounds.extend(position))
        marker.addListener('click', function() {

            var infowindow = new google.maps.InfoWindow({
              content: getContentString(data.name, data.description)
            });
            infowindow.open(this.map, marker);
          });
      });
    }
  },
  mounted () {
      if (typeof this.monumentData !== 'undefined' && this.monumentData.length > 0) 
        this.makeMapAndCards()
  }
};
</script>
<style scoped>
.google-map {
  width: 800px;
  height: 400px;
  margin: 0 auto;
  background: gray;
}
</style>