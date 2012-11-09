ActiveAdmin.register Catalog do
  form do |f|
    f.inputs "Catalog" do
      f.input :file, :as => :file
    end
    f.buttons
  end
end
