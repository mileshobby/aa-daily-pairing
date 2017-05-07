const FollowToggle = require('./follow_toggle');
const UsersSearch = require('./users_search');
const TweetCompose =require('./tweet_compose');

$(()=>{

  let $buttons = $(".follow-toggle");
  let toggles = [];
  $.each($buttons, (i, button)=>{
    console.log($(button));
    toggles.push(new FollowToggle($(button)));

  });

  let $searches = $(".users-search");
  let users = [];
  $searches.each((i, search) => {
    users.push( new UsersSearch(search));
  });

  let $forms = $(".tweet-compose");
  let tweets = [];
  $forms.each((i, form) => {
    tweets.push( new TweetCompose(form));
  });

});
