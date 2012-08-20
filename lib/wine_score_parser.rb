# coding: utf-8

require './grape.rb'
require './country.rb'

# FIXME - use rails classes
class Wine
  def initialize
    @grapes = []
    @other = []
    @region = ''
    @lcbo = ''
    @scores = []
  end
  attr_accessor :winery_name, :other, :year, :region, :grapes, :lcbo, :scores
  def to_s
    _other = @other.empty? ? '' : other.join(', ')
    _grapes = @grapes.empty? ? '' : @grapes.join(', ')
    [@winery_name, _other, @region, @year, _grapes, @lcbo, @scores.to_s].join(',')
  end
end

class Score
  def initialize
    @comments = []
  end
  attr_accessor :comments, :score, :date, :price
  def to_s
    [@comments, @score, @date, @price].join(',')
  end
end

def make_wine(wine_info)
  wine = Wine.new
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
    elsif Region.is_region?('Argentina', part)
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
  score = Score.new
  finished_score = false
  last_was_price = false

  i = 0
  until i == score_info.length
    part = score_info[i]
 
    if finished_score
      # still more, so start a new score
      scores << score
      score = Score.new
      finished_score = false
    end

    # rating
    if /\d\/100/.match(part)
#      p "Found score #{part}"
      score.score = part.split('/')[0]
      last_was_price = false
    # date
    elsif /\[.*\]/.match(part)
#      p "Found date #{part}"
      score.date = part.sub('[', '').sub(']', '')
#      p "Found date #{score.date}"
      finished_score = true
      last_was_price = false
    # price
    elsif /\$.*/.match(part)
       score.price = part.sub('$', '')
       last_was_price = true
#       p "Found price #{score.price}, #{last_was_price}"
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

  scores = make_scores parts

  # FIXME implement
  wine.scores = scores

  p "#{wine}"
end

lines = File.new(ARGV[0]).readlines

lines.each do |line|
  line = line.chomp
  next if line.empty?
#  p "Processing #{line}"

  # FIXME - determine if this is a country line or not
  parse_wine_score_line(line)
end
