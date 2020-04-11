class AddIntroductionToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :introduction, :text
    add_colume :users, :profile_image_id, :string 

  end
end
