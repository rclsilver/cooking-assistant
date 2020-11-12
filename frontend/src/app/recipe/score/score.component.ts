import { Component, Input, OnInit } from '@angular/core';
import { Recipe } from 'src/app/@models/recipe';

@Component({
  selector: 'app-recipe-score',
  templateUrl: './score.component.html',
  styleUrls: ['./score.component.scss']
})
export class RecipeScoreComponent implements OnInit {
  @Input() recipe: Recipe;

  constructor() { }

  ngOnInit(): void {
  }

}
