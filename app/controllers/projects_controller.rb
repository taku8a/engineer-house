class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user!, only: [:edit, :update, :destroy]
  before_action :group_join!, only: [:join]

  def index
    @projects = Project.page(params[:page]).reverse_order
  end

  def show
    @project = Project.find(params[:id])
  end

  def join
    @project.has_member(current_user)
    redirect_to  project_path(@project), notice: t("notice.join_member")
  end

  def leave
   @project = Project.find(params[:project_id])
   if current_user.my_project?(@project)
     redirect_to project_path(@project), alert: t("alert.owner_leave")
   else @project.release(current_user)
        redirect_to projects_path, notice: t("notice.leave_member")
   end
  end

  def edit
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.has_owner(current_user)
    @project.has_member(current_user)
    if @project.save
      redirect_to project_path(@project), notice: t("notice.add_name")
    else
      render "new"
    end
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project), notice: t("notice.edit_name")
    else
      render "edit"
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: t("notice.destroy_name")
  end

  def search
    @content = params[:content]
    @projects = Project.where('name LIKE ?', '%'+@content+'%').page(params[:page]).reverse_order
  end

  private

  def project_params
    params.require(:project).permit(:name, :introduction, :project_image)
  end

  def ensure_correct_user!
    @project = Project.find(params[:id])
    unless current_user.my_project?(@project)
      redirect_to project_path(@project), alert: t("alert.owner_right")
    end
  end

  def group_join!
    @project = Project.find(params[:project_id])
    if @project.full_or_assigned?(current_user)
      redirect_to project_path(@project), alert: t("alert.project_end")
    end
  end
end


# 検索機能説明

# 部分一致（文字列）
# 部分一致のときは、LIKE句と？、%を組み合わせる必要があります。
# User.where("name LIKE ?", "%hana%")

# LIKE句はSQLの検索を行うための演算子です。
# name　LIKEと書くことでnameカラムを検索、という意味になります。
# ?は次の引数"%hana%"を受け取る場所になります。最終的にnama LIKE"%hana%"という
# 風になるということです。%は任意の文字列を指す。
# つまり、nameカラムにhanaを含むレコードを抽出する、という処理になります。

# ルーティングの追加
# 以下のように書くことでGET/users/searchでUsersコントローラーのsearchアクション
# にルーティングされるようになります。

# resources :users do
#   get :search, on: :collection
# end

# コントローラーの編集

# def search
#   if params[:name].present?
#     @users = User.where('name LIKE ?', "%#{params[:name]}%")
#   else
#     @users = User.none
#   end
# end

# 検索文字列はnameフィールドへの入力とするので、params[:name]で取得すればOKです。

# ビューの追加

# form_withを使って検索フォームを作成
# 今回作ったsearchアクションへのルーティングはGETメソッドなので、method: :getのオプション
# を付けている。

# <%= form_with url: search_users_path, method: :get, local: true do |f| %>
#   <%= f.text_field :name %>
#   <%= f.submit :search %>
# <% end %>

# value: params[:search]と値を設定しておくことで検索後も値を保持する
# （URLのクエリから取得）

# クエリ文字列
# http://localhost:3000/sample?test=123
# というように値を渡す方法
# 上記の例だと、「test」がキーで「123」が値です。
# railsの場合、クエリ文字列からパラメータを取得する場合、コントローラーに処理を記載する必要がある。

# コントローラーでクエリ文字列を取得するやり方を解説する
# 取得するにはparamsメソッドを使用
# result = params[:test]
# ([:test]がクエリ文字列から取り出したいキーを設定)

# http://localhost:3000/sample?test=123
# でアクセスした場合、resultには「123」という値が入る
# 注意点としまして、値を取得すると型は文字列となります。
