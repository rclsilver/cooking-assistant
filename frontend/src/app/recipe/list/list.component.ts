import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { Recipe } from 'src/app/@models/recipe';

@Component({
  selector: 'app-recipe-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.scss'],
})
export class RecipeListComponent implements OnInit {
  public recipes: Array<Recipe> = [];

  constructor(
    private http: HttpClient
  ) { }

  ngOnInit(): void {
    this.http.get<Array<Recipe>>('/api/recipes/').subscribe(
      (recipes: Array<Recipe>) => {
        this.recipes = recipes;
      },
      (e: any) => {
        console.error('Error while loading recipes');
        console.log(e);
      }
    );
  }
}
