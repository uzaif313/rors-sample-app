rapp=angular.module("rapp",[])

rapp.controller("form-controller",["$scope",function($scope){
  $scope.name="First Rails ";
  console.log($scope.name);
}]);
