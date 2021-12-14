module ApplicationHelper
  
  
  def message_class_bottstrap_from_devise(devise_class)
    res = '';
    case devise_class
    when 'notice'
      res = 'warning'
    when 'error','alert'
      res = 'danger'
    else
      res = devise_class;
    end
    return res
  end
 
end
