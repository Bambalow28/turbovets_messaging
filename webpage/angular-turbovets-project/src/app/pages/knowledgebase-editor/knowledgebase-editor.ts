import { Component, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-knowledgebase-editor',
  imports: [FormsModule],
  templateUrl: './knowledgebase-editor.html',
  styleUrl: './knowledgebase-editor.css',
})
export class KnowledgebaseEditor {
  content = signal<string>(`# Welcome to the Knowledgebase

This is a **markdown editor** with live preview.

## Features

- Write markdown in the editor
- See live preview on the right
- Toggle between Edit and Preview modes

## Example Code

\`\`\`javascript
function hello() {
  console.log("Hello, World!");
}
\`\`\`

> This is a blockquote example.

Enjoy writing!`);

  isPreviewMode = signal(false);
  savedMessage = signal('');

  updateContent(event: Event) {
    const textarea = event.target as HTMLTextAreaElement;
    this.content.set(textarea.value);
  }

  togglePreview() {
    this.isPreviewMode.update(v => !v);
  }

  save() {
    // Simulate saving - in real app this would call a backend
    console.log('Saved content:', this.content());
    this.savedMessage.set('Content saved successfully!');
    setTimeout(() => this.savedMessage.set(''), 3000);
  }

  // Simple markdown to HTML conversion
  parseMarkdown(text: string): string {
    return text
      // Code blocks
      .replace(/```(\w*)\n([\s\S]*?)```/g, '<pre><code class="language-$1">$2</code></pre>')
      // Inline code
      .replace(/`([^`]+)`/g, '<code>$1</code>')
      // Headers
      .replace(/^### (.*$)/gm, '<h3>$1</h3>')
      .replace(/^## (.*$)/gm, '<h2>$1</h2>')
      .replace(/^# (.*$)/gm, '<h1>$1</h1>')
      // Bold
      .replace(/\*\*([^*]+)\*\*/g, '<strong>$1</strong>')
      // Italic
      .replace(/\*([^*]+)\*/g, '<em>$1</em>')
      // Blockquotes
      .replace(/^> (.*$)/gm, '<blockquote>$1</blockquote>')
      // Unordered lists
      .replace(/^- (.*$)/gm, '<li>$1</li>')
      // Wrap consecutive li elements in ul
      .replace(/(<li>.*<\/li>\n?)+/g, '<ul>$&</ul>')
      // Line breaks
      .replace(/\n\n/g, '</p><p>')
      .replace(/^(.+)$/gm, (match) => {
        if (match.startsWith('<')) return match;
        return match;
      });
  }
}
