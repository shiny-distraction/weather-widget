var app = app || {};

$(function( $ ) {
    'use strict';

    app.WeatherAppView = Backbone.View.extend({

        el: '#weatherapp',

        initialize: function() {
            app.weathers.on( 'change', this.render, this );
            app.weathers.on( 'add', this.addOne, this );
            app.weathers.on( 'remove', this.render, this );
            app.weathers.each(this.addOne, this);
            // jquery UI's sortable to allow movement of each weather div
            $('#weathers').sortable({ 
                revert: 200,
                scrollSpeed: 200,
                update: this.changeOrder
            });
        },

        render: function() {
        },

        addOne: function(weather) {
            var view = new app.WeatherView({ model: weather });
            $('#weathers').append(view.render().el);
        },

        changeOrder: function(event, ui) {
            console.log("***changeOrder***");
            var sortedWeatherIds = $(this).sortable('toArray');
            console.log(sortedWeatherIds);
            var sortedWeathers = new Array();
            for (var index=0; index<sortedWeatherIds.length; index++) {
                var w = app.weathers.get(sortedWeatherIds[index]);
                sortedWeathers.push(w);
            }
            console.log(sortedWeathers);

            // TODO need to somehow update the server...
        }

    });
});