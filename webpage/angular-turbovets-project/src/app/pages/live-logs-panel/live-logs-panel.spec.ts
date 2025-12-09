import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LiveLogsPanel } from './live-logs-panel';

describe('LiveLogsPanel', () => {
  let component: LiveLogsPanel;
  let fixture: ComponentFixture<LiveLogsPanel>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [LiveLogsPanel]
    })
    .compileComponents();

    fixture = TestBed.createComponent(LiveLogsPanel);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
