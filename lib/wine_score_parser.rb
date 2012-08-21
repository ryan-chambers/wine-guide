# coding: utf-8

require 'grape.rb'
require 'country.rb'
require 'wine.rb'
# require

# FIXME - use rails classes
class WineVO
  def initialize
    @grapes = []
    @other = []
    @region = ''
    @lcbo = ''
    @winery_name
    @country
  end

  attr_accessor :winery_name, :other, :year, :region, :grapes, :lcbo, :country

  def to_s
    _other = @other.empty? ? '' : other.join(', ')
    _grapes = @grapes.empty? ? '' : @grapes.join(', ')
    [@winery_name, _other, @region, @year, _grapes, @lcbo].join(', ')
  end

  def store
    winery = Winery.find_by_name @winery_name
    if !winery
      winery = Winery.new
      winery.name = @winery_name
      winery.save!
    end

    wine = Wine.new
    wine.winery = winery
    wine.country = @country
    wine.lcbo_code = @lcbo
    wine.region = @region
    wine.year = @year
    # FIXME - store other
    
    @grapes.each do | grape |
      wine.wine_grapes << WineGrape.new(:grape => grape)
    end

    wine.save!
  end
end

class ScoreVO
  def initialize
    @comments = []
  end
  attr_accessor :comments, :score, :date, :price
  def to_s
    [@comments, @score, @date, @price].join(', ')
  end
end

def make_wine(wine_info)
  # FIXME - stop hard-coding
  country = 'Argentina'
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
    elsif Grape.is_grape? part
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

def make_scores(score_info)
  scores = []
  score = ScoreVO.new
  scores << score
  finished_score = false
  last_was_price = false

  i = 0
  until i == score_info.length
    part = score_info[i].strip
 
    if finished_score
      # still more, so start a new score
      scores << score
      score = ScoreVO.new
      finished_score = false
    end

    # rating
    if /\d\/100/.match(part)
#      p "Found score #{part}"
      score.score = part.split('/')[0]
      last_was_price = false
    # date
    elsif /\[.*\]/.match(part)
      score.date = part.sub('[', '').sub(']', '')
      finished_score = true
      last_was_price = false
    # price
    elsif /\$.*/.match(part)
       score.price = part.sub('$', '')
       last_was_price = true
    # comments
    else
      m = /\d{2}/.match(part)
      if /\d{2}/.match(part) && last_was_price
        dollar_amt = score.price
        score.price = "#{dollar_amt}.#{part}".to_f
      else
        score.comments << part
      end
      last_was_price = false
    end

    i+= 1
  end

  scores
end

def parse_wine_score_line(line)
  parts = line.split('.')

  wine_info = parts.shift

  wine = make_wine wine_info

  wine.store

  scores = make_scores parts

  # store scores
end

lines = File.new(ARGV[0]).readlines

lines.each do |line|
  line = line.chomp
  next if line.empty?

  # FIXME - determine if this is a country line or not
  parse_wine_score_line(line)
end
