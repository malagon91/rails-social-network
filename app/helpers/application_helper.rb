module ApplicationHelper
  def resource
    # el operador || asigna el valor del lado derecho a la variable del lado izquierdo siempre y cuando la variable izquierda
    # este nula si no lo esta no asigna el valor
    @resource ||=User.new
  end

  def resource_name
    :user
  end

  def resource_classs
    User
  end
end
