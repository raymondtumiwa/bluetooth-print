import { Component} from '@angular/core';

@Component({
  selector: 'app-radiobutton',
  templateUrl: './radiobutton.component.html',
  styleUrls: ['./radiobutton.component.scss']
})
export class RadiobuttonComponent {
  favoriteSeason = '';
  seasons: string[] = ['Winter', 'Spring', 'Summer', 'Autumn'];
}
