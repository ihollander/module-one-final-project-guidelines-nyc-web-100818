module DisplayMethods

  def ask(prompt, valid_inputs)
    
  end

  def get_center_coordinates(offset_x=0, offset_y=0)
    center_y = (SCREEN_SIZE[0]/2) - offset_y
    center_x = (SCREEN_SIZE[1]/2) - offset_x
    [center_x, center_y]
  end

  def clear_screen
    print CURSOR.clear_screen
    print CURSOR.move_to(0,0)
  end

  def disolve_screen(lines, sleep_time, y_offset=0)
    print CURSOR.move_to(0, 0)
    lines.times do
      print CURSOR.clear_line
      print CURSOR.down(1)
      sleep(sleep_time)
    end
    print CURSOR.move_to(0, y_offset)
  end

end
