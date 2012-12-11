var app = app || {};

$(function() {
    'use strict';

    app.Weather = Backbone.Model.extend({

        paramRoot: 'weather',

        url: '/weather',

        defaults: {
            current_temp_f: 0,
            wind_speed: 0
        }

    });

});
