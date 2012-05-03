class AddKappaStat < ActiveRecord::Migration
  def up
    Stat::Kappa.create
  end

  def down
  end
end
