# encoding: utf-8
ActiveAdmin.register Product do
  index do
    selectable_column
    column :id
    column "Название", :title
    column "Картинка" do |product|
      picture = product.pictures.first

      if picture.present?
        image_tag picture.file.url(:thumb)
      end
    end
    column "Закупочная цена", :price
    column "Розничная цена", :price2
    column "Категория", :category

    default_actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs do
      f.input :title
      f.input :origin_id
      f.input :category, :label => "Категория"

      f.inputs :file, :for => [:pictures, f.object.pictures.order(:created_at) + (1..3).map{ Picture.new } ], :class => "inputs gallery_picture" do |pf, i|
        if pf.object.new_record?
          pf.inputs :file, :name => "новая картинка"
        else
          pf.inputs :file, :name => f.template.image_tag(pf.object.file.url(:small)) + raw("<br /><a href='#{pf.object.file.url(:original)}'>Оигинал</a> <a href='#' class='delete_button' data-id='#{pf.object.id}' data-index='#{i-1}'>Удалить</a>"), :style => "height: 200px; padding-bottom: 20px"
        end
      end

      f.input :description, :input_html => { :class => "rich-textarea" }
      f.input :price, :label => "Закупочная цена"
      f.input :price2, :label => "Розничная цена"

      f.input :type_prefix, :label => "Тип"
      f.input :vendor, :label => "Производитель"
      f.input :vendor_code, :label => "Код производителя"
      f.input :model, :label => "Модель"
      f.input :country, :label => "Страна-производитель", :as => :string
      f.input :width, :label => "Ширина, см"
      f.input :length, :label => "Длина, см"
      f.input :height, :label => "Высота, см"
      f.input :weight, :label => "Вес, кг"
      f.input :size, :label => "Размер"
      f.input :age, :label => "Возраст"
    end

    f.buttons
  end
end
