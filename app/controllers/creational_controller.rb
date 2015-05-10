class CreationalController < ApplicationController
  def builder
    @cook = Cook.new;
    @hawaiian_pizza_builder = HawaiianPizzaBuilder.new;
    @spicy_pizza_builder   = SpicyPizzaBuilder.new;
    @pizzas = Array.new

    @cook.set_pizza_builder(@hawaiian_pizza_builder);
    @cook.construct_pizza();

    @hawaiian = @cook.get_pizza();
    @pizzas << @hawaiian.open();

    @cook.set_pizza_builder(@spicy_pizza_builder);
    @cook.construct_pizza();

    @spicy = @cook.get_pizza();
    @pizzas << @spicy.open();
  end

  def factory
    @factory = ComputerFactory.new
    @laptop = @factory.get_computer('Laptop')
    @desktop = @factory.get_computer('Desktop')
  end

  def prototype
    # Agregamos el nuevo valor agregado por el usuario
    @role = Factory::make_stooge(params[:choice].to_i)
  end

  def singleton
    # Creamos dos clases para ver si resultan ser iguales
    a, b = Klass.instance, Klass.instance
    @result = a == b
    begin
      Klass.new
    rescue
      @error = $!
    end
  end
end

##############################################################################################
# Builder classes:
##############################################################################################
class Pizza
  def set_dough(dough)
    @dough = dough
  end

  def set_sauce(sauce)
    @sauce = sauce
  end

  def set_topping(topping)
    @topping = topping
  end

  def open
    "Pizza with #{@dough} dough, #{@sauce} sauce and #{@topping} topping."
  end
end

class PizzaBuilder
  def get_pizza
    @pizza
  end

  def create_new_pizza
    @pizza = Pizza.new
  end
end

class HawaiianPizzaBuilder < PizzaBuilder
  def build_dough
    @pizza.set_dough('cross')
  end

  def build_sauce
    @pizza.set_sauce('mild')
  end

  def build_topping
    @pizza.set_topping('ham + pinneaple')
  end
end

class SpicyPizzaBuilder < PizzaBuilder
  def build_dough
    @pizza.set_dough('pan baked')
  end

  def build_sauce
    @pizza.set_sauce('hot')
  end

  def build_topping
    @pizza.set_topping('pepperoni + salami')
  end
end

class Cook
  def set_pizza_builder(pb)
    @pizza_builder = pb
  end

  def get_pizza
    @pizza_builder.get_pizza()
  end

  def construct_pizza
    @pizza_builder.create_new_pizza()
    @pizza_builder.build_dough()
    @pizza_builder.build_sauce()
    @pizza_builder.build_topping()
  end
end

##############################################################################################
# Factory classes:
##############################################################################################
class Computer
end

class Laptop < Computer
  def type
    'Laptop'
  end
end

class Desktop < Computer
  def type
    'Desktop'
  end
end

class ComputerFactory
  def get_computer(type)
    if type == "Laptop"
      Laptop.new
    elsif type == "Desktop"
      Desktop.new
    end
  end
end

##############################################################################################
# Prototype classes:
##############################################################################################
class Stooge
end

class Larry < Stooge
  def clone
    Larry.new
  end

  def slap_stick
    'Larry: poke eyes'
  end
end

class Moe < Stooge
  def clone
    Moe.new
  end

  def slap_stick
    'Moe: slap head'
  end
end

class Curly < Stooge
  def clone
    Curly.new
  end

  def slap_stick
    'Curly: suffer abuse'
  end
end

class Factory
  @@s_prototypes = [0, Larry.new, Moe.new, Curly.new]

  def self.make_stooge(choice)
    if choice != nil and choice != 0
      @@s_prototypes[choice].clone
    end
  end
end

##############################################################################################
# Singleton classes:
##############################################################################################
class Klass
  include Singleton
end
