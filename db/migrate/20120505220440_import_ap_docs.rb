class ImportApDocs < ActiveRecord::Migration
  def up
    ActiveRecord::Base.transaction do 
      dataset = Dataset.create( :name => "AP", :description => "2246 documents from the AP TREC dataset.", :is_user_dataset => false)

      file = open( "./lib/data/ap.txt", "r")
      doc = Nokogiri::XML( file)
      doc.xpath('//DOCS/DOC').each do |doc|
        docno = nil
        text = nil
        doc.element_children.each do |child|
          if( child.name == "TEXT")
            text = child.content
          end
          if( child.name == "DOCNO")
            docno = child.content
          end
        end
        if docno && text
          dataset.posts.create( :facebook_id => docno, :message => text.strip)
        end
      end
    end
  end

  def down
    ActiveRecord::Base.transaction do
      Dataset.where( :name => "AP").destroy_all
    end
  end
end
