module ApplicationHelper
  def auth_token
    %Q(
    <input
      type="hidden"
      name="authenticity_token"
      value="#{form_authenticity_token}">
    ).html_safe
  end

  def change_method_edit(object)
    if object.persisted?
      %Q(<input type="hidden" name="_method" value="patch">).html_safe
    else
      ""
    end
  end
end
