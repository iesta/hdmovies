module ApplicationHelper

  def timeformat(t)
    begin
      return t.strftime("%d-%m-%Y %H:%M")
    rescue
      ""
    end
  end

  def dateformat(t)
    begin
      return t.strftime("%d-%m-%Y")
    rescue
      ""
    end
  end
end