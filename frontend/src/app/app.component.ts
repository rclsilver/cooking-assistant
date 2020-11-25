import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { Observable } from 'rxjs';
import { AuthService } from './core/auth.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
})
export class AppComponent {
  readonly isAuthenticated: Observable<boolean>;
  readonly isDoneLoading: Observable<boolean>;
  readonly canAccessPlanning: Observable<boolean>;

  constructor(private auth: AuthService, private router: Router) {
    this.isAuthenticated = this.auth.isAuthenticated$;
    this.isDoneLoading = this.auth.isDoneLoading$;
    this.canAccessPlanning = this.auth.canActivateProtectedRoutes$;

    this.auth.init()
      .then(_ => this.router.navigate(['/']));
  }
}
