class Public::HomesController < ApplicationController
  def top
   @items = Item.order(updated_at: "DESC").limit(4)
  end
  def about

  end

end
