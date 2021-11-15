import { Component, ViewChild } from '@angular/core';

declare var require: any;
const data: any = require('src/assets/company.json');

@Component({
  selector: 'app-data-table',
  templateUrl: './data-table.component.html',
  styleUrls: ['./data-table.component.scss']
})
export class DataTableComponent {
  editing = {};
  rows = [];
  temp = [...data];

  loadingIndicator = true;
  reorderable = true;

  columns = [{ prop: 'name' }, { name: 'Gender' }, { name: 'Company' }];

  @ViewChild(DataTableComponent, { static: true }) table: DataTableComponent = Object.create(null);
  constructor() {
    this.rows = data;
    this.temp = [...data];
    setTimeout(() => {
      this.loadingIndicator = false;
    }, 1500);
  }

  updateFilter(event: any): void {
    const val = event.target.value.toLowerCase();
  }
}
