class FavoritesController < ApplicationController
  def create
    # カラムで設定した通り、favoriteモデルはbookモデルとbook_idで関連づけられて
    # いるため、そのidの中から特定のbookを指定する
    @book=Book.find(params[:book_id])
    # ユーザーモデルに関連づけたfavoritesの新しいものを作り、
    # 外部キー（引数）として（一行目の）特定のidを指定している
    # ※つまり()は一行目との関連を示している？
    favorite=current_user.favorites.new(book_id:@book.id)
    favorite.save
    # 今いる場所へ移るため、ifで分岐？
    # redirect_back(fallback_location:root_path)
  end
  def destroy
    @book=Book.find(params[:book_id])
    favorite=current_user.favorites.find_by(book_id:@book.id)
    favorite.destroy
    # ifで分岐？
    # redirect_back(fallback_location:root_path)
  end
end
