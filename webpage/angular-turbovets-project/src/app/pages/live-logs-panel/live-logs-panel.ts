import { Component, OnInit, OnDestroy, ViewChild, ElementRef, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Subject, timer } from 'rxjs';
import { takeUntil, tap, switchMap } from 'rxjs/operators';

interface LogEntry {
  id: number;
  timestamp: Date;
  level: 'INFO' | 'WARN' | 'ERROR' | 'DEBUG';
  source: string;
  message: string;
}

@Component({
  selector: 'app-live-logs-panel',
  imports: [CommonModule],
  templateUrl: './live-logs-panel.html',
  styleUrl: './live-logs-panel.css',
})
export class LiveLogsPanel implements OnInit, OnDestroy {
  @ViewChild('logContainer') private logContainer!: ElementRef;

  logs: LogEntry[] = [];
  isRunning = true;
  autoScroll = true;
  private destroy$ = new Subject<void>();
  private pause$ = new Subject<void>();
  private logIdCounter = 0;

  constructor(private cdr: ChangeDetectorRef) {}

  private readonly sources = [
    'AuthService',
    'APIGateway',
    'DatabasePool',
    'CacheManager',
    'WebSocketHandler',
    'TicketProcessor',
    'NotificationService',
    'PaymentGateway',
    'UserSession',
    'FileUploader'
  ];

  private readonly infoMessages = [
    'Request processed successfully',
    'User authenticated',
    'Session started',
    'Cache refreshed',
    'Connection established',
    'Data synchronized',
    'Ticket updated',
    'Notification sent',
    'File uploaded successfully',
    'Background job completed'
  ];

  private readonly warnMessages = [
    'High memory usage detected',
    'Slow query execution (>2s)',
    'Rate limit approaching',
    'Deprecated API endpoint called',
    'Cache miss ratio increasing',
    'Connection pool running low',
    'Retry attempt #3',
    'Token expiring soon',
    'Disk space below 20%',
    'Response time degraded'
  ];

  private readonly errorMessages = [
    'Failed to connect to database',
    'Authentication failed',
    'Request timeout after 30s',
    'Invalid payload received',
    'Service unavailable',
    'Permission denied',
    'Resource not found',
    'Rate limit exceeded',
    'Internal server error',
    'Connection refused'
  ];

  private readonly debugMessages = [
    'Entering method processTicket()',
    'Query executed in 45ms',
    'Cache key generated: usr_12345',
    'WebSocket ping received',
    'Parsing JSON payload',
    'Validating request headers',
    'Loading configuration',
    'Initializing connection pool',
    'Scheduling background task',
    'Serializing response data'
  ];

  ngOnInit(): void {
    this.startLogging();
  }

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }

  startLogging(): void {
    this.isRunning = true;
    this.runLogLoop();
  }

  private runLogLoop(): void {
    const randomDelay = this.getRandomInterval();
    
    timer(randomDelay).pipe(
      takeUntil(this.destroy$),
      takeUntil(this.pause$),
      tap(() => {
        this.addRandomLog();
        if (this.isRunning) {
          this.runLogLoop();
        }
      })
    ).subscribe();
  }

  stopLogging(): void {
    this.pause$.next();
    this.isRunning = false;
  }

  toggleLogging(): void {
    if (this.isRunning) {
      this.stopLogging();
    } else {
      this.startLogging();
    }
  }

  clearLogs(): void {
    this.logs = [];
  }

  toggleAutoScroll(): void {
    this.autoScroll = !this.autoScroll;
    if (this.autoScroll) {
      this.scrollToBottom();
    }
  }

  private addRandomLog(): void {
    const log = this.generateRandomLog();
    this.logs = [...this.logs, log];
    this.cdr.detectChanges();
    
    if (this.autoScroll) {
      setTimeout(() => this.scrollToBottom(), 0);
    }

    // Keep only last 500 logs to prevent memory issues
    if (this.logs.length > 500) {
      this.logs = this.logs.slice(-500);
    }
  }

  private generateRandomLog(): LogEntry {
    const level = this.getRandomLevel();
    return {
      id: ++this.logIdCounter,
      timestamp: new Date(),
      level,
      source: this.sources[Math.floor(Math.random() * this.sources.length)],
      message: this.getMessageForLevel(level)
    };
  }

  private getRandomLevel(): 'INFO' | 'WARN' | 'ERROR' | 'DEBUG' {
    const rand = Math.random();
    if (rand < 0.5) return 'INFO';
    if (rand < 0.7) return 'DEBUG';
    if (rand < 0.9) return 'WARN';
    return 'ERROR';
  }

  private getMessageForLevel(level: string): string {
    switch (level) {
      case 'INFO':
        return this.infoMessages[Math.floor(Math.random() * this.infoMessages.length)];
      case 'WARN':
        return this.warnMessages[Math.floor(Math.random() * this.warnMessages.length)];
      case 'ERROR':
        return this.errorMessages[Math.floor(Math.random() * this.errorMessages.length)];
      case 'DEBUG':
        return this.debugMessages[Math.floor(Math.random() * this.debugMessages.length)];
      default:
        return 'Unknown log message';
    }
  }

  private getRandomInterval(): number {
    // Random interval between 2000ms and 5000ms (2-5 seconds)
    return Math.floor(Math.random() * 3000) + 2000;
  }

  private scrollToBottom(): void {
    if (this.logContainer) {
      const container = this.logContainer.nativeElement;
      container.scrollTop = container.scrollHeight;
    }
  }

  getLevelClass(level: string): string {
    return `log-${level.toLowerCase()}`;
  }

  formatTimestamp(date: Date): string {
    return date.toLocaleTimeString('en-US', {
      hour12: false,
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit',
      fractionalSecondDigits: 3
    } as Intl.DateTimeFormatOptions);
  }
}
