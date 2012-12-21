var app = app || {};

$(function( $ ) {
    'use strict';

    app.WeatherView = Backbone.View.extend({

        // The default, but just to be clear...
        tagName: 'div',

        // Set the class(es) of this div
        className: 'weather span2 well',

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
            // we must set the ID to later reference this view
            this.$el.attr('id', this.model.id);
            return this;
        },

        refreshWeather: function() {
            this.model.fetch();
        }

    });
});