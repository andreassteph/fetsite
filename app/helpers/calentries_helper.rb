module CalentriesHelper
  def render_calentries_for(p)
    calentry_list=p.calentries
    render(partial: "calentries/calentry_list", object: calentry_list, locals:{parent: p})
  end
end
