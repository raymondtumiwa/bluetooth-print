import { SelectionModel } from '@angular/cdk/collections';
import { Component, OnInit, ViewChild } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { MatSort } from '@angular/material/sort';
import { BreakpointObserver, Breakpoints, BreakpointState } from '@angular/cdk/layout';

import {
    animate,
    state,
    style,
    transition,
    trigger
} from '@angular/animations';

// Start For 1
export interface PeriodicElement {
    name: string;
    position: number;
    weight: number;
    theme: string;
}

const ELEMENT_DATA: PeriodicElement[] = [
    { position: 1, name: 'Hydrogen', weight: 1.0079, theme: 'H' },
    { position: 2, name: 'Helium', weight: 4.0026, theme: 'He' },
    { position: 3, name: 'Lithium', weight: 6.941, theme: 'Li' },
    { position: 4, name: 'Beryllium', weight: 9.0122, theme: 'Be' },
    { position: 5, name: 'Boron', weight: 10.811, theme: 'B' },
    { position: 6, name: 'Carbon', weight: 12.0107, theme: 'C' },
    { position: 7, name: 'Nitrogen', weight: 14.0067, theme: 'N' },
    { position: 8, name: 'Oxygen', weight: 15.9994, theme: 'O' },
    { position: 9, name: 'Fluorine', weight: 18.9984, theme: 'F' },
    { position: 10, name: 'Neon', weight: 20.1797, theme: 'Ne' }
];
// End For 1

// Start for 2
export interface Exapandable {
    name: string;
    position: number;
    weight: number;
    symbol: string;
    description: string;
}

const MY_DATA: Exapandable[] = [
    {
        position: 1,
        name: 'Hydrogen',
        weight: 1.0079,
        symbol: 'H',
        description: `Hydrogen is a chemical element with symbol H and atomic number 1. With a standard
        atomic weight of 1.008, hydrogen is the lightest element on the periodic table.`
    },
    {
        position: 2,
        name: 'Helium',
        weight: 4.0026,
        symbol: 'He',
        description: `Helium is a chemical element with symbol He and atomic number 2. It is a
        colorless, odorless, tasteless, non-toxic, inert, monatomic gas, the first in the noble gas
        group in the periodic table. Its boiling point is the lowest among all the elements.`
    },
    {
        position: 3,
        name: 'Lithium',
        weight: 6.941,
        symbol: 'Li',
        description: `Lithium is a chemical element with symbol Li and atomic number 3. It is a soft,
        silvery-white alkali metal. Under standard conditions, it is the lightest metal and the
        lightest solid element.`
    },
    {
        position: 4,
        name: 'Beryllium',
        weight: 9.0122,
        symbol: 'Be',
        description: `Beryllium is a chemical element with symbol Be and atomic number 4. It is a
        relatively rare element in the universe, usually occurring as a product of the spallation of
        larger atomic nuclei that have collided with cosmic rays.`
    },
    {
        position: 5,
        name: 'Boron',
        weight: 10.811,
        symbol: 'B',
        description: `Boron is a chemical element with symbol B and atomic number 5. Produced entirely
        by cosmic ray spallation and supernovae and not by stellar nucleosynthesis, it is a
        low-abundance element in the Solar system and in the Earth's crust.`
    },
    {
        position: 6,
        name: 'Carbon',
        weight: 12.0107,
        symbol: 'C',
        description: `Carbon is a chemical element with symbol C and atomic number 6. It is nonmetallic
        and tetravalent—making four electrons available to form covalent chemical bonds. It belongs
        to group 14 of the periodic table.`
    },
    {
        position: 7,
        name: 'Nitrogen',
        weight: 14.0067,
        symbol: 'N',
        description: `Nitrogen is a chemical element with symbol N and atomic number 7. It was first
        discovered and isolated by Scottish physician Daniel Rutherford in 1772.`
    },
    {
        position: 8,
        name: 'Oxygen',
        weight: 15.9994,
        symbol: 'O',
        description: `Oxygen is a chemical element with symbol O and atomic number 8. It is a member of
         the chalcogen group on the periodic table, a highly reactive nonmetal, and an oxidizing
         agent that readily forms oxides with most elements as well as with other compounds.`
    },
    {
        position: 9,
        name: 'Fluorine',
        weight: 18.9984,
        symbol: 'F',
        description: `Fluorine is a chemical element with symbol F and atomic number 9. It is the
        lightest halogen and exists as a highly toxic pale yellow diatomic gas at standard
        conditions.`
    },
    {
        position: 10,
        name: 'Neon',
        weight: 20.1797,
        symbol: 'Ne',
        description: `Neon is a chemical element with symbol Ne and atomic number 10. It is a noble gas.
        Neon is a colorless, odorless, inert monatomic gas under standard conditions, with about
        two-thirds the density of air.`
    }
];
// End for 2

// Start for 3
export interface Selection {
    name: string;
    position: number;
    weight: number;
    symbol: string;
}

const SELECT_DATA: Selection[] = [
    { position: 1, name: 'Hydrogen', weight: 1.0079, symbol: 'H' },
    { position: 2, name: 'Helium', weight: 4.0026, symbol: 'He' },
    { position: 3, name: 'Lithium', weight: 6.941, symbol: 'Li' },
    { position: 4, name: 'Beryllium', weight: 9.0122, symbol: 'Be' },
    { position: 5, name: 'Boron', weight: 10.811, symbol: 'B' },
    { position: 6, name: 'Carbon', weight: 12.0107, symbol: 'C' },
    { position: 7, name: 'Nitrogen', weight: 14.0067, symbol: 'N' },
    { position: 8, name: 'Oxygen', weight: 15.9994, symbol: 'O' },
    { position: 9, name: 'Fluorine', weight: 18.9984, symbol: 'F' },
    { position: 10, name: 'Neon', weight: 20.1797, symbol: 'Ne' }
];
// End for 3

// Start for 4
export interface Sorting {
    name: string;
    position: number;
    weight: number;
    symbol: string;
}

const SORT_DATA: Sorting[] = [
    { position: 1, name: 'Hydrogen', weight: 1.0079, symbol: 'H' },
    { position: 2, name: 'Helium', weight: 4.0026, symbol: 'He' },
    { position: 3, name: 'Lithium', weight: 6.941, symbol: 'Li' },
    { position: 4, name: 'Beryllium', weight: 9.0122, symbol: 'Be' },
    { position: 5, name: 'Boron', weight: 10.811, symbol: 'B' },
    { position: 6, name: 'Carbon', weight: 12.0107, symbol: 'C' },
    { position: 7, name: 'Nitrogen', weight: 14.0067, symbol: 'N' },
    { position: 8, name: 'Oxygen', weight: 15.9994, symbol: 'O' },
    { position: 9, name: 'Fluorine', weight: 18.9984, symbol: 'F' },
    { position: 10, name: 'Neon', weight: 20.1797, symbol: 'Ne' }
];
// End for 4
@Component({
    selector: 'app-material-table',
    templateUrl: './materialtable.component.html',
    styleUrls: ['./materialtable.component.scss'],
    animations: [
        trigger('detailExpand', [
            state(
                'collapsed',
                style({ height: '0px', minHeight: '0', display: 'none' })
            ),
            state('expanded', style({ height: '*' })),
            transition(
                'expanded <=> collapsed',
                animate('225ms cubic-bezier(0.4, 0.0, 0.2, 1)')
            )
        ])
    ]
})
export class MaterialTableComponent implements OnInit {
    // Start 1
    constructor(breakpointObserver: BreakpointObserver) {
        breakpointObserver.observe(['(max-width: 600px)']).subscribe(result => {
            // For 1
            this.displayedColumns = result.matches ?
                ['name', 'weight', 'theme', 'position'] :
                ['name', 'weight', 'theme', 'position'];
            // For 2
            this.columnsToDisplay1 = result.matches ?
                ['name', 'weight', 'theme', 'position'] :
                ['name', 'weight', 'theme', 'position'];

            // For 3
            this.displayedColumns2 = result.matches ?
                ['select', 'position', 'name', 'weight', 'symbol'] :
                ['select', 'position', 'name', 'weight', 'symbol'];

            // For 4
            this.displayedColumns3 = result.matches ?
                ['position', 'name', 'weight', 'symbol'] :
                ['position', 'name', 'weight', 'symbol'];
        });
    }


    displayedColumns: string[] = ['name', 'weight', 'theme', 'position'];
    columnsToDisplay: string[] = this.displayedColumns.slice();
    data: PeriodicElement[] = ELEMENT_DATA;
    // End 1

    // Start 2
    dataSource = ELEMENT_DATA;
    columnsToDisplay1 = ['name', 'weight', 'symbol', 'position'];
    expandedElement: Exapandable = Object.create(null);
    // End 2

    // Start For 3
    displayedColumns2: string[] = [
        'select',
        'position',
        'name',
        'weight',
        'symbol'
    ];

    dataSource2 = new MatTableDataSource<Selection>(SELECT_DATA);
    selection = new SelectionModel<Selection>(true, []);
    // End For 3

    // Start for 4
    displayedColumns3: string[] = ['position', 'name', 'weight', 'symbol'];
    dataSource3 = new MatTableDataSource(SORT_DATA);

    @ViewChild(MatSort, { static: true })
    sort: MatSort = Object.create(null);

    ngOnInit(): void {
        this.dataSource3.sort = this.sort;
    }

    // End for 4
    // 1
    addColumn(): void {
        const randomColumn = Math.floor(
            Math.random() * this.displayedColumns.length
        );
        this.columnsToDisplay.push(this.displayedColumns[randomColumn]);
    }

    removeColumn(): void {
        if (this.columnsToDisplay.length) {
            this.columnsToDisplay.pop();
        }
    }

    shuffle(): void {
        let currentIndex = this.columnsToDisplay.length;
        while (0 !== currentIndex) {
            const randomIndex = Math.floor(Math.random() * currentIndex);
            currentIndex -= 1;

            // Swap
            const temp = this.columnsToDisplay[currentIndex];
            this.columnsToDisplay[currentIndex] = this.columnsToDisplay[randomIndex];
            this.columnsToDisplay[randomIndex] = temp;
        }
    }
    // End 1

    // Start 3
    /** Whether the number of selected elements matches the total number of rows. */
    isAllSelected(): boolean {
        const numSelected = this.selection.selected.length;
        const numRows = this.dataSource2.data.length;
        return numSelected === numRows;
    }

    /** Selects all rows if they are not all selected; otherwise clear selection. */
    masterToggle(): void {
        this.isAllSelected()
            ? this.selection.clear()
            : this.dataSource2.data.forEach(row => this.selection.select(row));
    }
    // End 3
}
