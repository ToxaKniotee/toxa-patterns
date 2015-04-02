class StructuralController < ApplicationController
    def adapter
        @rectangle = Rectangle.new(0, 0, 10, 20)
        @area = @rectangle.area
    end
end

##############################################################################################
# Adapter classes:
##############################################################################################
class LegacyRectangle
    def initialize(x1, y1, x2, y2)
        @x1 = x1
        @y1 = y1
        @x2 = x2
        @y2 = y2
    end

    def old_area
        (@x2 - @x1) * (@y2 - @y1)
    end
end

class Rectangle
    def initialize(x, y, w, h)
        @legacy_rectangle = LegacyRectangle.new(x, y, x + w, y + h)
    end

    def area
        @legacy_rectangle.old_area
    end
end
