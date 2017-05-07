const APIUtil = require("./api_util");

class FollowToggle{
  constructor($el, options){
    this.userId = $el.data("user-id") || options.userId;
    this.followState = $el.data("initial-follow-state") || options.followState;
    this.$el = $el;
    this.render();
    this.render = this.render.bind(this);
    this.toggleState1 = this.toggleState1.bind(this);
    this.toggleState2 = this.toggleState2.bind(this);
    this.handleClick();
  }

  handleClick(){
    this.$el.click((e) => {
      let method =  this.followState === "unfollowed" ?
                    APIUtil.followUser : APIUtil.unfollowUser;
      e.preventDefault();
      method(this.userId)
        .then(this.toggleState2)
        .then(this.render);

      this.toggleState1();
      this.render();
    });
  }

  toggleState2(){
    this.followState = this.followState === "following" ? "followed" : "unfollowed";
  }

  toggleState1(){
    this.followState = this.followState === "unfollowed" ? "following" : "unfollowing";
  }

  render(){
    let word;
    if (this.followState === "following"){
      this.$el.prop("disabled", true);
      word = "Following!";
    } else if (this.followState === "unfollowing") {
      this.$el.prop("disabled", true);
      word = "Unfollowing!";
    } else if (this.followState === "followed") {
      this.$el.prop("disabled", false);
      word = "Unfollow";
    } else {
      this.$el.prop("disabled", false);
      word = "Follow";
    }
    this.$el.text(word);
    return word;
  }
}

module.exports = FollowToggle;
