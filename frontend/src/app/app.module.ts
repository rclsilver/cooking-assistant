import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { RecipeListComponent } from './recipe/recipe-list/recipe-list.component';
import { AboutComponent } from './about/about.component';
import { PageNotFoundComponent } from './errors/page-not-found/page-not-found.component';
import { RecipeFormComponent } from './recipe/recipe-form/recipe-form.component';
import { ReactiveFormsModule } from '@angular/forms';
import { UserMenuComponent } from './user/user-menu/user-menu.component';
import { CoreModule } from './core/core.module';
import { WeeklyPlanningComponent } from './planning/weekly-planning/weekly-planning.component';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';

@NgModule({
  declarations: [
    AboutComponent,
    AppComponent,
    PageNotFoundComponent,
    RecipeFormComponent,
    RecipeListComponent,
    UserMenuComponent,
    WeeklyPlanningComponent
  ],
  imports: [
    BrowserModule,
    FontAwesomeModule,
    CoreModule.forRoot(),
    AppRoutingModule,
    ReactiveFormsModule
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}
