import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, FormBuilder } from '@angular/forms';
import { Observable } from 'rxjs/Observable';
import { map, startWith } from 'rxjs/operators';

export class State {
  constructor(
    public name: string,
    public population: string,
    public flag: string
  ) { }
}

export interface StateGroup {
  letter: string;
  names: string[];
}

export interface User {
  name: string;
}

// tslint:disable-next-line - Disables all
export const _filter = (opt: string[], value: string): string[] => {
  const filterValue = value.toLowerCase();

  return opt.filter(item => item.toLowerCase().indexOf(filterValue) === 0);
};

@Component({
  selector: 'app-autocomplete',
  templateUrl: './autocomplete.component.html',
  styleUrls: ['./autocomplete.component.scss']
})
export class AutocompleteComponent implements OnInit {
  // state autocomplate
  stateCtrl: FormControl;
  filteredStates: Observable<any[]>;

  // 2
  myControl1 = new FormControl();
  options: string[] = ['One', 'Two', 'Three'];

  // 3

  stateForm: FormGroup = this.fb.group({
    stateGroup: ''
  });

  stateGroups: StateGroup[] = [
    {
      letter: 'A',
      names: ['Alabama', 'Alaska', 'Arizona', 'Arkansas']
    },
    {
      letter: 'C',
      names: ['California', 'Colorado', 'Connecticut']
    },
    {
      letter: 'D',
      names: ['Delaware']
    },
    {
      letter: 'F',
      names: ['Florida']
    },
    {
      letter: 'G',
      names: ['Georgia']
    },
    {
      letter: 'H',
      names: ['Hawaii']
    },
    {
      letter: 'I',
      names: ['Idaho', 'Illinois', 'Indiana', 'Iowa']
    },
    {
      letter: 'K',
      names: ['Kansas', 'Kentucky']
    },
    {
      letter: 'L',
      names: ['Louisiana']
    },
    {
      letter: 'M',
      names: [
        'Maine',
        'Maryland',
        'Massachusetts',
        'Michigan',
        'Minnesota',
        'Mississippi',
        'Missouri',
        'Montana'
      ]
    },
    {
      letter: 'N',
      names: [
        'Nebraska',
        'Nevada',
        'New Hampshire',
        'New Jersey',
        'New Mexico',
        'New York',
        'North Carolina',
        'North Dakota'
      ]
    },
    {
      letter: 'O',
      names: ['Ohio', 'Oklahoma', 'Oregon']
    },
    {
      letter: 'P',
      names: ['Pennsylvania']
    },
    {
      letter: 'R',
      names: ['Rhode Island']
    },
    {
      letter: 'S',
      names: ['South Carolina', 'South Dakota']
    },
    {
      letter: 'T',
      names: ['Tennessee', 'Texas']
    },
    {
      letter: 'U',
      names: ['Utah']
    },
    {
      letter: 'V',
      names: ['Vermont', 'Virginia']
    },
    {
      letter: 'W',
      names: ['Washington', 'West Virginia', 'Wisconsin', 'Wyoming']
    }
  ];

  stateGroupOptions: Observable<StateGroup[]> = Object.create(null);

  states: State[] = [
    {
      name: 'Arkansas',
      population: '2.978M',
      // https://commons.wikimedia.org/wiki/File:Flag_of_Arkansas.svg
      flag:
        'https://upload.wikimedia.org/wikipedia/commons/9/9d/Flag_of_Arkansas.svg'
    },
    {
      name: 'California',
      population: '39.14M',
      // https://commons.wikimedia.org/wiki/File:Flag_of_California.svg
      flag:
        'https://upload.wikimedia.org/wikipedia/commons/0/01/Flag_of_California.svg'
    },
    {
      name: 'Florida',
      population: '20.27M',
      // https://commons.wikimedia.org/wiki/File:Flag_of_Florida.svg
      flag:
        'https://upload.wikimedia.org/wikipedia/commons/f/f7/Flag_of_Florida.svg'
    },
    {
      name: 'Texas',
      population: '27.47M',
      // https://commons.wikimedia.org/wiki/File:Flag_of_Texas.svg
      flag:
        'https://upload.wikimedia.org/wikipedia/commons/f/f7/Flag_of_Texas.svg'
    }
  ];

  // 4

  myControl = new FormControl();
  options1: User[] = [{ name: 'Mary' }, { name: 'Shelley' }, { name: 'Igor' }];
  filteredOptions: Observable<User[]> = Object.create(null);

  // 5

  myControl2 = new FormControl();
  options2: string[] = ['One', 'Two', 'Three'];
  filteredOptions1: Observable<string[]> = Object.create(null);

  // 6

  highControl = new FormControl();
  options3: string[] = ['One', 'Two', 'Three'];
  filteredOptions2: Observable<string[]> = Object.create(null);

  constructor(private fb: FormBuilder) {
    this.stateCtrl = new FormControl();
    this.filteredStates = this.stateCtrl.valueChanges.pipe(
      startWith(''),
      map(state => (state ? this.filterStates(state) : this.states.slice()))
    );
  }

  // tslint:disable-next-line - Disables all
  filterStates(name: string): any {
    return this.states.filter(
      state => state.name.toLowerCase().indexOf(name.toLowerCase()) === 0
    );
  }

  // tslint:disable-next-line - Disables all
  ngOnInit(): void {
    // tslint:disable-next-line - Disables all
    this.stateGroupOptions = this.stateForm
      .get('stateGroup')!
      .valueChanges.pipe(
        startWith(''),
        map(value => this._filterGroup(value))
      );

    // 4

    this.filteredOptions = this.myControl.valueChanges.pipe(
      startWith<string | User>(''),
      map(value => (typeof value === 'string' ? value : value.name)),
      map(name => (name ? this._filter(name) : this.options1.slice()))
    );

    // 5

    this.filteredOptions1 = this.myControl2.valueChanges.pipe(
      startWith(''),
      map(value => this._filter1(value))
    );

    // 6
    this.filteredOptions2 = this.myControl.valueChanges.pipe(
      startWith(''),
      map(value => this._filter2(value))
    );
  }

  // 4

  displayFn(user?: User): string | undefined {
    return user ? user.name : undefined;
  }

  private _filterGroup(value: string): StateGroup[] {
    if (value) {
      return this.stateGroups
        .map(group => ({
          letter: group.letter,
          names: _filter(group.names, value)
        }))
        .filter(group => group.names.length > 0);
    }

    return this.stateGroups;
  }

  private _filter(name: string): User[] {
    const filterValue = name.toLowerCase();

    return this.options1.filter(
      option => option.name.toLowerCase().indexOf(filterValue) === 0
    );
  }

  // 5

  private _filter1(value: string): string[] {
    const filterValue1 = value.toLowerCase();

    return this.options2.filter(option1 =>
      option1.toLowerCase().includes(filterValue1)
    );
  }

  // 6

  private _filter2(value: string): string[] {
    const filterValue2 = value.toLowerCase();

    return this.options3.filter(
      option => option.toLowerCase().indexOf(filterValue2) === 0
    );
  }
}
