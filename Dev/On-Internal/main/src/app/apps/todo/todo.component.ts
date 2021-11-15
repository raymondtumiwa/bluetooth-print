import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { ToDo } from './todo';
import { TodoService } from './todo.service';

@Component({
    selector: 'app-todo',
    templateUrl: './todo.component.html',
    styleUrls: ['./todo.component.scss']
})
export class TodoComponent implements OnInit {

    sidePanelOpened = true;
    public showSidebar = false;
    inputFg: FormGroup = Object.create(null);
    todoId = 6;
    copyTodos: ToDo[];
    selectedCategory = 'all';
    searchText: string | null = null;
    editSave = 'Edit';

    todos: ToDo[] = this.todoService.getTodos();

    constructor(public fb: FormBuilder, public todoService: TodoService) {
        this.copyTodos = this.todos;
    }

    isOver(): boolean {
        return window.matchMedia(`(max-width: 960px)`).matches;
    }

    mobileSidebar(): void {
        this.showSidebar = !this.showSidebar;
    }

    ngOnInit(): void {
        this.inputFg = this.fb.group({
            mess: []
        });
    }

    addTodo(value: string): void {
        if (this.inputFg?.get('mess')?.value.trim().length === 0) {
            return;
        }
        this.todos.splice(0, 0,
            {
                id: this.todoId,
                message: this.inputFg?.get('mess')?.value,
                completionStatus: false,
                edit: false,
                date: new Date()
            }
        );
        this.copyTodos = this.todos;
        this.todoId++;
        this.inputFg.patchValue({
            mess: '',
        });
    }

    allTodos(): void {
        // tslint:disable-next-line - Disables all
        this.todos.forEach(todo => todo.completionStatus = (<HTMLInputElement>event!.target).checked);
    }

    selectionlblClick(val: string): void {
        if (val === 'all') {
            this.copyTodos = this.todos;
            this.selectedCategory = 'all';
        } else if (val === 'uncomplete') {
            this.copyTodos = this.todos.filter(todo => !todo.completionStatus);
            this.selectedCategory = 'uncomplete';
        } else if (val === 'complete') {
            this.copyTodos = this.todos.filter(x => x.completionStatus);
            this.selectedCategory = 'complete';
        }
    }

    editTodo(i: number, str: string): void {
        if (this.copyTodos) {
            if (str === 'edit') {
                // tslint:disable-next-line - Disables all
                this.copyTodos.find(x => x.id === i)!.edit = true;
            } else {
                // tslint:disable-next-line - Disables all
                this.copyTodos.find(x => x.id === i)!.edit = false;
            }
        }
    }

    deleteTodo(id: number): void {
        console.log(id);
        this.todos.splice(id, 1);
    }

    remainingList(): number {
        return this.todos.filter(todo => !todo.completionStatus).length;
    }

}
