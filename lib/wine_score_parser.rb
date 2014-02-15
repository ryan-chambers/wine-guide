# coding: utf-8

require 'open-uri'
require 'grape.rb'
require 'country.rb'
require 'wine.rb'
require 'bottle.rb'

class WineVO
  def initialize
    @grapes = []
    @other = []
    @region = ''
    @lcbo = ''
    @country
  end

  attr_accessor :winery_name, :other, :year, :region, :grapes, :lcbo, :country, :grapes

  def create_wine_from_values(winery)
    wine = Wine.new
    wine.winery = winery
    wine.country = @country
    wine.lcbo_code = @lcbo
    wine.region = @region
    wine.year = @year
    wine.other = @other.sort!.join(', ')
    @grapes.each do | grape |
      wine.grapes << Grape.where(:name => grape)
    end

    wine.save!
    p "Stored new wine #{wine.to_s}."
    wine
  end

  def store
    winery = Winery.find_by_name @winery_name
    if !winery
      winery = Winery.new
      winery.name = @winery_name
      winery.save!
      p "Saved new winery #{@winery_name}"
    end

    wine = Wine.find_by_winery_year_lcbo_code(winery.id, @year, @lcbo)
    if wine && wine.length > 0
      # p "Found matching wine #{wine[0]} for year #{@year}, code #{@lcbo}"
      wine[0]
    else
      existing_wine = winery.wines.find { |w|
        # p "Matching #{@year}, #{@other.sort!.join(', ')}, #{@grapes.sort!.uniq} to #{w}"
        year_match = w.year.to_s == @year
        
        # p "Year match: #{year_match}"

        other_match = w.other == @other.sort!.join(', ')
        
        # p "Other match #{other_match}"

        grapes_match = w.list_grape_names == @grapes.sort!.uniq

        # p "Grapes match #{grapes_match}"

        year_match and other_match and grapes_match
      }

      if ! existing_wine
        p "Wine doesn't exist; creating new one from #{winery}"
        create_wine_from_values winery
      else
        p "Using existing wine #{existing_wine}"
        existing_wine
      end
    end
  end

  def to_s
    [winery_name, other, grapes.join(', '), region, year, lcbo].join(', ')
  end
end

class BottleVO
  def initialize
    @comments = []
    @in_fridge = false
  end
  attr_accessor :comments, :score, :date, :price, :drink_from, :drink_to, :in_fridge, :bought
  def to_s
    [@comments, @score, @date, @price, @from, @to, @in_fridge, @bought].join(', ')
  end

  def store(wine)
    bottle_to_save = Bottle.new
    bottle_to_save.comments = @comments.join(', ')
    bottle_to_save.drink_from = @drink_from
    bottle_to_save.drink_to = @drink_to
    bottle_to_save.in_fridge = @in_fridge
    bottle_to_save.score = @score
    bottle_to_save.reviewdate = @date
    bottle_to_save.price = @price
    bottle_to_save.wine = wine
    bottle_to_save.bought = bought

    p "Storing new bottle #{bottle_to_save}"

    bottle_to_save.save!
  end
end

def make_wine(wine_info, country)
  wine = WineVO.new
  wine.country = country

  wine_info_parts = wine_info.split(',')
  wine.winery_name = wine_info_parts.shift
#  p "Found winery #{wine.winery_name}"
  wine_info_parts.each do | part |
    part = part.strip
#    p "Processing wine info part #{part}"
    if /^\d{4}$/.match(part)
#      p "Found year #{part}"
      wine.year = part
    elsif not Grape.where(:name => part).empty?
#      p "Found grape variety #{part}"
      wine.grapes << part
    elsif Region.is_region?(country, part)
#      p "Found region #{part}"
      wine.region = part
    elsif /^LCBO# (\d{1,10})$/.match(part)
#      p "found lcbo #{part}"
      wine.lcbo = /\d{1,10}/.match(part)[0]
    else
#      p "Found part of wine name #{part}"
      wine.other << part
    end
  end
  wine
end

def make_bottles(bottle_info)
  bottles = []
  finished_bottle = false
  last_was_price = false

  i = 0
  until i == bottle_info.length
    if(i == 0)
      bottle ||= BottleVO.new
      bottles << bottle
    end

    part = bottle_info[i].strip

    if finished_bottle
      # still more, so start a new bottle
#      p "Found another bottle for same wine"
      bottle = BottleVO.new
      bottles << bottle
      finished_bottle = false
    end

#    p "matching #{part}"

    if /\d\/100/.match(part)
#      p "Found bottle #{part}"
      bottle.score = part.split('/')[0]
      last_was_price = false
    elsif /\[.*\]/.match(part)
      bottle.date = part.sub('[', '').sub(']', '')
#      p "Found end of date part; finished bottle"
      finished_bottle = true
      last_was_price = false
    elsif part == 'In fridge'
      last_was_price = false
      bottle.score = 0
#      p "found wine in fridge"
      bottle.in_fridge = true
      finished_bottle = true
    elsif /^\$\d*$/.match(part)
      bottle.price = part.sub('$', '')
      last_was_price = true
#      p "Found part of price #{bottle.price}"
    elsif /^\d{2}$/.match(part) && last_was_price
      dollar_amt = bottle.price
      bottle.price = "#{dollar_amt}.#{part}".to_f
#      p "Found rest of price #{bottle.price}"
    elsif /To 2\d{3}/.match(part)
      last_was_price = false
      bottle.drink_to = part.sub('To ', '')
      bottle.score = 0
#      p "Got to #{bottle.drink_to}"
    elsif /From 2\d{3}/.match(part)
      last_was_price = false
      bottle.drink_from = part.sub('From ', '')
      bottle.score = 0
#      p "Got from #{bottle.drink_from}"
    elsif /Bought [A-Z][a-z]{2} \d{4}/.match(part)
      last_was_price = false
#      p "Found bought date #{part}"
      bottle.bought = part.sub('Bought ', '')
    else
      bottle.comments << part
      last_was_price = false
#      "Found comment #{part}"
    end

    i += 1
  end

  bottles
end

def parse_wine_bottle_line(line, country)
  parts = line.split('.')

  wine_info = parts.shift

  wine = make_wine(wine_info, country)

#  wine = wine.store

  if(wine)
    bottles = make_bottles parts
    if(bottles.length > 1)
#      p "Found bottles #{bottles}"
    end
  end

  {:wine => wine, :bottles => bottles}
end
