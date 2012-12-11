WeatherWidget::Application.routes.draw do
  match 'weather/forecast/:state/:city' => 'weather#forecast'

  match 'weather/conditions/:state/:city' => 'weather#conditions'
end
