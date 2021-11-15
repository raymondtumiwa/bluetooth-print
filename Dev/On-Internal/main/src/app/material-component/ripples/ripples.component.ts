import { Component } from '@angular/core';

@Component({
  selector: 'app-ripples',
  templateUrl: './ripples.component.html',
  styleUrls: ['./ripples.component.scss']
})
export class RipplesComponent {
  centered = false;
  disabled = false;
  unbounded = false;

  radius = 0;
  color = '';
}
