import { Component, OnInit } from '@angular/core';
import { Maticons } from './mat-icon-services';
import { MATICONS } from './mock-mat-icon';
@Component({
  selector: 'app-icon',
  templateUrl: './mat-icon.component.html',
  styleUrls: ['./mat-icon.component.scss']
})
export class MatIconComponent implements OnInit {
  maticons = MATICONS;

  selectedMaticons: Maticons = Object.create(null);

  constructor() { }

  ngOnInit(): void { }
}
