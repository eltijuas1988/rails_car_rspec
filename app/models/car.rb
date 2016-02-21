class Car
  def initialize(make, model_year)
    @lights = false
    @make = make
    @model_year = model_year
    @speed = 0
    @parking_brake = false
  end

  def show_car
    @model_year + " " + @make
  end

  def lights_toggle
      @lights = !@lights
  end

  def show_lights
    if @lights
      "On"
    else
      "Off"
    end
  end

  def parking_brake_toggle
    @parking_brake = !@parking_brake
  end

  def parking_brake_status
    if @parking_brake
      "On"
    else
      "Off"
    end
  end

  def accelerate
    @speed += 10
  end

  def brake
    if @speed <= 0
      @speed = 0
    else
      @speed -= 5
    end
  end

  def speed
    @speed
  end

end
