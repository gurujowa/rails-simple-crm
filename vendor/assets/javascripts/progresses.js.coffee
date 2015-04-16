myApp = angular.module('progress', [ 'ui.grid', 'ui.grid.resizeColumns',
  'ui.grid.expandable'
  'ui.grid.edit'
])
myApp.controller 'SpicyCtrl', [ '$scope','$http',($scope, $http, $log) ->
    $scope.gridOptions =
      enableSorting: true
      enableFiltering: true
      maxVisibleRowCount: 20
      expandableRowTemplate: '/progresses/sub'
      expandableRowHeight: 200
      expandableRowScope: subGridVariable: 'subGridScopeVariable'
    $scope.gridOptions.columnDefs = [
      {
        name: 'id'
        width: 50
        enableColumnResizing: false
        enableCellEdit: false
      }, {
        name: 'name'
        displayName: 'コース名'
      },{
        name: 'company'
        enableCellEdit: false
      }, {
        name: 'responsible'
        enableCellEdit: true
      }, { name: 'memo' }
    ]
    $http.get('/progresses/data.json').success((data) ->
      i = 0
      while i < data.length
        data[i].subGridOptions =
          showGridFooter: false
          columnDefs: [
            { name: 'day',field: 'day' }
            { name: 'teacher',field: 'teacher' }
            { name: 'start_time',field: 'start_time' }
            { name: 'end_time',field: 'end_time' }
          ]
          data: data[i].periods
        i++
      $scope.gridOptions.data = data
    ).error (data) ->
      alert 'エラーが発生しました。' + data

    $scope.gridOptions.onRegisterApi = (gridApi) ->
      $scope.gridApi = gridApi
      gridApi.edit.on.afterCellEdit $scope, (rowEntity, colDef, newValue, oldValue) ->
        colDef.id = rowEntity.id
        colDef.new_value = newValue
        $http.post('/progresses/update',colDef).success((data,status,headers) ->
          console.log data, status
        ).error (data) ->
          alert data
        
        $scope.$apply()
]
