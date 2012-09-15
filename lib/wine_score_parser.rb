# coding: utf-8

require 'grape.rb'
require 'country.rb'
require 'wine.rb'

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
    
    if !wine.save
      p "Couldn't save wine #{wine.to_s} : #{wine.errors.full_messages.to_sentence}"
      false
    else
      p "Stored new wine score from winery #{@winery_name}."
      wine
    end
  end

  def store
    winery = Winery.find_by_name @winery_name
    if !winery
      winery = Winery.new
      winery.name = @winery_name
      winery.save!
      p "Saved new winery #{@winery_name}"
    end

    # FIXME - look up from db
    wine = Wine.where(:lcbo_code => @lcbo, :year => @year)
    if wine && wine.length > 0
      wine[0]
    else
      create_wine_from_values winery
    end
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

  # FIXME - store scores
end

lines = File.new(ARGV[0]).readlines

lines.each do |line|
  line = line.chomp
  next if line.empty?

  # FIXME - determine if this is a country line or not
  parse_wine_score_line(line)
end
