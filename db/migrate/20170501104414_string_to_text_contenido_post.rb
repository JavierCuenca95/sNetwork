class StringToTextContenidoPost < ActiveRecord::Migration[5.0]
  def change
  	change_column :posts, :contenido, :text
  end
end
