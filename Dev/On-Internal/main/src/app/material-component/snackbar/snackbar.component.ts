import { Component } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';

@Component({
    selector: 'app-snackbar',
    templateUrl: './snackbar.component.html',
    styleUrls: ['./snackbar.component.scss']
})
export class SnackbarComponent {
    constructor(public snackBar: MatSnackBar) { }

    openSnackBar(message: string, action: string): void {
        this.snackBar.open(message, action, {
            duration: 2000
        });
    }
}
