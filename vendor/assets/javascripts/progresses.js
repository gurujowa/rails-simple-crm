var myApp = angular.module('progress', ['ui.grid', 'ui.grid.resizeColumns',  'ui.grid.expandable']);
myApp.controller('SpicyCtrl', ['$scope','$http', function($scope,$http, $log){
    $scope.gridOptions = {
      enableSorting: true,
      enableFiltering: true,
      maxVisibleRowCount: 20,
      expandableRowTemplate: 'expandableRowTemplate.html',
      expandableRowHeight: 150,
      expandableRowScope: {
      subGridVariable: 'subGridScopeVariable'
    }
    };
    $scope.gridOptions.columnDefs = [
        {name:'id', width: 50, enableColumnResizing: false},
        {name:'name'},
        {name:'company'},
        {name:'responsible'},
        {name:'memo'},
    ];
    $http.get('/progresses/data.json')
      .success(function(data) {
        for(i = 0; i < data.length; i++){
          data[i].subGridOptions = {
            columnDefs: [ {name:"Id", field:"id"},{name:"Name", field:"name"} ],
            data: data[i].periods
          }
        }
        $scope.gridOptions.data = data;
      }).error(function(data) {
        alert("エラーが発生しました。" + data);

      });

}]);
