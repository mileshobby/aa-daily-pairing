const APIUtil = require('./api_util');

class TweetCompose {
  constructor(form) {
    this.$form = $(form);
    // this.$feed = this.$form.siblings("ul");
    this.$charsleft = $(".chars-left");
    this.$feed = $("#feed");
    console.log(this.$feed);
    this.$form.on("submit", (e) => {
      e.preventDefault();
      this.submit();
    });
    this.$form.find("textarea").on("keyup", (e)=>{

      let charsleft = 140 - $(e.target).val().length;
      console.log(charsleft);
      console.log(this.$charsleft);
      this.$charsleft.text(charsleft);
    });
  }

  submit() {
    let json = this.$form.serializeJSON();
    this.$form.find(":input").prop("disabled", true);
    APIUtil.createTweet(json, this.handleSuccess.bind(this));
  }

  clearInput(){
    this.$form.find(":input").val("");
  }

  handleSuccess(tweet){
    this.clearInput();
    this.$form.find(":input").prop("disabled", false);
    let toPost = JSON.stringify(tweet);
    let list = $(`<li>${toPost}</li>`);
    this.$feed.prepend(list);
  }

}

module.exports = TweetCompose;
