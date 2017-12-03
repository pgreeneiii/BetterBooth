class ChartsController < ApplicationController
   def p1_price_by_year
      p1_prices = Section.p1_price.group(:year)
      render json: [{name: 'Count', data: p1_prices}]
   end

end
