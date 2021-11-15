import { Component, OnInit } from '@angular/core';

interface ObjType {
  item_id: number; item_text: string;
}


@Component({
  selector: 'app-multiselect',
  templateUrl: './multiselect.component.html',
  styleUrls: ['./multiselect.component.css']
})
export class MultiselectComponent implements OnInit {
  dropdownList: ObjType[] = [];
  cities: string[] = [];
  selectedItems: ObjType[] = [];
  singleselectedItems: string[] = [];
  dropdownSettings = {};
  singledropdownSettings = {};
  closeDropdownSelection = false;

  ngOnInit(): void {
    this.dropdownList = [
      { item_id: 1, item_text: 'Mumbai' },
      { item_id: 2, item_text: 'Bangaluru' },
      { item_id: 3, item_text: 'Pune' },
      { item_id: 4, item_text: 'Navsari' },
      { item_id: 5, item_text: 'New Delhi' }
    ];
    this.cities = ['Mumbai', 'New Delhi', 'Bangaluru', 'Pune', 'Navsari'];
    this.selectedItems = [
      { item_id: 3, item_text: 'Pune' },
      { item_id: 4, item_text: 'Navsari' }
    ];
    this.singleselectedItems = ['Pune'];
    this.singledropdownSettings = {
      singleSelection: true,
      selectAllText: 'Select All',
      unSelectAllText: 'UnSelect All',
      allowSearchFilter: true,
      closeDropDownOnSelection: this.closeDropdownSelection
    };
    this.dropdownSettings = {
      singleSelection: false,
      idField: 'item_id',
      textField: 'item_text',
      selectAllText: 'Select All',
      unSelectAllText: 'UnSelect All',
      itemsShowLimit: 3,
      allowSearchFilter: true
    };
  }
  onItemSelect(item: any): void {
    console.log(item);
  }
  onSelectAll(items: any): void {
    console.log(items);
  }
}
