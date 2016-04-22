Rails.application.routes.draw do

  get 'simulate/do'

  get 'car/new_car'

  get 'car/accelerate'

  get 'car/brake'

  get 'simulate/turn_lights_on_or_off'

  get 'simulate/set_parking_brake'

  root 'car#new_car'

end
