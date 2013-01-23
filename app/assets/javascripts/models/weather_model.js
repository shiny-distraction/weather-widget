var app = app || {};

$(function() {
    'use strict';

    app.WeatherModel = Backbone.Model.extend({
        defaults: {
            city: null,
            state: null,
            current_temp_f: 0,
            wind_speed: 0
        },

        urlRoot: '/weather_places',

        schema: {
            city: 'Text',
            state: 'Text'
        }
    });

    app.WeatherCollection = Backbone.Collection.extend({
        model: app.WeatherModel,
        urlRoot: '/weather_places'
    });

});
