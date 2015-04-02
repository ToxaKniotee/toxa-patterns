class StructuralController < ApplicationController
    def adapter
        @rectangle = Rectangle.new(0, 0, 10, 20)
        @area = @rectangle.area
    end

    def bridge
        @book1 = BridgeBookAuthorTitle.new('Larry Truett', 'Ruby for Cats', 'CAPS')
        @book2 = BridgeBookAuthorTitle.new('Larry Truett', 'Ruby for Cats', 'STARS')
        @book3 = BridgeBookTitleAuthor.new('Larry Truett', 'Ruby for Cats', 'CAPS')
        @book4 = BridgeBookTitleAuthor.new('Larry Truett', 'Ruby for Cats', 'STARS')
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

##############################################################################################
# Bridge Classes>
##############################################################################################
class BridgeBook
    def initialize(author, title, choice)
        @author = author
        @title = author
        if 'STARS' == choice
            @bb_imp = BridgeBookStarsImp.new
        else
            @bb_imp = BridgeBookCapsImp.new
        end
    end

    def show_author
        @bb_imp.show_author(@author)
    end

    def show_title
        @bb_imp.show_title(@title)
    end
end

class BridgeBookAuthorTitle < BridgeBook
    def show_author_title
        "#{show_author} 's #{show_title}"
    end
end
 
class BridgeBookTitleAuthor < BridgeBook
    def show_title_author
        "#{show_title} by #{show_author}"
    end
end
 
class BridgeBookImp
end

class BridgeBookCapsImp < BridgeBookImp
    def show_author(author_in)
        author_in.upcase
    end

    def show_title(title_in)
        title_in.upcase
    end
end

class BridgeBookStarsImp < BridgeBookImp
    def show_author(author_in)
        author_in.tr(' ', '*')
    end

    def show_title(title_in)
        title_in.tr(' ', '*')
    end
end
