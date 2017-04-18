def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  Movie
    .select(:title, :id).distinct
    .joins(:actors)
    .where('name IN (?)', those_actors)
    .group(:id)
    .having('COUNT(*) > 1')
end

def golden_age
  # Find the decade with the highest average movie score.
  # movies = Movie.all.select(:yr, :score)
  # highest_avg = 0
  # highest_yr = 1920
  # year = 1920
  # until year == 2010
  #   range = (year...year + 10)
  #   # avg = movies.where(yr: range).average('score')
  #   avg = movies.group(:yr).having('yr IN (?)', range).average('score')
  #   if avg > highest_avg
  #     highest_avg = avg
  #     highest_yr = year
  #   end
  #   year += 10
  # end
  # highest_yr
  movies =
  Movie
    .select('AVG(score) AS avg_score, (yr / 10 * 10) AS decade')
    .group('decade')
    .order('avg_score DESC')
    .limit(1)[0]
    .decade
end

def costars(name)
  # List the names of the actors that the named actor has ever appeared with.
  # Hint: use a subquery
  Actor
    .select(:name)
    
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie

end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the letters in whazzername,
  # ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but not like "stallone sylvester" or "zylvester ztallone"

end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of their career.

end
