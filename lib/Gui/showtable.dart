import 'package:attendance/model/models.dart';
import 'package:attendance/shared/Services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

// ignore: must_be_immutable, camel_case_types
class showtable extends StatefulWidget {
  dynamic flag;
  // showtable(this.flag);
  // int showid;
  // showtable(this.showid);
  @override
  _showtableState createState() => _showtableState();
}

// ignore: camel_case_types
class _showtableState extends State<showtable> {
  @override
  Widget build(BuildContext context) {
// var flag = Provider.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepPurple, title: const Text('Query Page')),
      body: FutureBuilder(
        future: getProductDataSource(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.hasData
              ? SfDataGridTheme(
                  data: SfDataGridThemeData(
                    // gridLineColor: Colors.amber, gridLineStrokeWidth: 3.0,
                    headerHoverColor: Colors.yellow,
                    headerColor: const Color(0xFFB2EBF2),
                  ),
                  // rowHoverColor: Colors.yellow,
                  // rowHoverTextStyle: TextStyle(
                  //   color: Colors.red,
                  //   fontSize: 14,
                  // )),
                  child: SfDataGrid(
                    source: snapshot.data, columns: getColumns(),
                    allowPullToRefresh: true,
                    // rowsPerPage: 0,
                    // allowEditing: true,
                    // allowSorting: true,
                    // allowColumnsResizing: true,
                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.horizontal,
                    highlightRowOnHover: false,
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                );
        },
      ),

    ));
  }

  Future<ProductDataGridSource> getProductDataSource() async {
    var productList = await generateProductList(widget.flag);
    return ProductDataGridSource(productList);
  }
}

class ProductDataGridSource extends DataGridSource {
  ProductDataGridSource(this.productList) {
    buildDataGridRow();
  }
  List<DataGridRow> dataGridRows;
  List<Product> productList;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        // color: Colors.grey,
        cells: [
          Container(
            child: Text(
              row.getCells()[0].value,
              // row.getCells()[0].value.toString(),
              overflow: TextOverflow.ellipsis,
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(8.0),
          ),
          Container(
            child: Text(
              row.getCells()[1].value,
              // row.getCells()[0].value.toString(),
              overflow: TextOverflow.ellipsis,
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(8.0),
          ),
          Container(
            child: Text(
              row.getCells()[2].value,
              // row.getCells()[0].value.toString(),
              overflow: TextOverflow.ellipsis,
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(8.0),
          ),
          Container(
            child: Text(
              row.getCells()[3].value,
              // row.getCells()[0].value.toString(),
              overflow: TextOverflow.ellipsis,
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(8.0),
          ),
          Container(
            child: Text(
              row.getCells()[4].value,
              // row.getCells()[0].value.toString(),
              overflow: TextOverflow.ellipsis,
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(8.0),
          ),
          Container(
            child: Text(
              row.getCells()[5].value,
              // row.getCells()[0].value.toString(),
              overflow: TextOverflow.ellipsis,
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(8.0),
          ),

        ]);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  void buildDataGridRow() {
    dataGridRows = productList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<dynamic>(columnName: 'emp_id', value: dataGridRow.emp_id),
        DataGridCell<dynamic>(
            columnName: 'work_date', value: dataGridRow.work_date),
        DataGridCell<dynamic>(
            columnName: 'ord_due_date', value: dataGridRow.work_type),
        DataGridCell<dynamic>(
            columnName: 'start_time', value: dataGridRow.start_time),
        DataGridCell<dynamic>(
            columnName: 'end_time', value: dataGridRow.end_time),
        DataGridCell<dynamic>(
            columnName: 'shift_id', value: dataGridRow.shift_id),
        //   DataGridCell<dynamic>( columnName: 'created_user', value: dataGridRow.created_user),shift_id
        //   DataGridCell<dynamic>( columnName: 'created_date', value: dataGridRow.created_date),
        //   DataGridCell<dynamic>( columnName: 'changed_user', value: dataGridRow.changed_user),
        //   DataGridCell<dynamic>( columnName: 'changed_date', value: dataGridRow.changed_date),
      ]);
    }).toList(growable: false);
  }
}

List<GridColumn> getColumns() {
  return <GridColumn>[
    // ignore: deprecated_member_use
    GridTextColumn(
        columnName: 'emp_id',
        width: 80,
        // allowEditing: false,
        label: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text('emp_id'))),
    // ignore: deprecated_member_use
    GridTextColumn(
        columnName: 'work_date',
        width: 120,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'work_date',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        )),
    // ignore: deprecated_member_use
    GridTextColumn(
        columnName: 'work_type',
        width: 80,
        label: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerRight,
            child: Text('work_type',
                overflow: TextOverflow.clip, softWrap: true))),
    // ignore: deprecated_member_use
    GridTextColumn(
        columnName: 'start_time',
        width: 80,
        label: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text('start_time',
                overflow: TextOverflow.clip, softWrap: true))),
    // ignore: deprecated_member_use
    GridTextColumn(
        columnName: 'end_time',
        width: 80,
        label: Container(
            padding: EdgeInsets.all(5),
            alignment: Alignment.centerLeft,
            child:
                Text('end_time', overflow: TextOverflow.fade, softWrap: true))),
    // ignore: deprecated_member_use
    GridTextColumn(
        columnName: 'shift_id',
        width: 80,
        label: Container(
            padding: EdgeInsets.all(5),
            alignment: Alignment.centerLeft,
            child:
                Text('shift_id', overflow: TextOverflow.fade, softWrap: true))),
    // ignore: deprecated_member_use
  ];
}
