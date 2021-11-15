import { FlatTreeControl } from '@angular/cdk/tree';
import { Component, Injectable } from '@angular/core';
import { MatTreeFlatDataSource, MatTreeFlattener } from '@angular/material/tree';
import { BehaviorSubject, Observable } from 'rxjs';


const LOAD_MORE = 'LOAD_MORE';

/** Nested node */
export class LoadmoreNode {
    childrenChange = new BehaviorSubject<LoadmoreNode[]>([]);

    get children(): LoadmoreNode[] {
        return this.childrenChange.value;
    }

    constructor(public item: string, public hasChildren = false, public loadMoreParentItem: string | null = null) {

    }
}

/** Flat node with expandable and level information */
export class LoadmoreFlatNode {
    constructor(public item: string, public level = 1, public expandable = false, public loadMoreParentItem: string | null = null) {

    }
}

/**
 * A database that only load part of the data initially. After user clicks on the `Load more`
 * button, more data will be loaded.
 */
@Injectable()
export class LoadmoreDatabase {
    batchNumber = 5;
    dataChange = new BehaviorSubject<LoadmoreNode[]>([]);
    nodeMap = new Map<string, LoadmoreNode>();
    // tslint:disable-next-line - Disables all
    rootLevelNodes: string[] = ['Vegetables', 'Fruits'];
    dataMap = new Map<string, string[]>([
        ['Fruits', ['Apple', 'Orange', 'Banana']],
        ['Vegetables', ['Tomato', 'Potato', 'Onion']],
        ['Apple', ['Fuji', 'Macintosh']],
        ['Onion', ['Yellow', 'White', 'Purple', 'Green', 'Shallot', 'Sweet', 'Red', 'Leek']],
    ]);

    initialize(): void {
        const data = this.rootLevelNodes.map(name => this._generateNode(name));
        this.dataChange.next(data);
    }

    /** Expand a node whose children are not loaded */
    loadMore(item: string, onlyFirstTime = false): void {
        if (!this.nodeMap.has(item) || !this.dataMap.has(item)) {
            return;
        }
        // tslint:disable-next-line: no-non-null-assertion
        const parent = this.nodeMap.get(item)!;
        // tslint:disable-next-line: no-non-null-assertion
        const children = this.dataMap.get(item)!;
        // tslint:disable-next-line: no-non-null-assertion
        if (onlyFirstTime && parent.children!.length > 0) {
            return;
        }

        // tslint:disable-next-line: no-non-null-assertion
        const newChildrenNumber = parent.children!.length + this.batchNumber;
        const nodes = children.slice(0, newChildrenNumber)
            .map(name => this._generateNode(name));
        if (newChildrenNumber < children.length) {
            // Need a new load more node
            nodes.push(new LoadmoreNode(LOAD_MORE, false, item));
        }

        parent.childrenChange.next(nodes);
        this.dataChange.next(this.dataChange.value);
    }

    private _generateNode(item: string): LoadmoreNode {
        if (this.nodeMap.has(item)) {
            // tslint:disable-next-line: no-non-null-assertion
            return this.nodeMap.get(item)!;
        }
        const result = new LoadmoreNode(item, this.dataMap.has(item));
        this.nodeMap.set(item, result);
        return result;
    }
}


@Component({
    selector: 'app-load-tree',
    templateUrl: './load-tree.component.html',
    styleUrls: ['./load-tree.component.scss'],
    providers: [LoadmoreDatabase]
})
export class LoadtreeComponent {

    nodeMap = new Map<string, LoadmoreFlatNode>();
    treeControl: FlatTreeControl<LoadmoreFlatNode>;
    treeFlattener: MatTreeFlattener<LoadmoreNode, LoadmoreFlatNode>;
    // Flat tree data source
    dataSource: MatTreeFlatDataSource<LoadmoreNode, LoadmoreFlatNode>;

    constructor(
        // tslint:disable-next-line - Disables all
        private _database: LoadmoreDatabase) {
        this.treeFlattener = new MatTreeFlattener(this.transformer, this.getLevel, this.isExpandable, this.getChildren);

        this.treeControl = new FlatTreeControl<LoadmoreFlatNode>(this.getLevel, this.isExpandable);

        this.dataSource = new MatTreeFlatDataSource(this.treeControl, this.treeFlattener);

        _database.dataChange.subscribe(data => {
            this.dataSource.data = data;
        });

        _database.initialize();
    }

    getChildren = (node: LoadmoreNode): Observable<LoadmoreNode[]> => node.childrenChange;

    transformer = (node: LoadmoreNode, level: number) => {
        const existingNode = this.nodeMap.get(node.item);

        if (existingNode) {
            return existingNode;
        }

        const newNode =
            new LoadmoreFlatNode(node.item, level, node.hasChildren, node.loadMoreParentItem);
        this.nodeMap.set(node.item, newNode);
        return newNode;
    }

    getLevel = (node: LoadmoreFlatNode) => node.level;
    // tslint:disable-next-line - Disables all
    isExpandable = (node: LoadmoreFlatNode) => node.expandable;
    // tslint:disable-next-line - Disables all
    hasChild = (_: number, _nodeData: LoadmoreFlatNode) => _nodeData.expandable;
    // tslint:disable-next-line - Disables all
    isLoadMore = (_: number, _nodeData: LoadmoreFlatNode) => _nodeData.item === LOAD_MORE;

    /** Load more nodes from data source */
    loadMore(item: string): void {
        this._database.loadMore(item);
    }

    loadChildren(node: LoadmoreFlatNode): void {
        this._database.loadMore(node.item, true);
    }
}
