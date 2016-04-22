class SimulateController < ApplicationController
  def do
    @car = YAML.load(session[:car])
  end

  def turn_lights_on_or_off
    self.do
    @car.lights_toggle
    session[:car] = @car.to_yaml
    redirect_to "/simulate/do"
  end

  def set_parking_brake
    self.do
    @car.parking_brake_toggle
    session[:car] = @car.to_yaml
    redirect_to "/simulate/do"
  end
end
