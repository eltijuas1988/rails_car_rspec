class CarController < ApplicationController
  def new_car
    if !params.has_key?(:make) || params[:make].strip.empty?
       render "/car/new_car"
    else
      car = Car.new(params[:make], params[:model_year])
      session[:car] = car.to_yaml
      redirect_to "/simulate/do"
    end
  end

  def accelerate
    @car = YAML.load(session[:car])
    if @car.parking_brake_status == "Off"
      @car.accelerate
      session[:car] = @car.to_yaml
      redirect_to "/simulate/do"
    else
      flash[:alert] = "Your Parking Brake is On"
      redirect_to "/simulate/do"
    end
  end

  def brake
    @car = YAML.load(session[:car])
    @car.brake
    session[:car] = @car.to_yaml
    redirect_to "/simulate/do"
  end
end
