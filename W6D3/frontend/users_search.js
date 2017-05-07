const APIUtil = require('./api_util');
const FollowToggle = require('./follow_toggle');

class UsersSearch{

  constructor(el){
    this.$el = $(el);
    this.$input = this.$el.find("input");
    this.$ul = this.$el.find("ul");
    this.renderResults.bind(this);
    this.handleInput();
  }

  handleInput(){
    this.$input.keyup((e)=>{
      let queryVal = this.$input.val();
      APIUtil.searchUsers(queryVal, this.renderResults.bind(this));
    });
  }

  renderResults(data){
    this.$ul.empty();
    console.log(data);
    for (let i = 0; i < data.length; i++) {
      let $user = $(`<li><a href=/users/${data[i].id}>${data[i].username}</a></li>`);
      let $button = $('<button>').css("margin-left", "10px");
      let follow = (data[i].follows ? "followed" : "unfollowed");
      let toggle = new FollowToggle($button,
                  {userId: data[i].id, followState: follow});
      $user.append($button);
      this.$ul.append($user);
    }
  }

}


module.exports = UsersSearch;
