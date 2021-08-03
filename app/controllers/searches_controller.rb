class SearchesController < ApplicationController
  def search
    # viewのformタグにて
    # userかbookかを@modelに代入
    @model=params["model"]
    # 完全一致か部分一致かを@methodに代入
    @method=params["method"]
    # 検索ワードをcontentに代入
    @content=params["content"]
    @records = search_for(@model,@content,@method)
  end

  private
  def search_for(model,content,method)
    if model == "user"
      if method == "perfect"
        User.where(name: content)
      else
        User.where('name LIKE ?','%'+content+'%')
      end
    elsif model == "book"
      if method == "perfect"
        Book.where(title: content)
      else
        Book.where('title LIKE ?','%'+content+'%')
      end
    end
  end
end
