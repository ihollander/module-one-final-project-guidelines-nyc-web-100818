module DisplayMethods

  def ask(prompt, valid_inputs=[])
    upcased_inputs = valid_inputs.map{|input| input.upcase}
    valid = false
    print CURSOR.save
    until valid
      print CURSOR.restore
      puts prompt
      print "⚡: "
      input = gets.chomp
      if valid_inputs.length == 0 && input.length > 0
        valid = true
      elsif upcased_inputs.include?(input.upcase)
        valid = true
      else
        puts "Invalid input!"
      end
    end
    puts "" # clear the next line...
    input
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

  def display_delimiter_magenta(delimiter, text="")
    colored_delimiter = PASTEL.magenta(delimiter)
    text_offset = (SCREEN_SIZE[1] - text.length) / 2
    lightning_offset = (SCREEN_SIZE[1] - "⚡".length) / 2
    puts " "
    puts "#{colored_delimiter * text_offset}#{text}#{colored_delimiter * text_offset}"
    puts "#{" " * lightning_offset}" + PASTEL.yellow("⚡")
  end

end
