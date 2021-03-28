# lita-reddit-image

Lita handler for querying images from Reddit.

## Installation

Add lita-reddit-image to your Lita instance's Gemfile:

``` ruby
gem "lita-reddit-image"
```

## Configuration

Only 2 required parameters:
* Your Reddit username
* Your Reddit App Id

Create a new Reddit App and get an App Id.

Your username is used in the User-Agent headers for querying the Reddit API, as
requested by Reddit developers.

```ruby
Lita.configure do |config|
  config.handlers.reddit_image.app_id = "reddit_developer_app_id"
  config.handlers.reddit_image.username = "reddit_username"
end
```

## Usage

Use the following syntax: `/r/[subreddit] [query]` to fetch an image from Reddit.

Ex.

```
Lita /r/aww Bunny
```
