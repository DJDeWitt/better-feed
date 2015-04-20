// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .
//= require angular

var app = angular.module("myApp", []);

// Main Controller - Holding Criteria
app.controller('MainController',
['$scope', function($scope) {
  $scope.criteria = "";
}]);

// Judge Controller - Holding Voting Data

app.controller('JudgeController',
['$scope', function($scope) {
  $scope.total = 0;
  $scope.score = 0;
  // $scope.tweets = [
  // {
  //   name: 'The Book of Trees',
  //   pubdate: new Date('2014', '03', '08'),
  //   vote: 0,
  //   isSelected: "inactive"
  // },
  // {
  //   name: 'Program or be Programmed',
  //   pubdate: new Date('2013', '08', '01'),
  //   vote: 0,
  //   isSelected: "inactive"
  // }
  // ];
  console.log($('#products').data('products'));
  // Getting the array of tweets and converting it to an array of JS Objects
  $scope.tweets = $('#products').data('products');
  // Adding vote property to each object in the array
  $scope.tweets.forEach( function (arrayItem) {
        arrayItem.vote = 0;
    });

  $scope.voteUp = function(index) {
    if ($scope.tweets[index].vote === 0) {
      $scope.total += 1;
      $scope.score += 1;
    };
    if ($scope.tweets[index].vote === -1) { $scope.score += 2; };
    $scope.tweets[index].vote = 1;
    $scope.tweets[index].isSelected = "active";
  };
  $scope.voteDown = function(index) {
    if ($scope.tweets[index].vote === 0) {
      $scope.total += 1;
      $scope.score += -1;
    }
    if ($scope.tweets[index].vote === 1) { $scope.score -= 2; };
    $scope.tweets[index].vote = -1;
    $scope.tweets[index].isSelected = "active";
  };
  $scope.getUpClass = function(index){
        if( $scope.tweets[index].vote === 1 ){
            return "tweet-voted-up";
        } else{
            return "tweet-vote-up";
        }
      };
  $scope.getDownClass = function(index){
      if( $scope.tweets[index].vote === -1 ){
          return "tweet-voted-down";
      } else{
          return "tweet-vote-down";
      }
    };
}]);





// Other Random Stuff that's definitely not actually necessary and should be removed
$('body').on('click', '.twitter-follow-button', function (e) {
    $('.twitter-follow-button').val('Followed!')
  })

$('body').on('click', '.twitter-unfollow-button', function (e) {
    $('.twitter-unfollow-button').val('Unfollowed!')
  })