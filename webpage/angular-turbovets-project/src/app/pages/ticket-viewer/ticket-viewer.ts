import { Component, signal, computed } from '@angular/core';

interface Ticket {
  id: string;
  subject: string;
  status: 'Open' | 'In Progress' | 'Closed';
  createdAt: Date;
}

@Component({
  selector: 'app-ticket-viewer',
  imports: [],
  templateUrl: './ticket-viewer.html',
  styleUrl: './ticket-viewer.css',
})
export class TicketViewer {
  activeFilter = signal<'All' | 'Open' | 'In Progress' | 'Closed'>('All');

  tickets = signal<Ticket[]>([
    { id: 'TKT-001', subject: 'Unable to login to dashboard', status: 'Open', createdAt: new Date('2024-12-01') },
    { id: 'TKT-002', subject: 'Payment processing error', status: 'In Progress', createdAt: new Date('2024-12-02') },
    { id: 'TKT-003', subject: 'Feature request: Dark mode', status: 'Closed', createdAt: new Date('2024-12-03') },
    { id: 'TKT-004', subject: 'App crashes on startup', status: 'Open', createdAt: new Date('2024-12-04') },
    { id: 'TKT-005', subject: 'Slow performance on mobile', status: 'In Progress', createdAt: new Date('2024-12-05') },
    { id: 'TKT-006', subject: 'Email notifications not working', status: 'Open', createdAt: new Date('2024-12-06') },
    { id: 'TKT-007', subject: 'Password reset issue', status: 'Closed', createdAt: new Date('2024-12-07') },
    { id: 'TKT-008', subject: 'Data export failing', status: 'In Progress', createdAt: new Date('2024-12-07') },
  ]);

  filteredTickets = computed(() => {
    const filter = this.activeFilter();
    if (filter === 'All') {
      return this.tickets();
    }
    return this.tickets().filter(ticket => ticket.status === filter);
  });

  setFilter(filter: 'All' | 'Open' | 'In Progress' | 'Closed') {
    this.activeFilter.set(filter);
  }

  getStatusClass(status: string): string {
    return status.toLowerCase().replace(' ', '-');
  }
}
