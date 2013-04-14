$ ()->
  $(".gallery_picture .delete_button").click ()->
    button = $(this)
    picture = button.closest("fieldset.gallery_picture")
    picture_id = button.data("id")


    picture
      .append("<input type='hidden' value='1' name='product[pictures_attributes][#{button.data("index")}][_destroy]' />")
      .hide()
      .after("<fieldset><ol><li class='input'><p><strong>Картинка удалена!<strong></p></li></ol></fieldset>")


    return false

