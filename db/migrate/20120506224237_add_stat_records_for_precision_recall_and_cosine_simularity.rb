class AddStatRecordsForPrecisionRecallAndCosineSimularity < ActiveRecord::Migration
  def up
    ActiveRecord::Base.transaction do
      Stat.create( :name => "Precision")
      Stat.create( :name => "Recall")
      Stat.create( :name => "Cosine Simularity")
    end
  end

  def down
    ActiveRecord::Base.transaction do
      Stat.where( :name => "Precision").destroy
      Stat.where( :name => "Recall").destroy
      Stat.where( :name => "Cosine Simularity").destroy
    end
  end
end
