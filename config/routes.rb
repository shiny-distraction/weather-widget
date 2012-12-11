WeatherWidget::Application.routes.draw do
  match 'weathers/forecast/:state/:city' => 'weather#forecast'

  match 'weathers/conditions/:state/:city' => 'weather#conditions'

  match 'weathers' => 'weather#index'
end
