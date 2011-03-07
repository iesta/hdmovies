xml.instruct!
xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
  xml.channel do
    xml.title       "HDiesta Critics"
    xml.description "Last critics on HDiesta"
    xml.pubDate     CGI.rfc1123_date(@critics.first.updated_at) if @critics.any?
    xml.link        movies_url

    for critic in @critics
      xml.item do
        xml.title       critic.movie.title
        xml.description "by #{critic.user.username}<br><b>#{critic.score}/20</b><br>" + critic.content
        xml.pubDate     critic.created_at.to_s(:rfc822)
        xml.link        movie_url(critic.movie)
        xml.guid        critic_url(critic)
        xml.author      "#{critic.user.username}"
      end
    end
  end
end