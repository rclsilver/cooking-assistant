import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Recipe } from '../@models/recipe';

@Injectable({ providedIn: 'root' })
export class ApiService {
  constructor(private http: HttpClient) {}

  me(): Observable<any> {
    return this.http.get<any>('/api/me');
  }

  getRecipes(): Observable<Array<Recipe>> {
    return this.http.get<Array<Recipe>>('/api/recipes/');
  }

  createRecipe(recipe: Recipe): Observable<Recipe> {
    return this.http.post<Recipe>('/api/recipes/', recipe);
  }

  deleteRecipe(recipe: Recipe): Observable<null> {
    return this.http.delete<null>(`/api/recipes/${recipe.id}`);
  };
};
