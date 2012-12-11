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
        },

        render: function() {
        },

        addOne: function(weather) {
            var view = new app.WeatherView({ model: weather });
            $('#weathers').append(view.render().el);
        }

    });
});