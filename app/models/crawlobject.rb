class Crawlobject < ActiveRecord::Base
  attr_accessible :children_count, :crawltime, :crawlurl, :depth, :lft, :name, :parent_id, :published_at, :raw, :referenced, :rgt, :schematype, :text, :type, :url
  acts_as_nested_set
  has_many :attachments, :as=>:parent
  
  belongs_to :something, :polymorphic=>true
  def self.config
    Rails.application.config.crawlconfig
  end
  def has_attachments?
  if self.objtype==2 
    return true
  else
    return false
  end
  end
  def move_to_neuigkeit(user,rubrik)
    if self.objtype == 5 and self.something.nil?
      n=Neuigkeit.new
      n.title=self.name
      n.text=self.text
      n.datum=self.published_at
      n.author=user
      n.rubrik=rubrik
      n.origurl = self.url
      n.save
      self.something=n
      self.save
      return n
    elsif   self.objtype == 5
      n=self.something
      n.title=self.name
      n.text=self.text
      n.datum=self.published_at
      n.author=user
      n.rubrik=rubrik
      n.origurl = self.url
      n.save
      
    end
  end
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

  def load_attachments
    if self.objtype == 2 # ET Comments only
      self.json["attachments"].each do |url|
        fn = `python ../microdata/download_file.py "#{url}"`
        
        unless self.attachments.where(:name=>"Et_21.01.2015_L_sung.pdf").count > 0
        
          a=Attachment.new
          a.datei=File.open("/home/andreas/www/microdata/tmp/"+fn.strip)        
          a.name=fn.strip
          a.parent=self
          a.save
          self.attachments<< a
          a.save
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
    if self.objtype==5
      self.name=self.json["name"].strip
      self.text=self.json["text"]
      self.published_at=Time.parse(self.json["date"].strip)
      self.url="http://www.htu.at"
    end
  end
  def calc_hash
    self.objhash=Digest::SHA512.hexdigest(self.raw)
    self.objhash2=Digest::SHA512.hexdigest(self.url.to_s+self.try(:name).to_s+self.schematype.to_s+self.published_at.utc.to_s)
    
  end
  def json
    JSON.parse(self.raw)
  end
  def self.crawl_news
    cfg = Rails.application.config
    res = JSON.parse(`python #{Rails.root}/bin/#{cfg.crawlconfig[5]['bin']} #{cfg.crawlconfig[5]['url']}`)
    res.each do |r|
      cc=Crawlobject.new(:raw=>r.to_json)
      cc.objtype=5
      cc.parse_object
      cc.calc_hash
      if Crawlobject.where(:objhash2=>cc.objhash2, :objtype=>5).count==0
        cc.save
      else
        cc = Crawlobject.where(:objhash2=>cc.objhash2, :objtype=>5).first
        cc.raw=r.to_json
        cc.parse_object
        cc.calc_hash
        cc.save
      end
    end
  end
end
