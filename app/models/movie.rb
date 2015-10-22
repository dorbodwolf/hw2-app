class Movie < ActiveRecord::Base
    #单个排序
    Movie.order("title ASC")
    Movie.order("release_date ASC")
end
