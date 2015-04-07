module AttachmentsHelper

  def render_attachments_for(p)
    a= Attachment.new 
    a.parent=p
    render(partial:"attachments/attachment_list", object: p.attachments, locals: {editor: (can?(:edit, p)), parent: p} )+ ((can?(:edit, p))? (render partial:"attachments/form_bulk2", object: a ): "")
    
  end
end
