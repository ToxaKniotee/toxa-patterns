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
        @laptop = @factory.getComputer('Laptop')
        @desktop = @factory.getComputer('Desktop')
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
    def getComputer(type)
        if type == "Laptop"
            Laptop.new
        elsif type == "Desktop"
            Desktop.new
        end
    end
end
