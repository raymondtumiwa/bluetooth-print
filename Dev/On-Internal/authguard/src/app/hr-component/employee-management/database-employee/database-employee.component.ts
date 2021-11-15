import { AfterViewInit, Component, OnInit, ViewChild } from '@angular/core';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatTableDataSource } from '@angular/material/table';
import { BreakpointObserver } from '@angular/cdk/layout';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA, MatDialogModule } from '@angular/material/dialog';
import { EmployeeRegistrationComponent } from '../../employee-registration/employee-registration.component';


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
  selector: 'app-database-employee',
  templateUrl: './database-employee.component.html',
  styleUrls: ['./database-employee.component.scss']
})
export class DatabaseEmployeeComponent implements AfterViewInit {
  displayedColumns = ['no', 'nama', 'username', 'role', 'division', 'action', 'penempatan', 'noKontrak', 'tanggalMasuk', 'tanggalHabisKontrak',
                        'alamatKtp', 'alamatDomisili', 'noWa', 'noHp', 'tempatLahir', 'tanggalLahir', 'noKtp', 'noNpwp', 'jenisSim', 'masaBerlakuSim', 'noStnk',
                      'statusKawin', 'jumlahAnak', 'namaBank', 'nomorRekening', 'namaRekening', 'statusKaryawan', 'attachment', 'resume', 'action1'];
  dataSource: MatTableDataSource<UserData>;

  @ViewChild(MatPaginator, { static: true }) paginator: MatPaginator = Object.create(null);
  @ViewChild(MatSort, { static: true }) sort: MatSort = Object.create(null);

  constructor(public dialog: MatDialog, breakpointObserver: BreakpointObserver) {

      breakpointObserver.observe(['(max-width: 600px)']).subscribe(result => {
          this.displayedColumns = result.matches ?
              ['no', 'nama','username', 'role', 'division', 'action', 'penempatan', 'noKontrak', 'tanggalMasuk', 'tanggalHabisKontrak', 'alamatKtp', 'alamatDomisili', 'noWa', 'noHp', 'tempatLahir', 'tanggalLahir', 'noKtp', 'noNpwp', 'jenisSim', 'masaBerlakuSim', 'noStnk',
              'statusKawin', 'jumlahAnak', 'namaBank', 'nomorRekening', 'namaRekening', 'statusKaryawan', 'attachment', 'resume', 'action1'] :
              ['no', 'nama', 'username', 'role', 'division', 'action', 'penempatan', 'noKontrak', 'tanggalMasuk', 'tanggalHabisKontrak', 'alamatKtp', 'alamatDomisili', 'noWa', 'noHp', 'tempatLahir', 'tanggalLahir', 'noKtp', 'noNpwp', 'jenisSim', 'masaBerlakuSim', 'noStnk',
              'statusKawin', 'jumlahAnak', 'namaBank', 'nomorRekening', 'namaRekening', 'statusKaryawan', 'attachment', 'resume', 'action1'] ;
      });

      // Create 100 users
      const users: UserData[] = [];
      for (let i = 1; i <= 100; i++) {
          users.push(createNewUser(i));
      }

      // Assign the data to the data source for the table to render
      this.dataSource = new MatTableDataSource(users);
  }
  openDialog(): void {
    const dialogRef = this.dialog.open(EmployeeRegistrationComponent, {
        width: '1000px',
    });
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
      penempatan: username,
      noKontrak: username,
      tanggalMasuk: username,
      tanggalHabisKontrak: username,
      alamatKtp: username,
      alamatDomisili: username,
      noWa: username,
      noHp: username,
      tempatLahir: username,
      tanggalLahir: username,
      noKtp: username,
      noNpwp: username,
      jenisSim: username,
      masaBerlakuSim: username,
      noStnk: username,
      statusKawin: username,
      jumlahAnak: username,
      namaBank: username,
      nomorRekening: username,
      namaRekening: username,
      statusKaryawan: username,
      attachment: username,
      resume: username,
      action1: username,
  };
}

export interface UserData {
  no: string;
  nama: string;
  username: string;
  role: string;
  division: string;
  action: string;
  penempatan: string;
  noKontrak: string;
  tanggalMasuk: string;
  tanggalHabisKontrak: string;
  alamatKtp: string;
  alamatDomisili: string;
  noWa: string;
  noHp: string;
  tempatLahir: string;
  tanggalLahir: string;
  noKtp: string;
  noNpwp: string;
  jenisSim: string;
  masaBerlakuSim: string;
  noStnk: string;
  statusKawin: string;
  jumlahAnak: string;
  namaBank: string;
  nomorRekening: string;
  namaRekening: string;
  statusKaryawan: string;
  attachment: string;
  resume: string;
  action1: string;

  
}

