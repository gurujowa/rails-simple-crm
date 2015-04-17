myApp = angular.module('progress', [ 'ui.grid', 'ui.grid.resizeColumns',
  'ui.grid.expandable'
  'ui.grid.edit'
])
myApp.controller 'SpicyCtrl', [ '$scope','$http','$filter',($scope, $http, $filter) ->
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
      i = 0
      while i < data.length
        data[i].subGridOptions =
          showGridFooter: false
          columnDefs: [
            { name: 'day'}
            { name: 'teacher', field: 'teacher'}
            { name: 'start_time', field: 'start_time' }
            { name: 'end_time', field: 'end_time' }
          ]
          data: data[i].periods
        data[i].getStartDate = -> 
          ar = []
          angular.forEach this.periods, (value,key)-> ar.push(new Date(value.day))
          return $filter('date')(new Date(Math.max.apply(null,ar)),"yyyy/MM/dd")
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
          console.log data
        ).error (data) ->
          alert data
        
        $scope.$apply()
]
