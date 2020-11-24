class ChangeDefaultValuesToPtBr < ActiveRecord::Migration[6.0]
  def change
    change_column_default :configurations, :modal_text, "Você quer instalar o nosso app para promoçōes exclusuivas?"
    change_column_default :manifests, :name, "O nome da sua loja"
    change_column_default :manifests, :short_name, "O nome do seu app"
    change_column_default :manifests, :description, "Rastreie os seus pedidos e receba promoçōes especiais"
    change_column_default :optins, :title, "Procurando por promoçōes especiais?"
    change_column_default :optins, :body, "Seja notificado das promoçōes mais quentes!"
    change_column_default :optins, :accept_button, "Sim!"
    change_column_default :optins, :decline_button, "Não"
  end
end
