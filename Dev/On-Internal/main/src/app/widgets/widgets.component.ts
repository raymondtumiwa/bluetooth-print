import { Component, AfterViewInit } from '@angular/core';

@Component({
  selector: 'app-widgets',
  templateUrl: './widgets.component.html',
  styleUrls: ['./widgets.component.scss']
})
export class WidgetsComponent implements AfterViewInit {
  // Timeline
  mytimelines: any[] = [
    {
      from: 'Nirav joshi',
      time: '(5 minute ago)',
      image: 'assets/images/users/1.jpg',
      attachment: 'assets/images/big/img2.jpg',
      content:
        // tslint:disable-next-line:max-line-length
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper'
    },
    {
      from: 'Sunil joshi',
      time: '(3 minute ago)',
      image: 'assets/images/users/2.jpg',
      content:
        // tslint:disable-next-line:max-line-length
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper',
      buttons: 'primary'
    },
    {
      from: 'Vishal Bhatt',
      time: '(1 minute ago)',
      image: 'assets/images/users/3.jpg',
      attachment: 'assets/images/big/img1.jpg',
      content:
        // tslint:disable-next-line:max-line-length
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper'
    },
    {
      from: 'Dhiren Adesara',
      time: '(1 minute ago)',
      image: 'assets/images/users/4.jpg',
      content:
        // tslint:disable-next-line:max-line-length
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper',
      buttons: 'warn'
    }
  ];

  ngAfterViewInit(): void {

  }
}
