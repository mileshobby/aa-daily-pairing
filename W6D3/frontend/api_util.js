const APIUtil = {
  followUser: id => (
    $.ajax({
      type: 'post',
      url: `/users/${id}/follow`,
      dataType: "json",
    })
  ),

  unfollowUser: id => (
    $.ajax({
      type: 'delete',
      url: `/users/${id}/follow`,
      dataType: "json",
    })
  ),

  searchUsers: (queryVal, success) => {
    return $.ajax({
      type: 'get',
      url: '/users/search',
      dataType: "json",
      data: {"query": queryVal}
    }).then(success);
  },

  createTweet: (data, handleSuccess) => {
    return $.ajax({
      type: 'post',
      url: '/tweets',
      dataType: "json",
      data: data
    }).then(handleSuccess);
  }
};

module.exports = APIUtil;
