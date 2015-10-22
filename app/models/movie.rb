class Movie < ActiveRecord::Base
    #单个排序
    def self.ratings_list
        return ['奶制品','肉制品','草原白酒','养生粗粮','民族工艺品']
    end
    
    def self.find_all_by_rating(r)
        self.where(rating: r)
    end

end
