utils = window.$utils = {}

# <br /> instead of line breaks
utils.nl2br = (html)->
  html
    .replace(new RegExp("\r\n(\r\n)*", "g"), "<br /><br />")
    .replace(new RegExp("\n(\n)*", "g"), "<br /><br />")

# set uniq ids for each el: $("textarea").setUniqId()
jQuery.fn.setUniqId = ()->
  $(this).each ()->
    if $(this).attr("id") == "" || $("[id='"+$(this).attr("id")+"']").length != 1
      id = "rand_id_" + Math.random()
      while($("[id='"+id+"']").length > 0)
        id = "rand_id_" + Math.random()
                                            
      $(this).attr("id", id)
