# encoding: utf-8
ActiveAdmin.register Category do
  index do
    column :id
    column "Название", :title
    column "Порядковый номер", :order_index

    default_actions
  end
end
