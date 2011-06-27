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
  
  def snippet(thought,wc=50)
    wordcount = wc
    thought.split[0..(wordcount-1)].join(" ") + (thought.split.size > wordcount ? "..." : "")
  end
  
  def markdown(text)
    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    Redcarpet.new(text, *options).to_html.html_safe
  end

end