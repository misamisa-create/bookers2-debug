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
      # 前方
      if method == "forward_match"
        User.where('name LIKE ?', content+'%')
      # 後方
      elsif method == "backward_match"
        User.where('name LIKE ?','%'+content )
      # 完全
      elsif method == "perfect"
        User.where(name: content)
      # 部分
      else
        User.where('name LIKE ?','%'+content+'%')
      end

    elsif model == "book"
      # 前方
      if method == "forward_match"
        Book.where('title LIKE ?', content+'%')
      # 後方
      elsif method == "backward_match"
        Book.where('title LIKE ?','%'+content )

      elsif  method == "perfect"
        Book.where(title: content)
      else
        Book.where('title LIKE ?','%'+content+'%')
      end
    end
  end
end
