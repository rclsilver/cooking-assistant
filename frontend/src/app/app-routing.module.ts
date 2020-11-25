import { NgModule } from '@angular/core';
import { Routes, RouterModule, ExtraOptions } from '@angular/router';
import { AboutComponent } from './about/about.component';
import { RequireUserGuard } from './core/require-user.guard';
import { PageNotFoundComponent } from './errors/page-not-found/page-not-found.component';
import { WeeklyPlanningComponent } from './planning/weekly-planning/weekly-planning.component';
import { RecipeFormComponent } from './recipe/recipe-form/recipe-form.component';
import { RecipeListComponent } from './recipe/recipe-list/recipe-list.component';

const routes: Routes = [
  {
    path: 'recipes',
    component: RecipeListComponent,
  },
  {
    path: 'recipes/add',
    component: RecipeFormComponent,
    canActivate: [RequireUserGuard],
  },
  {
    path: 'planning',
    component: WeeklyPlanningComponent,
    canActivate: [RequireUserGuard],
  },
  {
    path: 'planning/:date',
    component: WeeklyPlanningComponent,
    canActivate: [RequireUserGuard],
  },
  {
    path: 'about',
    component: AboutComponent,
  },
  {
    path: '',
    redirectTo: '/recipes',
    pathMatch: 'full',
  },
  {
    path: '**',
    component: PageNotFoundComponent,
  },
];

const config: ExtraOptions = {
  useHash: true,
  initialNavigation: 'disabled'
};

@NgModule({
  imports: [RouterModule.forRoot(routes, config)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
