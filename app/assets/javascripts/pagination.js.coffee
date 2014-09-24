

$ ->
  if $('#infinite-scrolling').size() > 0
    more_posts_url = $('.pagination .next_page a').attr('href')
    b=$(document).height() - $(window).height() - 60
    if more_posts_url && $(window).scrollTop() > b
      $('.pagination').html('<b> Loading...</b>')
      $.getScript more_posts_url
    $(window).on 'scroll', ->
      more_posts_url = $('.pagination .next_page a').attr('href')
      b=$(document).height() - $(window).height() - 60
      if more_posts_url && $(window).scrollTop() > b
        $('.pagination').html('<b> Loading...</b>')
        $.getScript more_posts_url
      return  
  return