ActiveAdmin.register ExerciseList do

  permit_params :exercise

  index do
    selectable_column
    id_column
    column :exercise
    actions
  end

  form do |f|
    f.inputs "Exercises List" do
      f.input :exercise
    end
    f.actions
  end

end
