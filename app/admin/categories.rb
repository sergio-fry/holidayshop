# encoding: utf-8
ActiveAdmin.register Category do
  index do
    column :id
    column "Название", :title

    default_actions
  end
end
