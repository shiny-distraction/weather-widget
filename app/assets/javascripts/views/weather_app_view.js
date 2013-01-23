var app = app || {};

$(function( $ ) {
    'use strict';

    app.WeatherAppView = Backbone.View.extend({

        el: '#weatherapp',

        events: {
            'click .show_weather_modal': 'showWeatherModal',
            'click .add_weather': 'addWeather',
            'click .refresh_all': 'refreshAll'
        },

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

        showWeatherModal: function() {
            var weatherModel = new app.WeatherModel();
            this.form = new Backbone.Form({
                model: weatherModel
            });
            // horrible hack! probably shouldn't append here, but for now it's awesome!
            $('.weather-form').empty();
            // end horrible hack!
            $('.weather-form').append(this.form.render().el);
            $('#myModal').modal();
        },

        addWeather: function() {
            // this binds the input to the model (held in the form)
            this.form.commit();
            // this saves the model data to the backend
            this.form.model.save();
            // and finally, add the new model to our collection, which will add a new view
            app.weathers.add(this.form.model);
        },

        refreshAll: function() {
            app.weathers.fetch();
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