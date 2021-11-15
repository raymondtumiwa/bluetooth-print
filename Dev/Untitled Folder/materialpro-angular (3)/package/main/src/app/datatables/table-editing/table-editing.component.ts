import { Component, ViewChild } from '@angular/core';

declare var require: any;
const data: any = require('src/assets/company.json');

@Component({
  selector: 'app-table-editing',
  templateUrl: './table-editing.component.html',
  styleUrls: ['./table-editing.component.scss']
})
export class TableEditingComponent {
  editing: any = {};
  rows: any = new Array();
  temp = [...data];

  loadingIndicator = true;
  reorderable = true;

  columns = [{ prop: 'name' }, { name: 'Gender' }, { name: 'Company' }];

  @ViewChild(TableEditingComponent, { static: true }) table: TableEditingComponent | any;

  constructor() {
    this.rows = data;
    this.temp = [...data];
    setTimeout(() => { this.loadingIndicator = false; }, 1500);
  }

  updateFilter(event: any): void {
    const val = event.target.value.toLowerCase();
    // update the rows
    // Whenever the filter changes, always go back to the first page
    this.table = data;
  }
  updateValue(event: any, cell: any, rowIndex: number): void {
    this.editing[rowIndex + '-' + cell] = false;
    this.rows[rowIndex][cell] = event.target.value;
    this.rows = [...this.rows];
  }
}
