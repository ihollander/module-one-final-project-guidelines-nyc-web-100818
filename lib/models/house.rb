class House < ActiveRecord::Base
  has_many :characters

  def display_info
    intro_array = []
    intro_array << "\nCongratulations! You have been sorted into #{self.name} House!"
    intro_array << "\n#{self.founder} founded the House hoping to find young wizards that have #{self.values}."
    intro_array << "\nYour Head of House is #{self.head_of_house}.\nYour House ghost is #{self.house_ghost}."
    intro_array << display_house_colors
    intro_array.each do |line|
      puts line
      sleep(SLEEP_TIME)
    end

  end

  def display_house_colors
    house_color_split = self.color.split(" & ")
    house_colors = ""
    case house_color_split[0]
      when "Scarlet"
        house_colors = "Your House colors are " + PASTEL.black.on_red(house_color_split[0]) + " & " + PASTEL.red.on_yellow(house_color_split[1])
      when "Green"
        house_colors = "Your House colors are " + PASTEL.black.on_green(house_color_split[0]) + " & " + PASTEL.black.on_white(house_color_split[1])
      when "Blue"
        house_colors = "Your House colors are " + PASTEL.on_blue(house_color_split[0]) + " & " + PASTEL.black.on_yellow(house_color_split[1])
      else
        house_colors = "Your House colors are " + PASTEL.black.on_yellow(house_color_split[0]) + " & " + PASTEL.black.on_white(house_color_split[1])
    end
  end
end
