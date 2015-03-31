class Crawlobject < ActiveRecord::Base
  attr_accessible :children_count, :crawltime, :crawlurl, :depth, :lft, :name, :parent_id, :published_at, :raw, :referenced, :rgt, :schematype, :text, :type, :url
 acts_as_nested_set

  belongs_to :something, :polymorphic=>true
  def parse_children
    if self.objtype == 1 # ET Forum Article loaded
      self.json["comments"].each do |com|
        if self.children.where(:objhash=>Digest::SHA512.hexdigest(com.to_json)).empty?
          cco = self.children.new(:raw=>com.to_json,:crawlurl=>self.crawlurl)
          cco.objtype=2
          cco.parse_object
          cco.calc_hash
          
          if self.children.where(:objhash2=>cco.objhash2).empty?
            cco.save
          else
            cco=self.children.where(:objhash2=>cco.objhash2).first
            cco.raw=com.to_json
            cco.parse_object
            cco.calc_hash
            cco.save
          end
        end
      end
    end
  end
  def parse_object
      
    if self.objtype == 1 # ET Forum Article loaded
      # ET - Forum 
      self.schematype = self.json["type"].first
      self.name = self.json["properties"]["name"].first
      self.url = self.json["properties"]["url"].first
      self.published_at = self.json["properties"]["dateCreated"].first
      
    end
    if self.objtype == 2 # ET Forum Comment loaded is part of Article 
      self.schematype = self.json["type"].first
      self.url = self.json["properties"]["replyToUrl"].first
      self.name = self.json["properties"]["name"].try(:first)
      self.published_at = self.json["properties"]["commentTime"].try(:first)
      self.text = self.json["properties"]["commentText"].try(:first)
      
      

    end
  end
  def calc_hash
    self.objhash=Digest::SHA512.hexdigest(self.raw)
    self.objhash2=Digest::SHA512.hexdigest(self.url.to_s+self.try(:name).to_s+self.schematype.to_s+self.published_at.utc.to_s)
    
  end
  def json
    JSON.parse(self.raw)
  end

end
