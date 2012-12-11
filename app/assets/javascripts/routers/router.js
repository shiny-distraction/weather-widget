var app = app || {};

$(function() {
    'use strict';

    var Workspace = Backbone.Router.extend({
        routes:{
            '.*': 'index'
        },

        index: function() {
            var weather = new app.Weather();
            var view = new app.WeatherView({ model: weather});
            $('#weathers').append(view.render().el);
        }
    });

    app.WeatherRouter = new Workspace();
    Backbone.history.start();

});
