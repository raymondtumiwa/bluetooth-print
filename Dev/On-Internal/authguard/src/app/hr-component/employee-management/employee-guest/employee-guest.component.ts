import { AfterViewInit, Component, OnInit, ViewChild } from '@angular/core';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatTableDataSource } from '@angular/material/table';
import { BreakpointObserver } from '@angular/cdk/layout';

const COLORS = [
  'maroon',
  'red',
  'orange',
  'yellow',
  'olive',
  'green',
  'purple',
  'fuchsia',
  'lime',
  'teal',
  'aqua',
  'blue',
  'navy',
  'black',
  'gray'
];

const NAMES = [
  'Maia',
  'Asher',
  'Olivia',
  'Atticus',
  'Amelia',
  'Jack',
  'Charlotte',
  'Theodore',
  'Isla',
  'Oliver',
  'Isabella',
  'Jasper',
  'Cora',
  'Levi',
  'Violet',
  'Arthur',
  'Mia',
  'Thomas',
  'Elizabeth'
];

@Component({
  selector: 'app-employee-guest',
  templateUrl: './employee-guest.component.html',
  styleUrls: ['./employee-guest.component.scss']
})
export class EmployeeGuestComponent implements AfterViewInit {
  displayedColumns = ['no', 'nama', 'username', 'role', 'division', 'action'];
  dataSource: MatTableDataSource<UserData>;

  @ViewChild(MatPaginator, { static: true }) paginator: MatPaginator = Object.create(null);
  @ViewChild(MatSort, { static: true }) sort: MatSort = Object.create(null);

  constructor(breakpointObserver: BreakpointObserver) {

      breakpointObserver.observe(['(max-width: 600px)']).subscribe(result => {
          this.displayedColumns = result.matches ?
              ['no', 'nama','username', 'role', 'division', 'action'] :
              ['no', 'nama', 'username', 'role', 'division', 'action'];
      });

      // Create 100 users
      const users: UserData[] = [];
      for (let i = 1; i <= 100; i++) {
          users.push(createNewUser(i));
      }

      // Assign the data to the data source for the table to render
      this.dataSource = new MatTableDataSource(users);
  }

  /**
   * Set the paginator and sort after the view init since this component will
   * be able to query its view for the initialized paginator and sort.
   */
  ngAfterViewInit(): void {
      this.dataSource.paginator = this.paginator;
      this.dataSource.sort = this.sort;
  }

  applyFilter(filterValue: string): void {
      filterValue = filterValue.trim(); // Remove whitespace
      filterValue = filterValue.toLowerCase(); // Datasource defaults to lowercase matches
      this.dataSource.filter = filterValue;
  }
}
/** Builds and returns a new User. */
function createNewUser(no: number): UserData {
  const username = NAMES[Math.round(Math.random() * (NAMES.length - 1))] + ' ' +
      NAMES[Math.round(Math.random() * (NAMES.length - 1))].charAt(0) + '.';
  // tslint:disable-next-line - Disables all
  return {
      no: no.toString(),
      nama: username,
      username: username,
      role: Math.round(Math.random() * 100).toString(),
      division: COLORS[Math.round(Math.random() * (COLORS.length - 1))],
      action: username,
  };
}

export interface UserData {
  no: string;
  nama: string;
  username: string;
  role: string;
  division: string;
  action: string;
  
}

