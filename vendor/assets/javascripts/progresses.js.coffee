myApp = angular.module('progress', [ 
  'ui.bootstrap'
  'ui.grid'
  'ui.grid.resizeColumns'
  'ui.grid.edit'
])
myApp.controller 'SpicyCtrl', [ '$scope','$http','$modal',  ($scope, $http, $modal) ->
  $scope.open = (size) ->
    modal = $modal.open {
      templateUrl: 'myModalContent.html',
      controller: 'ModalInstanceCtrl',
      size: size,
    }
 
  $scope.showId = (grid, row) ->
    console.log grid
    return row.entity.id
  $scope.gridOptions =
    enableSorting: true
    enableFiltering: true
    maxVisibleRowCount: 20
  $scope.gridOptions.columnDefs = [
    {
      name: 'id'
      width: 50
      enableColumnResizing: false
      enableCellEdit: false
      cellTemplate: '<div class="progress_row_id"><a href="/">{{row.entity.id}}</a></div>'
    }, {
      name: 'name'
      displayName: 'コース名'
    },{
      name: 'company'
      enableCellEdit: false
    }, {
      name: 'responsible'
      enableCellEdit: true
    }, { 
      name: 'start_date'
      field: 'getStartDate()'
      enableCellEdit: false
    }, { 
      name: 'memo'
      enableCellEdit: true
    }
  ]

  $http.get('/progresses/data.json').success((data) ->
    $scope.gridOptions.data = data
  ).error (data) ->
    alert 'エラーが発生しました。' + data

  $scope.gridOptions.onRegisterApi = (gridApi) ->
    $scope.gridApi = gridApi
    gridApi.edit.on.afterCellEdit $scope, (rowEntity, colDef, newValue, oldValue) ->
      colDef.id = rowEntity.id
      colDef.new_value = newValue
      $http.post('/progresses/update',colDef).success((data,status,headers) ->
        console.log data
      ).error (data) ->
        alert data
      
      $scope.$apply()
]

angular.module('ui.bootstrap').controller 'ModalInstanceCtrl', ($scope, $modalInstance) ->
  $scope.items = "OK"

