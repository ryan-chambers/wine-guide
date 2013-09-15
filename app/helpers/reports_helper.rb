module ReportsHelper
  def determine_years(wines)
    (this_year..determine_max_year(wines)).to_a
  end

  def determine_max_year(wines)
    max = wines.reduce(this_year) { | m, wine |
      drink_to = wine.cellar_bottles[0].drink_to
      m = drink_to if ! drink_to.nil? and m < drink_to
      m
    }

    max
  end

  def determine_bottles_per_year(year_range, wines)
    scores = year_range.reduce({}) { |s, year|
      s[year] = 0
      s
    }

    scores = wines.reduce(scores) { | s, wine |
      b = wine.cellar_bottles[0]
#      p "#{b}"
      number_of_bottles = wine.cellar_bottles.length
        year_start = this_year
      if ! b.drink_from.nil?
        year_start = b.drink_from unless b.drink_from < year_start
      end
      year_end = b.drink_to || year_range.last
      ctr = year_start
      bottles_per_year = number_of_bottles.to_f / (year_end - year_start + 1)
#      p "#{bottles_per_year} bpy from #{year_start} to #{year_end}"
      until ctr > year_end
#        p "Adding #{bottles_per_year} bpy to existing amount of #{s[ctr]} for year #{ctr}"
        s[ctr] += bottles_per_year
        ctr += 1
      end
      s
    }
    scores.values
  end

  private

  def this_year
    Time.new.strftime('%Y').to_i
  end
end
