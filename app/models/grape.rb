require 'report_vo'

class Grape < ActiveRecord::Base
  validates :name, :presence => true, uniqueness: true

  has_and_belongs_to_many :wines

  before_save { |grape| grape.name = grape.name.split(/(\W)/).map(&:capitalize).join }

  def self.search_by_name(name)
    if(name)
      like = "%".concat(name.downcase.concat("%"))
      where("lower(name) like ?", like).order('name asc')
    else
      Grape.findAll
    end
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
