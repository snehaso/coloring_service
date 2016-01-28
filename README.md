# Coloring Service json API

This  API accepts words, converts them to colored html words and sends them to pusher channel for streaming.

TO run API on local `rackup -p <port>`

# API Endpoint

POST `http://localhost:4567/color`


Request body accepts:

  words = Array of words

  color_scheme = String [Options: black_on_white or random]. The default color scheme is black text on white background

  pusher_notification_channel = name of pusher channel where browser is subscribed.

# Example:

POST `http://localhost:4567/color`

Request Body
```
{
  "words": ["The", "trek", "to", "Triund"],
  "pusher_notification_channel": "user_prod_23454",
  "color_scheme": "color_scheme"
}
```

Response :
```
{"success":"ok"}
```
HTTP Status 200

## Specifications

```
  Color
    return html words without any css(as default scheme is black)
    return html words with random color scheme

  ColoringService
    sends colored words to pusher channel
    should default color scheme to black on white
    return 404 if words are not sent in request
    return 404 if pusher channel is not present in request body
```
