require 'report_vo'

class Grape < ActiveRecord::Base
  validates :name, :presence => true, uniqueness: true

  has_and_belongs_to_many :wines

  belongs_to :wines

  before_save { |grape| grape.name = grape.name.split(/(\W)/).map(&:capitalize).join }

  def self.search_by_name(name)
    if(name)
      like = "%".concat(name.downcase.concat("%"))
      where("lower(name) like ?", like).order('name asc')
    else
      Grape.findAll
    end
  end

  def self.generate_grape_report(grape_id)
    Bottle.find_by_sql(["select count(b.score) as total_bottles,
       avg(b.score) as avg_score,
       avg(b.price) as avg_price
       from grapes g, grapes_wines gw, wines w, bottles b
       where g.id = gw.grape_id
       and gw.wine_id = w.id
       and b.wine_id = w.id
       and g.id = ?", grape_id]).collect { |s|
        GrapeReportVO.new :avg_score => Float(s[:avg_score]), :total_bottles => Integer(s[:total_bottles]), :avg_price => Float(s[:avg_price])
    }[0]
  end

  def self.findAll
    self.order('name asc')
  end

  def to_s
    name
  end
end

class GrapeReportVO < ReportVO
  attr_reader :avg_score, :avg_price, :total_bottles

  def to_s
    [avg_score, total_bottles, avg_price].join(', ')
  end
end
