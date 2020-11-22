import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { Observable } from 'rxjs';
import { Recipe } from 'src/app/@models/recipe';
import { ApiService } from 'src/app/core/api.service';
import { AuthService } from 'src/app/core/auth.service';

@Component({
  selector: 'app-recipe-card',
  templateUrl: './card.component.html',
  styleUrls: ['./card.component.scss'],
})
export class RecipeCardComponent implements OnInit {
  public canDeleteRecipe: Observable<boolean>;

  @Input() recipe: Recipe;
  @Output() deleteEvent: EventEmitter<Recipe> = new EventEmitter<Recipe>();

  constructor(
    private auth: AuthService,
    private api: ApiService
  ) {
    this.canDeleteRecipe = this.auth.canActivateAdministrativeRoutes$;
  }

  ngOnInit(): void {}

  deleteRecipe(): void {
    this.api.deleteRecipe(this.recipe).subscribe(() => this.deleteEvent.emit(this.recipe));
  }
}
