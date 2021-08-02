class SearchesController < ApplicationController
  def search
    @model = params["search"]["model"]
    @content = params["search"]["content"]
    @method = params["search"]["method"]
    @records = search_for(@model, @content, @method)
  end

  private

  def search_for(model, content, method)
    if model == "user"
      if method == "perfect_match"
        User.where(name: content)
      elsif method == "forward_match"
        User.where("name LIKE ?", "#{content}%")
      elsif method == "backward_match"
        User.where("name LIKE ?", "%#{content}")
      elsif method == "partial_match"
        User.where("name LIKE ?", "%#{content}%")
      end
    elsif model == "book"
      if method == "perfect_match"
        Book.where(title: content)
      elsif method == "forward_match"
        Book.where("title LIKE ?", "#{content}%")
      elsif method == "backward_match"
        Book.where("title LIKE ?", "%#{content}")
      elsif method == "partial_match"
        Book.where("title LIKE ?", "%#{content}%")
      end
    end
  end

end
