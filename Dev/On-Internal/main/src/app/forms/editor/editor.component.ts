import { Component } from '@angular/core';

@Component({
  selector: 'app-editor',
  templateUrl: './editor.component.html',
  styleUrls: ['./editor.component.scss']
})
export class EditorComponent {
  subtitle: string;

  constructor() {
    this.subtitle = 'This is some text within a card block.';
  }
}
