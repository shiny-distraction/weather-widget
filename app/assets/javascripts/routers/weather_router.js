var app = app || {};

$(function() {
    'use strict';

    var Workspace = Backbone.Router.extend({
        routes:{
            '.*': 'index'
        },

        index: function() {
        }
    });

    app.WeatherRouter = new Workspace();

});
