import { Component, Input, OnInit } from '@angular/core';
import { Recipe } from 'src/app/@models/recipe';

@Component({
  selector: 'app-recipe-card',
  templateUrl: './card.component.html',
  styleUrls: ['./card.component.scss']
})
export class RecipeCardComponent implements OnInit {
  @Input() recipe: Recipe;

  constructor() { }

  ngOnInit(): void {
  }
}
