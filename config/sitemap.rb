# Set the host name for URL creation
require 'rubygems'
require 'sitemap_generator'
SitemapGenerator::Sitemap.default_host = "http://localhost:3000"

SitemapGenerator::Sitemap.create do
  add root_path
  Globalize.with_locale(:de) do 
    add studien_path(:theme=>nil, :locale=>:de)
    add fetprofiles_path(:theme=>nil)
    Gremium.find_each do |gremium|
      add gremium_path(gremium ,:theme=>nil,:locale=>:de)
    end
    Studium.find_each do |studium|
      add studium_path(studium ,:theme=>nil,:locale=>:de,:ansicht=>:semesteransicht)
    end
    Lva.find_each do |lva|
      add lva_path(lva ,:theme=>nil,:locale=>:de)
    end
    Modul.find_each do |modul|
      add modul_path(modul ,:theme=>nil,:locale=>:de)
    end
  end
  Globalize.with_locale(:en) do 
    add studien_path(:theme=>nil, :locale=>:en)
    add fetprofiles_path(:theme=>nil)
    Gremium.find_each do |gremium|
      add gremium_path(gremium ,:theme=>nil,:locale=>:en)
    end
    Studium.find_each do |studium|
      add studium_path(studium ,:theme=>nil,:locale=>:en,:ansicht=>:semesteransicht)
    end
    Lva.find_each do |lva|
      add lva_path(lva ,:theme=>nil,:locale=>:en)
    end
    Modul.find_each do |modul|
      add modul_path(modul ,:theme=>nil,:locale=>:en)
    end
  end

  Globalize.with_locale(:de) do 
    Neuigkeit.public.find_each do |neuigkeit|
      add neuigkeit_path(neuigkeit,:locale=>:de,:theme=>"default"),:lastmod=>neuigkeit.updated_at, :news=>{:title=>neuigkeit.title, :publication_language=>"de", :publication_date=>neuigkeit.datum}
    end
  end
  Globalize.with_locale(:en) do 
    Neuigkeit.public.with_translations(:en).find_each do |neuigkeit|
      add neuigkeit_path(neuigkeit,:locale=>:en,:theme=>"default"),:lastmod=>neuigkeit.updated_at, :news=>{:title=>neuigkeit.title,:publication_language=>"en",:publication_date=>neuigkeit.datum}
    end
  end
  Globalize.with_locale(:en) do 
    Thema.public.with_translations(:en).find_each do |thema|
      add thema_path(thema, :locale=>:en, :theme=>"default"),:lastmod=>thema.updated_at
    end
  end
  Globalize.with_locale(:de) do
    Thema.public.with_translations(:de).find_each do |thema|
      add thema_path(thema, :locale=>:de, :theme=>"default"),:lastmod=>thema.updated_at, :alternate=>{:href=>thema_path(thema, :locale=>:de, :theme=>"blue1"), :lang=>"de"}
    end
  end
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
