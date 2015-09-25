require_relative "baristomatic"

baristomatic = Baristomatic.new
while true
  puts baristomatic
  choice = gets
  if choice =~ /^q$/i
    break
  elsif choice =~ /^r$/i
    baristomatic.restok
  elsif drink = baristomatic.drink(choice.to_i)
    if baristomatic.dispense(drink)
      puts "Dispensing: #{drink}"
    else
      puts "Out of stock: #{drink}"
    end
  else
    puts "Invalid selection: #{choice}"
  end
end
