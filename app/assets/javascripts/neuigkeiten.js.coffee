
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  `$('.datetimepicker').datetimepicker({format: 'd.m.Y H:i', startDate: (!($(this).attr("value")==undefined))? $(this).attr("value"): '' })`
  return