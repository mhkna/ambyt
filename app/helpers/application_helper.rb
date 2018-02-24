module ApplicationHelper
  def name_or_anon(obj)
    obj.user != nil && obj.user.name != nil && obj.user.name != "" ? obj.user.name : "anonymous"
  end
end
