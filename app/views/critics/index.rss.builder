xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "HDiesta Critics"
    xml.description "Last critics on HDiesta"
    xml.link movies_url


    for critic in @critics
      xml.item do
        xml.title critic.movie.title
        xml.description "by #{critic.user.username}<br><b>#{critic.score}/20</b><br>" + critic.content
        xml.pubDate critic.created_at.to_s(:rfc822)
        xml.link movie_url(critic.movie)
        xml.guid critic_url(critic)
      end
    end
  end
end