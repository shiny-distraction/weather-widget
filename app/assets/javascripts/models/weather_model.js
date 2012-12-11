var app = app || {};

$(function() {
    'use strict';

    var WeatherModel = Backbone.Model.extend({
        defaults: {
            current_temp_f: 0,
            wind_speed: 0
        }
    });

    app.WeatherCollection = Backbone.Collection.extend({
        model: WeatherModel,
        url: '/weathers'
    });

});
