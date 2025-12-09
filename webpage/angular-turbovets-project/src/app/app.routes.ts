import { Routes } from '@angular/router';
import { TicketViewer } from './pages/ticket-viewer/ticket-viewer';
import { KnowledgebaseEditor } from './pages/knowledgebase-editor/knowledgebase-editor';
import { LiveLogsPanel } from './pages/live-logs-panel/live-logs-panel';

export const routes: Routes = [
  { path: '', redirectTo: 'ticket-viewer', pathMatch: 'full' },
  { path: 'ticket-viewer', component: TicketViewer },
  { path: 'knowledgebase-editor', component: KnowledgebaseEditor },
  { path: 'live-logs', component: LiveLogsPanel },
];
