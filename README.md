# Twitter

This iOS project is a reproduction of the Twitter mobile application using an OAuth Authentication Flow and the [Twitter API](https://apps.twitter.com/).

## User Stories

The following user stories are completed and serve as a baseline:

- [X] User sees app icon in home screen and styled launch screen.
- [X] User can sign in using OAuth login flow, and logout.
- [X] The current signed in user will be persisted across restarts.
- [X] Abstract users, tweets, and networking into an MVC architecture.
- [X] User can view last 20 tweets from their home timeline with the user profile picture, username, tweet text, and timestamp.
- [X] User can pull to refresh.
- [X] User can tap the favorite button in a cell to favorite and unfavorite tweet.
- [X] User can tap the retweet button in a cell to retweet and unretweet.
- [X] User can tap on a tweet to view it in a detail view, with controls to retweet, favorite, and reply.
- [X] User can compose a new tweet by tapping on a compose button.
- [X] When composing a tweet, user sees a countdown for the number of characters remaining for the tweet (out of 140)
- [X] User can view their profile in a profile tab
- [X] Using AutoLayout, the Tweet cell should adjust it's layout for iPhone 7, Plus and SE device sizes as well as accommodate device rotation.

The following challenge stories would make great additions:

- [] User can add friends and see a list of friends they've added
- [] User can see only their own tweets in their profile tab

## Walkthrough

<img src='https://imgur.com/aHbMfXv.gif' title='Twitter Walkthrough #1' width='' alt='Login/Logout/Persistence' />
<img src='https://imgur.com/7LXpJS5.gif' title='Twitter Walkthrough #2' width='' alt='Main Functionalities' />
<img src='https://imgur.com/2c6ML1E.gif' title='Twitter Walkthrough #3' width='' alt='Detailed Functionality' />

## Notes

This is my most complex iOS project as of September 2018. This combines a huge number of arcithectures and techniques that I've learned over the past 60 days.

**Backend Elements**: 
- Learning the ins-and-outs of the OAuth Flow. What is authentication versus authorization? When should each be used?
- Learning the ins-an-outs of the Twitter API. Their rate-limiting is super frustrating! But their documentation is quite fabulous and intuitive once you get into it.
- Configuring the AppDelegate to respond in the correct sequence. The NotificationCenter (NSObject) class in Swift is what allows me to utilize the observer design pattern for optimal signin/signout functionality.

**Frontend Elements**:
- Learning how to mediate between modal seuges and show segues; modal segues remove the navigation stack, so implementing them requires extra care.
- Many graphic elements can only be adjusted programatically, which sometimes causes a rendering delay when loading this view. Plus, sometimes the storyboard and code conflict and it's not clear which gets precedence 
- Frustrated with asynchronous newtork requests. They are obviously important to keep the UI.UX running smoothly, but information gets updated in a haphhazard way.

## Credits

The following 3rd party libraries, icons, graphics, and other assets were used during development:

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - Networking Task Library
- [AlamofireImage](https://github.com/Alamofire/AlamofireImage) – Image Component Library
- [OAuthSwift](https://github.com/OAuthSwift/OAuthSwift) – Swift-Based OAuth Library
- [KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess) – Swift Wrapper For Keychain

## License

    Copyright 2018 Rajeev Ram 
