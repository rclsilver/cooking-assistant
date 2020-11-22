import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { Recipe } from 'src/app/@models/recipe';
import { ApiService } from 'src/app/core/api.service';
import { AuthService } from 'src/app/core/auth.service';

@Component({
  selector: 'app-recipe-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.scss'],
})
export class RecipeListComponent implements OnInit {
  public recipes: Array<Recipe> = [];
  public canAddRecipe: Observable<boolean>;

  constructor(
    protected readonly api: ApiService,
    protected readonly auth: AuthService
  ) {
    this.canAddRecipe = this.auth.canActivateProtectedRoutes$;
  }

  ngOnInit(): void {
    this.api.getRecipes().subscribe(
      (recipes: Array<Recipe>) => {
        this.recipes = recipes;
      },
      (e: any) => {
        console.error('Error while loading recipes');
        console.error(e);
      }
    );
  }

  onRecipeDeleted(recipe: Recipe): void {
    this.recipes = this.recipes.filter(item => item.id != recipe.id)
  }
}
