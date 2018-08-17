# csv_practice.rb
require 'csv'
require 'awesome_print'
require 'pry'

# Part 1 - CSV Practice
def load_data(filename)
  data = CSV.open(filename, 'r', headers: true).map do |line|
    line.to_h
  end
  return data
end

ya = load_data('data/athlete_events.csv')


def total_medals_per_country(olympic_data)
  teams = olympic_data.map {|athlete| athlete["Team"]}
  teams.uniq!
  teams.sort!

  medals = {}
  teams.each do |team|
    medals[team] = []
  end

  olympic_data.each do |athletes|
    if athletes["Medal"] != "NA"
      medals[athletes["Team"]] << athletes["Medal"]
    end
  end

  medals.each do |key, value|
    medals[key] = value.length
  end

  # medal_data = []
  # olympic_data.each do |athletes|
  #   athletes = athletes.select {|k,v| k == "Team" || k=="Medal"}
  #   medal_data << athletes
  # end

  countries_medals = []
  medals.each do |k,v|
    country_medals = {}
    country_medals[:country] = k
    country_medals[:total_medals] = v
    countries_medals << country_medals
  end
  return countries_medals
end




yaymedals=total_medals_per_country(ya)

def save_medal_totals(filename, medal_totals)
  CSV.open(filename, "w") do |csv|
    csv << medal_totals.first.keys
    medal_totals.each do |country|
      csv << country.values
    end
  end
  return medal_totals
end

# Part 2 - More Enumerable Practice

def all_gold_medal_winners(olympic_data)
  return gold_athletes = olympic_data.select {|athletes| athletes["Medal"] == "Gold"}
end

all_gold_medal_winners(ya)

def medals_sorted_by_country(medal_totals)
    medal_totals = medal_totals.select {|country| country[:total_medals] !=0}
    medal_totals = medal_totals.sort_by {|country| country[:country]}

    #medal_totals.reverse!
end

puts medals_sorted_by_country(yaymedals)

def country_with_most_medals(medal_totals)
  a.max_by {|x| x.length }
end
#
# def athlete_height_in_inches(olympic_data)
#
# end
