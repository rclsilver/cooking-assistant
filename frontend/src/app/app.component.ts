import { BreakpointObserver, Breakpoints } from '@angular/cdk/layout';
import { Component, OnInit } from '@angular/core';
import { UserInfo } from 'angular-oauth2-oidc';
import { Observable } from 'rxjs';
import { map, shareReplay } from 'rxjs/operators';
import { AuthService } from './auth/auth.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit {
  isHandset$: Observable<boolean> = this.breakpointObserver
    .observe(Breakpoints.Handset)
    .pipe(
      map((result) => result.matches),
      shareReplay()
    );

  isLoading$: Observable<boolean>;
  isAuthenticated$: Observable<boolean>;
  isAdministrator$: Observable<boolean>;

  constructor(
    private breakpointObserver: BreakpointObserver,
    private auth: AuthService
  ) {
    this.isLoading$ = this.auth.isDoneLoading$.pipe(map((result) => !result));
    this.isAuthenticated$ = this.auth.isAuthenticated$;
    this.isAdministrator$ = this.auth.isAdministrator$;
  }

  ngOnInit(): void {
    this.auth.init();
  }

  login(): void {
    this.auth.login();
  }

  logout(): void {
    this.auth.logout();
  }

  get identity(): UserInfo {
    return this.auth.identity;
  }
}
