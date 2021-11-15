import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-activity',
  templateUrl: './activity.component.html',
  styleUrls: ['./activity.component.scss']
})
export class ActivityComponent implements OnInit {

      // Timeline
      mytimelines = [
        {
            from: 'Nirav joshi',
            time: '(5 minute ago)',
            image: 'assets/images/users/1.jpg',
            attachment: 'assets/images/big/img2.jpg',
            content:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero.'
        },
        {
            from: 'Sunil joshi',
            time: '(3 minute ago)',
            image: 'assets/images/users/2.jpg',
            content:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero.',
            buttons: 'primary'
        },
        {
            from: 'Vishal Bhatt',
            time: '(1 minute ago)',
            image: 'assets/images/users/3.jpg',
            attachment: 'assets/images/big/img1.jpg',
            content:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero.'
        },
        {
            from: 'Dhiren Adesara',
            time: '(1 minute ago)',
            image: 'assets/images/users/4.jpg',
            content:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero.',
            buttons: 'warn'
        }
    ];

  constructor() { }

  ngOnInit(): void {
  }

}
