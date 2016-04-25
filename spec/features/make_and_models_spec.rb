require 'rails_helper'

RSpec.feature "MakeAndModels", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  context "As an internet user" do

    context "when I visit welcome page" do

      before(:each) do
        visit '/car/new_car'
      end

      it "that shows 'Welcome to the Car Simulator'" do
        expect(page).to have_content("Welcome to the Car Simulator")
      end

      it "I am asked for make and model year of the car to be simulated" do
        expect(page).to have_field("make")
        expect(page).to have_field("model_year")
      end

      it "enter make and model year" do
        enter_make_and_model_year
        expect(page).to have_field("make", with: 'Chevrolet')
        expect(page).to have_field("model_year", with: '1967')
      end

      it "can click on a button labeled 'Click for dream car' that takes me to a status page showing make and model year of the car" do
        car_make_and_model_year_creation
        expect(page.current_path).to eq ('/simulate/do')
        expect(page).to have_content("1967 Chevrolet")
      end

    end

    context "when I visit the car status page" do

      before(:each) do
        car_make_and_model_year_creation
      end

      it "for a selected car, it shows whether the lights on the car is on or off. They start off." do
        expect(page).to have_content("Your lights are: Off")
        click_button 'lights'
        expect(page).to have_content("Your lights are: On")
      end

      it "I can see the cars current speed. It starts at zero" do
        car_make_and_model_year_creation
        expect(page).to have_content("Current Speed: 0mph")
      end

      it "I can click on an accelerate button, which makes the car go faster, and which is shown in the car status page" do
        car_make_and_model_year_creation
        click_button 'accelerate'
        expect(page).to have_content("Current Speed: 10mph")
      end

      it "I can click on an brake button, which makes the car go slower, and shows that in the car status page" do
        car_make_and_model_year_creation
        click_button 'accelerate'
        expect(page).to have_content("Current Speed: 10mph")
        click_button 'brake'
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

end
