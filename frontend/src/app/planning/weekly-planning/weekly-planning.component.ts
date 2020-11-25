import { Component, Output } from '@angular/core';
import { ActivatedRoute, Params } from '@angular/router';
import { Observable, ReplaySubject} from 'rxjs';
import { Day, Planning } from 'src/app/@models/planning';
import { Recipe } from 'src/app/@models/recipe';
import { ApiService } from 'src/app/core/api.service';

@Component({
  selector: 'app-weekly-planning',
  templateUrl: './weekly-planning.component.html',
  styleUrls: ['./weekly-planning.component.scss'],
})
export class WeeklyPlanningComponent {
  private date: Date = new Date();
  private planningSubject$ = new ReplaySubject<Planning>();
  private recipes: Array<Recipe>;

  @Output()
  planning: Observable<Planning> = this.planningSubject$.asObservable();

  constructor(private route: ActivatedRoute, private api: ApiService) {
    this.route.params.subscribe((params: Params) => {
      if (params.date) {
        this.date = new Date(Date.parse(params.date));
      } else {
        this.date = new Date();
      }

      this.api.getRecipes().subscribe((recipes: Array<Recipe>) => {
        this.recipes = recipes;
        this.refresh();
      });
    });
  }

  refresh(): void {
    let planning = new Planning(this.date);

    for(
      let date = new Date(planning.startDate);
      date < planning.nextDate;
      date.setDate(date.getDate() + 1)
    ) {
      let day: Day = new Day();
      day.date = new Date(date);
      day.recipes = [];

      let recipesCount = Math.floor(Math.random() * Math.floor(5));

      for (let i = 0; i < recipesCount; ++i) {
        let recipeIndex = Math.floor(Math.random() * Math.floor(this.recipes.length));
        day.recipes.push(this.recipes[recipeIndex]);
      }

      planning.days.push(day);
    }

    this.planningSubject$.next(planning);
  }
}
