import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-memberpertama',
  templateUrl: './memberpertama.component.html',
  styleUrls: ['./memberpertama.component.scss']
})
export class MemberpertamaComponent{

  typesOfShoes = ['Boots', 'Clogs', 'Loafers', 'Moccasins', 'Sneakers'];
  messages = [
    {
      from: 'Email',
      image: 'assets/images/users/1.jpg',
      subject: 'rivenlumangkun@gmail.com',
    },
    {
      from: 'Facebook',
      image: 'assets/images/users/2.jpg',
      subject: 'Riven Lumangkun',
    },
    {
      from: 'Instagram',
      image: 'assets/images/users/3.jpg',
      subject: 'rdlumangkun',
    }
  ];

  folders = [
    {
      name: 'Photos',
      updated: new Date('1/1/16')
    },
    {
      name: 'Recipes',
      updated: new Date('1/17/16')
    },
    {
      name: 'Work',
      updated: new Date('1/28/16')
    }
  ];
  notes = [
    {
      name: 'Vacation Itinerary',
      updated: new Date('2/20/16')
    },
    {
      name: 'Kitchen Remodel',
      updated: new Date('1/18/16')
    }
  ];
}
