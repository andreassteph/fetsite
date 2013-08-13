class StudienController < ApplicationController
  before_filter {@toolbar_elements =[]} 
  #  before_filter :authorize, :only => :verwalten

  def index
    @studien = Studium.all
    @topbar_elements=[{:hicon=>'icon-list', :text=>I18n.t("studien.allestudien"),:path=>studien_path}]
    @topbar_elements<<{:hicon=>'icon-list', :text=>I18n.t("modul.list"),:path=>moduls_path}
    @topbar_elements<<{:hicon=>'icon-list', :text=>I18n.t("lva.list"),:path=>lvas_path}
    @toolbar_elements<<{:icon =>:plus, :hicon=>'icon-plus-sign', :text=> I18n.t('studien.new') ,:path=>new_studium_path }
    # @toolbar_elements<<{:text=> I18n.t('modulgruppe.show.link') ,:path=>modulgruppen_path }
  end

  def show
    @studium= Studium.find(params[:id])

    @studienphasen=[]
    [1, 2 ,3].each do |ph| 
      modulgruppen_phase=@studium.modulgruppen.where(:phase=>ph)
      if modulgruppen_phase.count==1 
        opts={:width=>12, :slice=>1}
      elsif modulgruppen_phase.count <= 4 
        opts={:width=>6, :slice=>2}
      else 
        opts={:width=>4, :slice=>3}
      end  
      modulgruppen =[]
      modulgruppen_phase.each_slice(opts[:slice]) do |s| 
        modulgruppen<<s #

      end
      @studienphasen << {:modulgruppen=>modulgruppen, :phase => ph}.merge(opts)
    end
    
    @toolbar_elements=[{:icon=>:plus, :hicon =>'icon-plus-sign' ,:text=> I18n.t('studien.new') , :path => new_studium_path(@studium) },
                       {:icon=>:pencil, :hicon=>'icon-pencil',:text =>I18n.t('common.edit'),:path => edit_studium_path(@studium)},
                       {:hicon=>'icon-remove-circle', :text=> I18n.t('common.delete'),:path => studium_path(@studium), :method=> :delete,:confirm=>"Sure?" }]

    @toolbar_modulgruppen =[ {:hicon=>'icon-plus-sign', :text=> I18n.t('modulgruppe.new'), :path=>new_studium_modulgruppe_path(@studium)},
                             {:hicon=>'icon-list', :text => I18n.t('modulgruppe.list'), :path=>modulgruppen_path}]
    
    if params[:ansicht] != 'modulgruppenansicht'
      @text = 'Zu Modulansicht wechseln'
      @flip = 'modulgruppenansicht'
      render 'semesteransicht'
    else
      @text = 'Zu Semesteransicht wechseln'
      @flip = 'semesteransicht'
    end
  end

  def new
    @studium = Studium.new
  end

  def edit
    @studium = Studium.find(params[:id])
    @toolbar_elements=[{:text => I18n.t('studien.anzeigen') , :path => url_for(@studium) }]
    @toolbar_elements<<{:text =>I18n.t('studien.allestudien'),:path=>studien_path(@studium)}
  end

  def create
    @studium = Studium.new(params[:studium])
    
    respond_to do |format|
      if @studium.save
        @studium.batch_add_semester
        format.html { redirect_to url_for(@studium), notice: 'Studium was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end


  def update
    @studium = Studium.find(params[:id])

    if @studium.update_attributes(params[:studium])
      redirect_to url_for(@studium), notice: 'Studium was successfully updated.' 
    else
      render action: "edit" 
      
    end
    
  end

  def destroy
    @studium = Studium.find(params[:id])
    @studium.destroy
    redirect_to studien_url
  end

  def verwalten
    @new_params={:std_verw=>params[:std_verw], :mg_verw=>params[:mg_verw], :m_verw=>params[:m_verw], :lva_verw=>params[:lva_verw], :b_verw=>params[:b_verw]}
    if @new_params.values.compact.empty?
      @studien=Studium.all
      @modulgruppen=Modulgruppe.all
      @module=Modul.all
      @lvas=Lva.all
      @beispiele=Beispiel.all
    else
      if !@new_params[:std_verw].nil?
        @studien = [Studium.find(@new_params[:std_verw])]
      else
        @studien = Studium.all
      end
      if !@new_params[:mg_verw].nil?
        @modulgruppen = [Modulgruppe.find(@new_params[:mg_verw])]
        temp = @modulgruppen.map{|x| x.studium}.flatten.uniq # Force Studien
        @studien=@studien.select{|k| temp.include?(k)}

      else
        @modulgruppen = Modulgruppe.all
        temp = @studien.map{|x| x.modulgruppen}.flatten.uniq # Studien forcen Modulgruppen
        @modulgruppen = @modulgruppen.select{|k| temp.include?(k)}
      end
      if !@new_params[:m_verw].nil?
        @module = [Modul.find(@new_params[:m_verw])]
        temp = @module.map{|x| x.modulgruppen}.flatten.uniq # Force Modulgruppen
        @modulgruppen = @modulgruppen.select{|k| temp.include?(k)}
        temp = @modulgruppen.map{|x| x.studium}.flatten.uniq # Force Studien
        @studien=@studien.select{|k| temp.include?(k)}
        
      else
        @module = Modul.all
        temp = @modulgruppen.map{|x| x.moduls}.flatten.uniq
        @module=@module.select{|k| temp.include?(k)}
      end
      if !@new_params[:lva_verw].nil?
        @lvas = [Lva.find(@new_params[:lva_verw])]
        temp = @lvas.map{|x| x.modul}.flatten.uniq
        @module=@module.select{|k| temp.include?(k)}
        temp = @module.map{|x| x.modulgruppen}.flatten.uniq # Force Modulgruppen
        @modulgruppen = @modulgruppen.select{|k| temp.include?(k)}
        temp = @modulgruppen.map{|x| x.studium}.flatten.uniq # Force Studien
        @studien=@studien.select{|k| temp.include?(k)}
      else
        @lvas = Lva.all
        temp = @module.map{|x| x.lvas}.flatten.uniq #Force Module
        @lvas=@lvas.select{|k| temp.include?(k)}
      end
      if !@new_params[:b_verw].nil?
        @beispiele = [Beispiel.find(@new_params[:b_verw])]
        temp = @lvas.map{|x| x.beispiele}.flatten.uniq #Force Force Lvas
        @lvas=@lvas.select{|k| temp.include?(k)}
        temp = @module.map{|x| x.lvas}.flatten.uniq #Force Module
        @module=@module.select{|k| temp.include?(k)}
        temp = @module.map{|x| x.modulgruppen}.flatten.uniq # Force Modulgruppen
        @modulgruppen = @modulgruppen.select{|k| temp.include?(k)}
        temp = @modulgruppen.map{|x| x.studium}.flatten.uniq # Force Studien
        @studien=@studien.select{|k| temp.include?(k)}
        
        
      else
        @beispiele = Beispiel.all
        temp = @lvas.map{|x| x.beispiele}.flatten.uniq # Force beispiel
        @beispiele=@beispiele.select{|k| temp.include?(k)}
      end
    end

    @messages = []
    for s in @studien

      if s.valid?
        @messages << s.name + ' hat keine Modulgruppe' if s.modulgruppen.count == 0
        
      else
        @messages << '<font color="red"><b>'+s.name + ': '
        @messages << s.errors.full_messages
        @messages << '</font></b>'
      end
    end
    for mg in @modulgruppen
      
      if mg.valid?
        @messages << mg.name +  ' hat kein Modul' if mg.moduls.count == 0
      else
        @messages << '<font color="red"><b>'+mg.name + ': '
        @messages << mg.errors.full_messages
        @messages << '</font></b>'
      end
    end
    for m in @module
      
      if m.valid?
        @messages << m.name.to_s + ' hat keine Modulgruppe' if m.modulgruppen.count == 0
        @messages << m.name.to_s + ' hat keine Lvas' if m.lvas.count == 0
      else
        @messages << '<font color="red"><b>'+m.name.to_s + ': '
        @messages << m.errors.full_messages
        @messages << '</font></b>'
      end
    end
    for lva in @lvas
      
      if lva.valid?
        @messages << lva.name + ' hat keine Module' if lva.modul.count == 0
        for s in @studien
          stu_sem = s.semester.map{|l| l.lvas}.flatten.uniq.index(lva)
          stu_mod = s.modulgruppen.map{|m| m.moduls}.flatten.map{|l| l.lvas}.flatten.uniq.index(lva)
          if (stu_sem.nil? && !stu_mod.nil?) 
            @messages << lva.name + ' erscheint nicht in der Semesteransicht von ' +s.name + ' aber in der Modulgruppenansicht'
          end
          if (!stu_sem.nil? && stu_mod.nil?)
            @messages << lva.name + ' erscheint in der Semesteransicht von ' +s.name + ' aber nicht in der Modulgruppenansicht'
          end
        end
      else
        @messages << '<font color="red"><b>'+lva.name + ': '
        @messages << lva.errors.full_messages
        @messages << '</font></b>'
      end
    end
    for b in @beispiele
      if b.valid?
        @messages << b.name + ' hat keine Lva' if b.lva.nil?
      else
        @messages << '<font color="red"><b>'+b.name + ': '
        @messages << b.errors.full_messages
        @messages << '</font></b>'
      end
    end
    render 'studien/verwalten'
  end

  def default_url_options
    {:ansicht=> params[:ansicht],
      :std_verw=> params[:std_verw],
      :mg_verw=> params[:mg_verw],
      :m_verw=>params[:m_verw],
      :lva_verw=>params[:lva_verw],
      :b_verw=>params[:b_verw]}.merge(super)

  end
end
