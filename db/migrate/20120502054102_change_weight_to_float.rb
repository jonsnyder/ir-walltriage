class ChangeWeightToFloat < ActiveRecord::Migration
  def change
    change_column :lda_post_topics, :weight, :float
  end
end
