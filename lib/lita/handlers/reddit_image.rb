require 'json'
require 'rest-client'
require 'uri'
require 'open-uri'

module Lita
  module Handlers
    class RedditImage < Handler

      config :app_id,   type: String, required: true
      config :username, type: String, required: true

      route(/\/r\/(?<subreddit>.+)\s(?<query>(.+))/i, :fetch, command: true, help: {
        "/r/[subreddit] QUERY" => "Displays a random image from [subreddit]."
      })

      def fetch(response)
        (subreddit, query) = response.matches.to_a.flatten

        subreddit.strip!
        query.strip!

        json = JSON.parse(RestClient.get(reddit_url(subreddit, query), user_agent: reddit_user_agent))

        json['data']['children'].each do |post|

          post_title = post['data']['title']
          post_url = post['data']['url']

          # return if image was found
          if (/[\w:]+\.(jpe?g|png|gif)/i =~ post_url)
            filename = $~
            return response.reply([post_title, post_url].join(": "))
          end

          # keep searching, but wait half a second between requests
          sleep 0.5
        rescue StandardError => e
          Lita.logger.warn("Couldn't fetch image from Reddit: " + e.message)
        end
      end

      protected

      def reddit_url(subreddit, query)
        URI.parse('https://www.reddit.com/r/' + subreddit + '/search.json?q=' + query + '&restrict_sr=on').to_s
      end

      def reddit_user_agent
        "#{platform}:#{config.app_id}:#{version} (by /u/#{config.username})"
      end

      def platform
        'ruby'
      end

      def version
        VERSION
      end

      private

      def content_type(filename)
        case filename
        when /[\w:]+\.jpe?g/i
          'image/jpeg'
        when /[\w:]+\.png/i
          'image/png'
        when /[\w:]+\.gif/i
          'image/gif'
        else
          'image/jpeg'
        end
      end

    end

    Lita.register_handler(RedditImage)
  end
end
