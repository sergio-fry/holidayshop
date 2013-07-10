# encoding: utf-8
ActiveAdmin.register Page do
  index do
    column :id
    column "Название", :title

    default_actions
  end
  form do |f|
    f.inputs do
      f.input :title
      f.input :permalink
      f.input :body
    end

    f.buttons
  end
end
