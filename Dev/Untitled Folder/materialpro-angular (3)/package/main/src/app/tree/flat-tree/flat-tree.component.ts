import { ArrayDataSource } from '@angular/cdk/collections';
import { FlatTreeControl } from '@angular/cdk/tree';
import { Component } from '@angular/core';

const TREE_DATA: ExampleFlatNode[] = [
  {
    name: 'Fruit',
    expandable: true,
    level: 0,
  }, {
    name: 'Apple',
    expandable: false,
    level: 1,
  }, {
    name: 'Banana',
    expandable: false,
    level: 1,
  }, {
    name: 'Fruit loops',
    expandable: false,
    level: 1,
  }, {
    name: 'Vegetables',
    expandable: true,
    level: 0,
  }, {
    name: 'Green',
    expandable: true,
    level: 1,
  }, {
    name: 'Broccoli',
    expandable: false,
    level: 2,
  }, {
    name: 'Brussels sprouts',
    expandable: false,
    level: 2,
  }, {
    name: 'Orange',
    expandable: true,
    level: 1,
  }, {
    name: 'Pumpkins',
    expandable: false,
    level: 2,
  }, {
    name: 'Carrots',
    expandable: false,
    level: 2,
  }
];

/** Flat node with expandable and level information */
interface ExampleFlatNode {
  expandable: boolean;
  name: string;
  level: number;
  isExpanded?: boolean;
}

@Component({
  selector: 'app-flat-tree',
  templateUrl: './flat-tree.component.html',
  styleUrls: ['./flat-tree.component.scss']
})
export class FlattreeComponent {

  treeControl = new FlatTreeControl<ExampleFlatNode>(
    node => node.level, node => node.expandable);

  dataSource = new ArrayDataSource(TREE_DATA);

  hasChild = (_: number, node: ExampleFlatNode) => node.expandable;

  getParentNode(node: ExampleFlatNode): any {
    const nodeIndex = TREE_DATA.indexOf(node);

    for (let i = nodeIndex - 1; i >= 0; i--) {
      if (TREE_DATA[i].level === node.level - 1) {
        return TREE_DATA[i];
      }
    }

    return null;
  }

  shouldRender(node: ExampleFlatNode): any {
    const parent = this.getParentNode(node);
    return !parent || parent.isExpanded;
  }
}
