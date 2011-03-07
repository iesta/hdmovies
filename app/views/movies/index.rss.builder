xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "HDiesta Movies"
    xml.description "Last releases on HDiesta"
    xml.link movies_url


    for movie in @movies
      xml.item do
        desc = "#{movie.quality} #{movie.format} #{movie.origin}<br>#{movie.plot}<br>"
        desc += "#{movie.languages} / #{movie.subs}<br>"
        desc += "<a href='#{movie.url_imdb}'>#{movie.imdb_score}</a>" if movie.imdb_score
#        desc += "<br>" + image_tag(movie.photo.url(:medium), :alt => 'Photo')
        xml.title movie.title + " #{movie.year}"
        xml.description desc, :type => 'html'
        xml.pubDate movie.created_at.to_s(:rfc822)
        xml.link movie_url(movie)
        xml.guid movie_url(movie)
      end
    end
  end
end