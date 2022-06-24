# Project 2 - *Name of App Here*

Twitter is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: 28 hours spent in total

https://imgur.com/a/yNlpq5C

https://imgur.com/a/yNlpq5C.gif

## User Stories

The following **core** features are completed:

**A user should**

- [x] See an app icon in the home screen and a styled launch screen
- [x] Be able to log in using their Twitter account
- [x] See at latest the latest 20 tweets for a Twitter account in a Table View
- [x] Be able to refresh data by pulling down on the Table View
- [x] Be able to like and retweet from their Timeline view
- [x] Only be able to access content if logged in
- [x] Each tweet should display user profile picture, username, screen name, tweet text, timestamp, as well as buttons and labels for favorite, reply, and retweet counts.
- [x] Compose and post a tweet from a Compose Tweet view, launched from a Compose button on the Nav bar.
- [x] See Tweet details in a Details view
- [x] App should render consistently all views and subviews in recent iPhone models and all orientations

The following **stretch** features are implemented:

**A user could**

- [x] Be able to **unlike** or **un-retweet** by tapping a liked or retweeted Tweet button, respectively. (Doing so will decrement the count for each)
- [ ] Click on links that appear in Tweets
- [ ] See embedded media in Tweets that contain images or videos
- [ ] Reply to any Tweet (**2 points**)
  - Replies should be prefixed with the username
  - The `reply_id` should be set when posting the tweet
- [x] See a character count when composing a Tweet (as well as a warning) (280 characters) (**1 point**)
- [x] Load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client
- [ ] Click on a Profile image to reveal another user's profile page, including:
  - Header view: picture and tagline
  - Basic stats: #tweets, #following, #followers
- [ ] Switch between **timeline**, **mentions**, or **profile view** through a tab bar (**3 points**)
- [ ] Profile Page: pulling down the profile page should blur and resize the header image. (**4 points**)

The following **additional** features are implemented:

- [x] List anything else that you can get done to improve the app functionality!
- [x] Added a feature to delect a cell once you click on it and come back (previously woudl stay grey

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. If anyone did the Profile Page
2. I also want to talk about how people did the Views page.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='[http://i.imgur.com/link/to/your/gif/file.gif](https://imgur.com/a/yNlpq5C)' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [Kap](https://getkap.co/).

## Notes
The Challeneges I had while writing this app was defineitely the Auto Layout. I learned in the begginning that there was a way to automatically put
the constraints into a view controller; however, I ran into a lot of bugs and when I would rotate it would not work or look well. It took a while but I realized the issue was that the objects would overlap. Another issue I had was when I tried to segue from the timeline Controller to the Deatil controller however when i tried to segue it wouldn't work because it would segue to the navigation bar of the detial controller. I declared the navigation bar a details view controlelr so thats why I was convinced it would work. However, when i debugged that I decided to delete the Navigation bar and things became easier. There was a lot of issues with the tableView and story board in the beginning as well. Felt very unfamilar to me still and had a lot fo bugs but I soon got the hang of it.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

    Copyright [2022] [Aman Abraham]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
