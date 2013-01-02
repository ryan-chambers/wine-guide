# coding: utf-8

require 'grape.rb'
require 'country.rb'
require 'wine.rb'
require 'score.rb'

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
      # p "Saved new winery #{@winery_name}"
    end

    wine = Wine.where(:lcbo_code => @lcbo, :year => @year, :winery_id => winery.id)
    if wine && wine.length > 0
      wine[0]
    else
      existing_wine = winery.wines.find { |w|
        #p "Matching #{@year}, #{@other.sort!.join(', ')}, #{@grapes.sort!.uniq} to #{w}"
        year_match = w.year.to_s == @year
        
        #p "Year match: #{year_match}"

        other_match = w.other == @other.sort!.join(', ')
        
        #p "Other match #{other_match}"

        grapes_match = w.list_grape_names == @grapes.sort!.uniq

        #p "Grapes match #{grapes_match}"

        year_match and other_match and grapes_match
      }

      if ! existing_wine
        #p "Wine doesn't exist; creating new one from #{winery}"
        create_wine_from_values winery
      else
        #p "Using existing wine #{existing_wine}"
        existing_wine
      end
    end
  end
end

class ScoreVO
  def initialize
    @comments = []
  end
  attr_accessor :comments, :score, :date, :price, :from, :to, :in_fridge
  def to_s
    [@comments, @score, @date, @price, @from, @to, @in_fridge].join(', ')
  end

  def store(wine)
    score_to_save = Score.new
    score_to_save.comments = @comments.join(', ')
    score_to_save.from = @from
    score_to_save.to = @to
    score_to_save.in_fridge = @in_fridge
    score_to_save.score = @score
    score_to_save.reviewdate = @date
    score_to_save.price = @price
    score_to_save.wine = wine

    score_to_save.save!

    p "Stored new score #{score_to_save}"
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

def make_scores(score_info)
  scores = []
  finished_score = false
  last_was_price = false

  i = 0
  until i == score_info.length
    if(i == 0)
      score ||= ScoreVO.new
      scores << score
    end

    part = score_info[i].strip
 
    if finished_score
      # still more, so start a new score
#      p "Found another score for same wine"
      score = ScoreVO.new
      scores << score
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
    elsif /^\$\d*$/.match(part)
      score.price = part.sub('$', '')
      last_was_price = true
#      p "Found part of price #{score.price}"
    # comments
    elsif /\d{2}/.match(part) && last_was_price
      dollar_amt = score.price
      score.price = "#{dollar_amt}.#{part}".to_f
    elsif /To 2\d{3}/.match(part)
      last_was_price = false
      score.to = part.sub('To ', '')
      score.score = 0
#      p "Got to #{score.to}"
    elsif /From 2\d{3}/.match(part)
      last_was_price = false
      score.from = part.sub('From ', '')
      score.score = 0
#      p "Got from #{score.from}"
    elsif part == 'In fridge'
      last_was_price = false
      score.in_fridge = true
      score.score = 0
#      p "found wine in fridge"
      score.in_fridge = true
    else
      score.comments << part
      last_was_price = false
      # p "Found comment #{part}"
    end

    i += 1
  end

  scores
end

def parse_wine_score_line(line, country)
  parts = line.split('.')

  wine_info = parts.shift

  wine = make_wine(wine_info, country)

  wine = wine.store

  if(wine)
    scores = make_scores parts
    if(scores.length > 1)
#      p "Found scores #{scores}"
    end

    scores.each do |score|
      score.store wine
    end
  end
end

lines = File.new(ARGV[0]).readlines

current_country = ''
lines.each do |line|
  line = line.chomp
  next if line.empty?

  if(Country.is_country?(line))
    current_country = line
  else
    parse_wine_score_line(line, current_country)
  end
end
