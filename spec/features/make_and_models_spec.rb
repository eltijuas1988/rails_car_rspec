require 'rails_helper'

RSpec.feature "MakeAndModels", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  context "As an internet user" do
    context "when I visit welcome page" do

      it "that shows 'Welcome to the Car Simulator'" do
        visit '/car/new_car'
        expect(page).to have_content("Welcome to the Car Simulator")
      end

      it "I am asked for make and model year of the car to be simulated" do
        visit '/car/new_car'
        expect(page).to have_field("make")
        expect(page).to have_field("model_year")
      end

      it "enter make and model year" do
        visit '/car/new_car'
        enter_make_and_model_year
        expect(page).to have_field("make", with: 'Chevrolet')
        expect(page).to have_field("model_year", with: '1967')
      end

      it "can click on a button labeled 'Click for dream car' that takes me to a status page showing make and model year of the car" do
        visit '/car/new_car'
        enter_make_and_model_year
        click_button 'Click for Dream Car'
        expect(page.current_path).to eq ('/simulate/do')
        expect(page).to have_content("1967 Chevrolet")
      end

      it "for a selected car, it shows whether the lights on the car is on or off. They start off." do
        car_make_and_model_year_creation
        expect(page).to have_content("1967 Chevrolet")
        expect(page).to have_content("Your lights are: Off")
        click_button 'lights'
        expect(page).to have_content("Your lights are: On")
        # @car.lights_toggle
        # expect(page).to have_content("Your lights are: On")
      end

      # Hint: Create a Car class in the models folder with the information from the welcome page and a lights accessor (and underlying instance variable). In the welcome controller, create a car object and store it in the session before redirecting to the simulator."
    end

    context "when I visit the car status page" do
      it "I can see the cars current speed. It starts at zero" do
        car_make_and_model_year_creation
        expect(page).to have_content("Current Speed: 0mph")
      end

      it "I can click on an accelerate button, which makes the car go faster, and which is shown in the car status page" do
        car_make_and_model_year_creation
        click_button 'accelerate'
        # expect(page).to have_selector("p[id='speed']", :text => /\A10mph\Z/)
        expect(page).to have_content("Current Speed: 10mph")
      end

      it "I can click on an brake button, which makes the car go slower, and shows that in the car status page" do
        car_make_and_model_year_creation
        expect(page).to have_content("Current Speed: 0mph")
        click_button 'accelerate'
        expect(page).to have_content("Current Speed: 10mph")
        click_button 'brake'
        expect(page).to have_content("Current Speed: 5mph")
        click_button 'brake'
        expect(page).to have_content("Current Speed: 0mph")
      end

      it "I can set and release the parking brake using radio buttons" do
        car_make_and_model_year_creation
        click_button 'parking_brake'
        click_button 'accelerate'
        expect(page).to have_content("Current Speed: 0mph")
      end

    end

  end

  def enter_make_and_model_year
    visit '/car/new_car'
    within("form#new_car") do
      fill_in("make", with: 'Chevrolet')
      fill_in("model_year", with: '1967')
    end
  end

  def car_make_and_model_year_creation
    enter_make_and_model_year
    click_button 'Click for Dream Car'
    # visit '/simulate/do'
  end


end
