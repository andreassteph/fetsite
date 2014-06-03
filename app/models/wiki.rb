class Wiki < Thema
  validates :wikiname, :uniqueness=>true, :presence=>true
  after_initialize :load_wiki
  attr_accessible :wikiname, :wikiformat, :hidelink, :raw_data
  WIKIFORMATS={nil=> :textile, 0 =>:textile,  1=> :mediawiki}

  def self.find_or_init(name)
    w = Wiki.where(:wikiname=>name).first
    page = is_file_availaible(name)
    if w.nil?
      unless page.nil?
        w=Wiki.new(:wikiname=>name, :title=>name, :wikiformat=>Wiki::WIKIFORMATS.invert[page.format], :hidelink=>true)
      else     
        w=Wiki.new(:wikiname=>name, :title=>name, :wikiformat=>0, :hidelink=>true) 
        wiki = Gollum::Wiki.new("../wiki.git", :base_path => "/wiki")
        page=wiki.write_page(name, :textile, "ioi", self.commit)
        w.reload_page
      end
      
      w.themengruppe = Themengruppe.find_wiki_default      
      w.raw_data="Neues Wiki"
      w.save
    end
    w
  end
 
  def raw_data
    self.page.raw_data
  end

  def raw_data=(data)
    self.get_page(self.wikiname)
    self.wiki.update_page(self.page, self.wikiname, Wiki::WIKIFORMATS[self.wikiformat], data, self.commit)
    self.text=self.page.formatted_data  
    
  end

  def page
    self.get_page(wikiname) if @page.nil? 
    @page
  end
  
  def wiki
    @wiki
  end
  def reload_page
  self.get_page(self.wikiname)
  end
  protected
  

  def self.is_file_availaible(name)  
    wiki = Gollum::Wiki.new("../wiki.git", :base_path => "/wiki")
    wiki.page(name)
  end

  def load_wiki
    @wiki = Gollum::Wiki.new("../wiki.git", :base_path => "/wiki")
  end

  def get_page(name)
    @page= @wiki.page(name)
    @page=self.wiki.write_page(self.wikiname, Wiki::WIKIFORMATS[self.wikiformat]," ",self.commit) if @page.nil?
    @page
  end
  def commit
    {message: "RailsUpdate", name:"SomeUser", email: "ttt@t"}
  end

  def self.commit
    {message: "RailsUpdate", name:"SomeUser", email: "ttt@t"}
  end
end
