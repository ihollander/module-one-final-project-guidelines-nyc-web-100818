class House < ActiveRecord::Base
  has_many :characters

  def display_info
    house_color_split = self.color.split(" & ")
    case house_color_split[0]
      when "Scarlet"
        print "Your House colors are " + PASTEL.black.on_red(house_color_split[0]) + " & " + PASTEL.red.on_yellow(house_color_split[1])
      when "Green"
        print "Your House colors are " + PASTEL.black.on_green(house_color_split[0]) + " & " + PASTEL.black.on_white(house_color_split[1])
      when "Blue"
        print "Your House colors are " + PASTEL.on_blue(house_color_split[0]) + " & " + PASTEL.black.on_yellow(house_color_split[1])
      else
        print "Your House colors are " + PASTEL.black.on_yellow(house_color_split[0]) + " & " + PASTEL.black.on_white(house_color_split[1])
    end
  end
end
