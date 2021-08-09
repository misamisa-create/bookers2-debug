class ChatsController < ApplicationController
  before_action :follow_each_other,only: [:show]

  def show
    # どのユーザとチャットするかを取得
    @user = User.find(params[:id])
    # カレントユーザのuser_roomにあるroom_idの値の配列を取得し    roomsに代入
    # pluckメソッドは全てのデータではなく特定のカラムの値(引数に指定したもの)を取得できる
    # user_roomsテーブルのroom_idカラムのidを取得できる
    rooms = current_user.user_rooms.pluck(:room_id)
    # user_roomモデルからuser_idがチャット相手のidと一致するものとroom_idが上記roomsのどれかに一致するレコードを
    # user_roomsに代入
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    unless user_rooms.nil?
      @room = user_rooms.room
    else
      @room = Room.new
      @room.save
      # user_roomをカレンとユーザ分とチャット相手分を作る
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
    # 遷移前のページに
    redirect_to request.referer
  end

  private
  def chat_params
    params.require(:chat).permit(:message,:room_id)
  end

  def follow_each_other
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to books_path
    end
  end

end
