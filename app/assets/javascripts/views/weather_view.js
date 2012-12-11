var app = app || {};

$(function( $ ) {
    'use strict';

    app.WeatherView = Backbone.View.extend({

        tagName: 'div',

        template: JST["templates/weather"],

        events: {
            'click .refresh': 'refreshWeather'
        },

        initialize: function() {
            this.model.on( 'change', this.render, this );
            this.model.on( 'add', this.render, this );
        },

        render: function() {
            this.$el.html( this.template( this.model.toJSON() ) );
            return this;
        },

        refreshWeather: function() {
            this.model.fetch();
        }

    });
});